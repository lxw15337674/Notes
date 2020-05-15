# 实现自动 Commit 和 Push
set /p  commit autoCommit:
git status
git add -A
git commit -m "%commit_log%"
git push origin master
pause