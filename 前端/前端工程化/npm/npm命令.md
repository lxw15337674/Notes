# npm 命令
[npm命令官方文档](https://docs.npmjs.com/cli-documentation/)
## 常用命令列表
``` bash
npm install 安装模块
npm uninstall 卸载模块
npm update 更新模块
npm outdated 检查模块是否已经过时
npm ls 查看安装的模块
npm init 在项目中引导创建一个package.json文件
npm help 查看某条命令的详细帮助
npm root 查看包的安装路径
npm config 管理npm的配置路径
npm cache 管理模块的缓存
npm start 启动模块
npm stop 停止模块
npm restart 重新启动模块
npm test 测试模块
npm version 查看模块版本
npm view 查看模块的注册信息
npm adduser  用户登录
npm publish 发布模块
npm access 在发布的包上设置访问级别
npm package.json的语法
```
## install
### 语法
```
npm install 或npm i
```
> 从npm 5.x开始，可以不用手动添加-S/--save指令，直接执行`npm i packageName`把依赖包添加到`dependencies`中去
### 参数
```
-g、--global：视为全局的包，安装在系统预设的目录中。
-S、--save、:将模块保存在dependencies(生产环境依赖)。
-D、--save-dev:将模块保存在devDependencies（开发环境依赖）
-O、--save-optional ：将模块保存在optionalDependencies（可选环境依赖）。
-E、--save-optional：表示模块的版本是精确指定的。
-B、--save-bundle：表示将模块保存在bundleDependencies（构建依赖）。
```
## `devDependencies` 与 `dependencies` 区别
1.  `devDependencies` 存放在本地开发用的，例如检测代码规范的`eslint`、测试的`jest`、css预处理器`stylus`。
2.  `dependencies` 存放生产环境用到的，例如js框架`vue`、页面路由`vue-router`、ui框架`element-ui`。

## link
https://www.axihe.com/api/npm/cli/npm-link.html