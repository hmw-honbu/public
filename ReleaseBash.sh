#==================================================================
# ﾌﾟﾛｸﾞﾗﾑ名	ReleaseBash.sh
# 機能概要	リリース作業ディレクトリ作成
#------------------------------------------------------------------
# 起動時引数     1：対象リポジトリ
#               2：対象ブランチ（未設定の場合は「master」とする）
#------------------------------------------------------------------
# 改修履歴
# 2017/12/30	y.suetake		#48201	新規作成
#==================================================================
#!/bin/bash
set -Ceu

# 起動引数チェック
if [ ! -n "$1" ]; then
  echo 起動引数が不正です。処理を終了します。
  exit 1
fi

# 変数定義
dir=/c/ReleaseTemp          #作業ディレクトリ
targetRepo=$1               #対象リポジトリ

# 開始メッセージ
echo 処理を開始しています。しばらくお待ちください。。。

# C:\ReleaseTempディレクトリがない場合は生成
if [ ! -d $dir ]; then
    mkdir -p $dir
fi

# カレントディレクトリをC:\ReleaseTempに変更
cd $dir

# C:\ReleaseTemp内の対象リポジトリディレクトリを削除
if [ -e $dir/$targetRepo ]; then
    rm -rf $dir/$targetRepo
fi

# GitHubより対象リポジトリダウンロード（第2引数なしの場合はmasterからクローン）
if [ $# -eq 1 ]; then
  branch_option="master"
else
  branch_option=$2
fi
git clone --branch $branch_option --quiet --depth 1 git@github.com:hmw-honbu/$targetRepo.git

# .gitフォルダ削除（クローン解除）
rm -rf $dir/$targetRepo/.git
