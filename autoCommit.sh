# 实现自动 Commit 和 Push
git add .
a=$0
echo $*
git commit -m "auto commit"
git push origin master
