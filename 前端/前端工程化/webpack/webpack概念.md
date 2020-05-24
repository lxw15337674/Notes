# webpack 概念

## entry 入口

表示 webpack 从哪个模块作为构建其内部依赖图的入口。

## output 出口

表示 webpack 打包的文件存放路径，以及如何命名这些文件。

## loader 加载器、翻译器

webpack 默认只能理解 js 文件，其他文件类型需要通过 loader 进行翻译，转换为 webpack 可以处理的有效模块。

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

## plugins 插件

在 Webpack 构建流程中的特定时机会有对应的钩子函数，插件可以监听这些事件的发生，在特定时机做对应的事情。增强 webpack 功能。

## chunk 代码块

chunk 就是若干 module 打成的包，一个 chunk 应该包括多个 module，一般来说最终会形成一个 file。用于代码合并与分割。

## Module 模块

在 Webpack 里一切皆模块，webpack 会通过各种 loader 转化成一个 module，这个模块会被打包到某个 chunk 中，并不会形成一个单独的 chunk。
