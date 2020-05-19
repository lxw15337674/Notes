# git 命令

## 各类场景详解

https://juejin.im/post/5d5d61e96fb9a06ace5254bd

## git merge （合并）

git merge 将一个分支的修改应用到另一个分支

### fast-forward

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc47Kz7RJZr7Ixu1VbjVwTqIiactHDBAvQK7P5R1B60sic3XYd9SzXpo55cg/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

### no-fast-forward

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc47ql3frSRERzLickHicN04LoI3M9wYriac2wzJhQAyxJMKvC5rXdGoO4LRg/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

### 合并冲突

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc47CCw7uLSaAYZWvaf9uic6Lgiaic6oicPTiaWwJdBdj2gnu8kN9Jknib1hXgUQ/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

## git rebase 变基

将一个分支的修改融入到另一个分支

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc47FiaRJ1xKcJMYB3pBQMgiaLBzK6iaOLbuR4gH7BuBhPiaaiahmookDvqgpiaw/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

### 交互式变基

> reword：修改提交信息；  
> edit：修改此提交；  
> squash：将提交融合到前一个提交中；  
> fixup：将提交融合到前一个提交中，不保留该提交的日志消息；  
> exec：在每个提交上运行我们想要 rebase 的命令；  
> drop：移除该提交。

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc47FDicRVQzOh1vlCQqE23BENZgIicDq2muUskwgibkZria8mlWEVb4pzicGbg/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc47Sc3LdpTun3jytlmFwzxgCfZeQ5M0VyUH2CsCUbjlIM8hFBiabSqSpibw/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

### 合并与变基区别

Git 不会尝试确定要保留或不保留哪些文件。  
我们执行 rebase 的分支总是含有我们想要保留的最新的修改！这样我们不会遇到任何合并冲突，而且可以保留一个漂亮的、线性的 Git 历史记录。

## git reset 重置

### 软重置

软重置会将 HEAD 移至指定的提交（或与 HEAD 相比的提交的索引），而不会移除该提交之后加入的修改！

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc478EJlujcsicVPVaJJdS5IJxsWibc4Cx1gHwJfKZiciawXOyv7a00pXlJfFQ/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

### 硬重置

有时候我们并不想保留特定提交引入的修改。不同于软重置，我们应该再也无需访问它们。Git 应该直接将整体状态直接重置到特定提交之前的状态：这甚至包括你在工作目录中和暂存文件上的修改。

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc47LykI1SUAn2jH2ap0PAwrkS56v1cI2iahkgc6xtjzQZxmJZ6XVzGzXTA/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

## git revert 还原

通过对特定的提交执行还原操作，我们会创建一个包含已还原修改的新提交。

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc47pTrKzKv4jkibqvicsfSAPiaEQsn9sFIxlCo3D2uEXfupoztIpN6lTAgCQ/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

### git revert 和 git reset 的区别

- git revert 是用一次新的 commit 来回滚之前的 commit，git reset 是直接删除指定的 commit。
- 在回滚这一操作上看，效果差不多。但是在日后继续 merge 以前的老版本时有区别。因为 git revert 是用一次逆向的 commit“中和”之前的提交，因此日后合并老的 branch 时，导致这部分改变不会再次出现，但是 git reset 是之间把某些 commit 在某个 branch 上删除，因而和老的 branch 再次 merge 时，这些被回滚的 commit 应该还会被引入。
- git reset 是把 HEAD 向后移动了一下，而 git revert 是 HEAD 继续前进，只是新的 commit 的内容和要 revert 的内容正好相反，能够抵消要被 revert 的内容。

## Cherry-picking 拣选

当一个特定分支包含我们的活动分支需要的某个提交时，我们对那个提交执行 cherry-pick！对一个提交执行 cherry-pick 时，我们会在活动分支上创建一个新的提交，其中包含由拣选出来的提交所引入的修改。

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc47AuQfYgNQZReR1KdnSOcYCmRk64Cq7S46cqSiaTuCsKG3w0m8FiagfxFQ/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

## git fetch 取回

通过在这个远程分支上执行 git fetch，我们就可在本地获取这些修改。这不会以任何方式影响你的本地分支：fetch 只是单纯地下载新的数据而已。

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc47Bx4YIoUIIhIGEF5tXxJHSa5Xf0YnYFptBcZUSMjABVict7u4uNkPK0Q/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

## git pull 拉取

git pull 实际上是两个命令合成了一个：git fetch 和 git merge。当我们从来源拉取修改时，我们首先是像 git fetch 那样取回所有数据，然后最新的修改会自动合并到本地分支中。

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc47NETOdP0oAicDBxb8z19moncy4NyzBbHpz8QnNFFWRNy2M9OUcrSvfCQ/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

## git reflog 历史操作日志

git reflog 是一个非常有用的命令，可以展示已经执行过的所有动作的日志。包括合并、重置、还原，基本上包含你对你的分支所做的任何修改。

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc474QeRST8xHPslv0faicoHF7k1PsvgAzIfFw5qocicNuLA0HS19ORdQyGQ/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)

根据 reflog 提供的信息通过重置 HEAD 来轻松地重做！

![image](https://mmbiz.qpic.cn/mmbiz_gif/KmXPKA19gWicpG4ibricDjhseFOGY3Qnc47zdHjpJwlq4oLrOBmMgJLNGSjKXpJQvIzzPnrw2pbtF1X4aDcdxW11w/640?wx_fmt=gif&tp=webp&wxfrom=5&wx_lazy=1)
