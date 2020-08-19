# npm脚本
npm 允许在`package.json`文件里面，使用`scripts`字段定义脚本命令。
```
{
  // ...
  "scripts": {
    "build": "node build.js"
  }
}
```
### 使用说明
1. 默认值，npm默认提供`start`、`install`两个脚本。
2. 钩子(生命周期)，npm有两个钩子：`pre`和`post`,执行顺序如下：
  ```
  npm run prestart && npm run start && npm run poststart
  ```
  使用场景：
   1. 代码检查
   2. 测试运行
3. 变量，通过`npm_package_`前缀，npm脚本可以拿到`package.json`里面的字段。
4. 传参、执行顺序如下：
```shell
npm run lint --report  // 向npm传参，要使用`--`标明.
npm run script1.js & npm run script2.js // 并行执行（同时执行），用&
npm run script1.js && npm run script2.js // 顺序执行（即前一个任务成功，才执行下一个任务），用&&
```
### 原理
每当执行`npm run `，就会自动新增一个shell执行指定的脚本命令。因此，只要是 Shell（一般是 Bash）可以运行的命令，就可以写在 npm 脚本里面。
`npm run`新建的shell，会将当前目录的`nodel_modules/bin`子目录加入`PATH`变量，执行结束后，再将`PATH`变量恢复原样。




参考：
[npm scripts 使用指南](http://www.ruanyifeng.com/blog/2016/10/npm_scripts.html)