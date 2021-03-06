# tree-shaking

本质是消除无用的 js 代码。无用代码消除在广泛存在于传统的编程语言编译器中，编译器可以判断出某些代码根本不影响输出，然后消除这些代码，这个称之为 DCE（dead code elimination）。

tree-shaking 是 DCE 的一种新的实现，传统的 DCE 消灭不可能执行的代码，而 Tree-shaking 更关注宇消除没有用到的代码。

在 webpack 是通过 uglifyJSPlugin 来 Tree-shaking JS。

## DCE

特征：

- 代码不会被执行，不可到达
- 代码执行的结果不会被用到
- 代码只会影响死变量（只写不读）

![image](https://user-gold-cdn.xitu.io/2018/1/4/160bfd6b8b4818fd?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

## tree-shaking

更关注于无用模块的消除，消除那些引用了但并没有被使用的模块。
消除原理是依赖于 ES6 的模块特性,ES6 模块依赖关系是确定的，和运行时的状态无关，可以进行可靠的静态分析，这就是 tree-shaking 的基础。

![image](https://user-gold-cdn.xitu.io/2018/1/4/160bfd6bb8832182?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

## 引用

[Tree-Shaking 性能优化实践 - 原理篇](https://juejin.im/post/5a4dc842518825698e7279a9)
