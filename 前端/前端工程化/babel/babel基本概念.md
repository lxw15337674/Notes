# babel
详解：https://mp.weixin.qq.com/s/QPr5ZJ74cRN68gWKbqYngQ
## 什么是babel
 Babel 是一个 JavaScript 编译器，用于将 ECMAScript 2015+ 版本的代码转换为向后兼容的 JavaScript 语法，以便能够运行在当前版本和旧版本的浏览器或其他环境中。简单来说 Babel 的工作就是：
- 语法转换
- 通过 Polyfill 的方式在目标环境中添加缺失的特性
- JS 源码转换

## 用途
Babel 只负责编译新标准引入的新语法，比如 Arrow function、Class、ES Modul 等。  
它不会编译原生对象新引入的方法和 API，比如 Array.includes，Map，Set 等，这些需要通过 Polyfill 来解决
polyfill 的翻译过来就是垫片，垫片就是垫平不同浏览器环境的差异，让大家都一样。   
@babel/polyfill 模块可以模拟完整的 ES5 环境。

## 基本原理
AST（抽象语法树）。首先将源码转成抽象语法树，然后对语法树进行处理生成新的语法树，最后将新语法树生成新的 JS 代码，整个编译过程可以分为 3 个阶段 parsing (解析)、transforming (转换)、generating (生成)。

![image](https://mmbiz.qpic.cn/mmbiz_jpg/vzEib9IRhZD7bA5ec4JI6jRl7YJ3HovF255kwZveibNZVbHj64ibUdOfPkFDjDUiaOrhEzpOOjFWqJ30pDLU1UjJYw/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)



## 使用
### @babel/cli  
@babel/cli 是 Babel 提供的内建命令行工具。  
##### 与@babel/node区别：  
这哥俩虽然都是命令行工具但是使用场景不同：
- @babel/cli 是安装在项目中
- @babel/node 是全局安装。

### @babel/core
安装完 @babel/cli 后就在项目目录下执行babel test.js会报找不到 @babel/core 的错误，因为 @babel/cli 在执行的时候会依赖 @babel/core 提供的生成 AST 相关的方法，所以安装完 @babel/cli 后还需要安装 @babel/core。  
安装完这两个插件后，如果在 Mac 环境下执行会出现 command not found: babel，这是因为 @babel/cli是安装在项目下，而不是全局安装，所以无法直接使用 Babel 命令,需要在 package.json 文件中加上下面这个配置项:
```
"scripts": {
   "babel":"babel"
 }
```
然后执行 npm run babel ./test.js，顺利生成代码，此时生成的代码并没有被编译，因为 Babel 将原来集成一体的各种编译功能分离出去，独立成插件，要编译文件需要安装对应的插件或者预设，我们经常看见的什么 @babel/preset-stage-0、@babel/preset-stage-1，@babel/preset-env 等就是干这些活的。
## 配置文件方式
### babel.config.js
具体 babel.config.js 配置 (https://www.babeljs.cn/docs/config-files#project-wide-configuration)
### .babelrc
.babelrc 文档 (https://www.babeljs.cn/docs/config-files#file-relative-configuration)
### .babelrc.js
与 .babelrc 的配置相同，你可以使用 JavaScript 语法编写。
### package.json
还可以选择将 .babelrc 中的配置信息写到 package.json 文件中

## 插件(plugins)
### 概念
插件是用来定义如何转换你的代码的。在 Babel 的配置项中填写需要使用的插件名称，Babel 在编译的时候就会去加载 node_modules 中对应的 npm 包，然后编译插件对应的语法。
### 执行顺序
插件在预设(Presets) 前运行。

插件的执行顺序是从左往右，从上往下执行。

### 插件传参
参数是由插件名称和参数对象组成的一个数组。
```
{
    "plugins": [
        [
            "@babel/plugin-proposal-class-properties",
            { "loose": true }
        ]
    ]
}
```
### 常见插件
#### @babel/plugin-transform-runtime
@babel/plugin-transform-runtime 可以让 Babel 在编译中复用辅助函数，从而减小打包文件体积，
```
npm install --save-dev @babel/plugin-transform-runtime
npm install --save @babel/runtime
```



## 预设（presets）
预设就是一堆插件(Plugin)的组合，从而达到某种转译的能力，就比如 react 中使用到的 @babel/preset-react ，它就是下面几种插件的组合。
- @babel/plugin-syntax-jsx
- @babel/plugin-transform-react-jsx
- @babel/plugin-transform-react-display-name

### 执行顺序
预设的执行顺序是从右往左，从下往上。确保向后兼容。

### 常见预设
#### @babel/preset-stage-xxx
@babel/preset-stage-xxx 是 ES 在不同阶段语法提案的转码规则而产生的预设，随着被批准为 ES 新版本的组成部分而进行相应的改变（例如 ES6/ES2015）。

提案分为以下几个阶段：
- tage-0 - 设想（Strawman）：只是一个想法，可能有 Babel 插件，stage-0 的功能范围最广大，包含 stage-1 , stage-2 以及 stage-3 的所有功能
- stage-1 - 建议（Proposal）：这是值得跟进的
- stage-2 - 草案（Draft）：初始规范
- stage-3 - 候选（Candidate）：完成规范并在浏览器上初步实现
- stage-4 - 完成（Finished）：将添加到下一个年度版本发布中

#### @babel/preset-env
 @babel/preset-env 是根据浏览器的不同版本中缺失的功能确定代码转换规则的，在配置的时候我们只需要配置需要支持的浏览器版本就好了，@babel/preset-env 会根据目标浏览器生成对应的插件列表然后进行编译。  
 
 在默认情况下 @babel/preset-env 支持将 JS 目前最新的语法转成 ES5，但需要注意的是，如果你代码中用到了还没有成为 JS 标准的语法，该语法暂时还处于 stage 阶段，这个时候还是需要安装对应的 stage 预设，不然编译会报错。
 
 @babel/preset-env 在默认情况下和 preset-stage-x 一样只编译语法，不会对新方法和新的原生对象进行转译

##### useBuiltIns  
回过头来再说 @babel/preset-env，他出现的目的就是实现民族大统一，连 stage-x 都干掉了，又怎么会漏掉 Polyfill 这一功能，在 @babel/preset-env 的配置项中提供了 useBuiltIns 这一参数，只要在使用 @babel/preset-env 的时候带上他，Babel 在编译的时候就会自动进行 Polyfill ，不再需要手动的在代码中引入@babel/polyfill 了，同时还能做到按需加载。

useBuiltIns 配置参数：
- false：此时不对Polyfill 做操作，如果引入 @babel/polyfill 则不会按需加载，会将所有代码引入
- usage：会根据配置的浏览器兼容性，以及你代码中使用到的 API 来进行 Polyfill ，实现按需加载
- entry：会根据配置的浏览器兼容性，以及你代码中使用到的 API 来进行 Polyfill ，实现按需加载，不过需要在入口文件中手动加上import ' @babel/polyfill'

```
{
  "presets": [
    "@babel/preset-flow",
    [
      "@babel/preset-env",
      {
        "targets": {
          "node": "8.10"
        },
        "corejs": "3", // 声明 corejs 版本
        "useBuiltIns": "usage"
      }
    ]
  ]
}
```