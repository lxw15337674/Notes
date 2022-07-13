# webpack 概念

## entry 入口
webpack开始构建的入口模块

## output 出口

表示 webpack 打包的文件存放路径，以及如何命名这些文件。

## loader 加载器、翻译器

webpack 默认只能理解 js、json 文件，其他文件类型需要通过 loader 进行翻译，转换为 webpack 可以处理的有效模块。

### 主要属性

- `test`属性，用于标识被转换的文件。
- `use`属性，表示进行转换时，应该使用哪个 loader。

```
const path = require('path');

const config = {
  output: {
    filename: 'my-first-webpack.bundle.js'
  },
  module: {
    rules: [
      { test: /\.txt$/, use: 'raw-loader' }
    ]
  }
};

module.exports = config;
```

## plugin 插件
主要是优化，利用webpack构建流程暴露的钩子函数，对webpack功能的扩展。
例如：提取精华(公共模块去重)，压缩处理(css/js/html)等，对webpack功能的扩展。

## chunk 代码块
webpack 4 的`Code Splitting` 产物，抛弃了webpack3的`CommonsChunkPlugin`,它最大的特点就是配置简单，当你设置 `mode` 是 `production`，那么 webpack 4 就会自动开启 `Code Splitting`，可以完成将某些公共模块去重，打包成一个单独的`chunk`。



## Module 模块

在 Webpack 里一切皆模块，webpack 会通过各种 loader 转化成一个 module，这个模块会被打包到某个 chunk 中，并不会形成一个单独的 chunk。




## 详解

https://juejin.im/post/6859888538004783118