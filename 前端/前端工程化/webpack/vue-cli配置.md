# vue-cli
## 集成功能
集成plugin
| 名称                        | 描述       |
| --------------------------- | ---------- |
| progress-bar-webpack-plugin | 编译进度条 |
| CompressionWebpackPlugin    | gzip 压缩  |
| happypack                   | 多线程处理 |
| webpack-merge               | 配置合并   |

集成loader

| 名称                        | 描述       |
| --------------------------- | ---------- |
babel-loader | 转换js新特性语法
stylus-loader| 将stylus文件转换成css
css-loader | 支持.CSS文件的加载和清洗
style-loader | 通过向 DOM 中注入 <style> 标签实现css效果
thread-loader| 多进程打包js和css
eslint-loader | 通过 ESLint 检查 JavaScript 代码
Style-Resources-Loader | 全局引入css文件，不用受到@import

## 额外配置

1. 引入plugin
|                         | 描述       |
| --------------------------- | ---------- |
CompressionWebpackPlugin| gzip压缩

2. 引入loader
|                         | 描述       |
| --------------------------- | ---------- |
image-webpack-loader | 压缩图片大小


1. 添加浏览器支持
- browserslist
    > 通过package.json 文件里的 browserslist字段或一个单独的 .browserslistrc 文件来指定项目的目标浏览器的范围。这个值会被 @babel/preset-env 和 Autoprefixer 用来确定需要转译的 JavaScript 特性和需要添加的 CSS 浏览器前缀
    >
    [browserslist 目标浏览器配置表](https://juejin.im/post/5c1b6e50e51d45745728e878)
2. 配置scss/stylus共享全局变量
    利用style-resources-loader库
3. 配置单/多页面
    配置pages
4. 区分开发环境和生成环境的配置
    通过process.env.NODE_ENV变量来判断
5. 配置文件夹别名
    配置alias
6. 配置devServer项，用于反向代理，解决跨域问题，或进行mock
7. 关闭source map
    一般用于生产环境调试，开发环境可以关闭减少打包时间。


## 参考
[Vue cli3 通用多页面脚手架](https://juejin.im/post/5c0b8d74f265da6115109d68#heading-2)
[Vue CLI3搭建组件库并实现按需引入实战操作](https://juejin.im/post/5dd234635188254a1f44646a)
[一张图教你快速玩转vue-cli3
](https://juejin.im/post/5d1782eaf265da1ba91592fc)