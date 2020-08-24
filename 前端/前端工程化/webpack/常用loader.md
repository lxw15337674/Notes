### 常用loaders

| 名称                   | 描述                                                         |
| ---------------------- | ------------------------------------------------------------ |
| babel-loader           | 转换js新特性语法                                             |
| stylus-loader          | 将stylus文件转换成css                                        |
| css-loader             | 将css文件打包到js中                                          |
| style-loader           | 将 css 代码以<style>标签的形式插入到 html 中。               |
| ts-loader              | 将ts转换为js                                                 |
| file-loader            | 生成的文件的文件名就是文件内容的 MD5 哈希值并会保留所引用资源的原始扩展名 |
| url-loader             | 把图片以Base64格式打包到bundle.js文件中                      |
| raw-loader             | 将文件以字符串的形式导入                                     |
| thread-loader          | 多进程打包js和css                                            |
| image-webpack-loader   | 压缩图片大小                                                 |
| eslint-loader          | 通过 ESLint 检查 JavaScript 代码                             |
| Style-Resources-Loader | 全局引入css文件，不用受到@import                             |
| vue-loader             | vue文件的一个加载器，跟template/js/style转换成js模块。       |

**编写原则**:

- **单一原则**: 每个 Loader 只做一件事；
- **链式调用**: Webpack 会按顺序链式调用每个 Loader；
- **统一原则**: 遵循 Webpack 制定的设计规则和结构，输入与输出均为字符串，各个 Loader 完全独立，即插即用；