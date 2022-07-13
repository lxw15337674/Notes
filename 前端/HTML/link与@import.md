# link与@import

link与import , 本质使用上，我们都是用他来引入css，但是他们有一定的区别。

1. link是一种引入资源的标签，import是引入css的方式。所以，import引入的只能是css，而link可以引入所有的资源，包括图片，RSS等。
2. 加载顺序上也有一些差异。 link引用的CSS会同时被加载。 import引用的CSS会等到页面全部被下载完再加载。
3. 兼容性的差别。 link无任何兼容问题，import兼容IE5以上。（当然，IE5估计也找不到了）
4. 动态引入样式 link可以后期引入样式，而import是不可以后期引入的，只能初始化页面之前引入。
5. 复用率的问题 import可以复用之前的css文件，而link只能一次引用一个文件。 当然，import复用文件时，在浏览器实际上是加载了多个文件，会有多个请求。而每一个link只是一个http请求。


