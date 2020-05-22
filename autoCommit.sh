# 实现自动 Commit 和 Push
git add .
a='auto commit'
if [  $1 = "" ]; then
a=$1
fi

git commit -m "$a"
git push origin master

