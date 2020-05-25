# HMR

## 详解

https://juejin.im/post/5df36ffd518825124d6c1765  
https://juejin.im/post/5d8db37051882530d438535c  
https://juejin.im/post/5c86ec276fb9a04a10301f5b

## 概念

Hot Module Replacement（以下简称 HMR）  
当你对代码进行修改并保存后，webpack 将对代码重新打包，并将新的模块发送到浏览器端，浏览器通过新的模块替换老的模块，这样在不刷新浏览器的前提下就能够对应用进行更新。

## 基本原理

> Webpack watch：使用监控模式开始启动 webpack 编译，在 webpack 的 watch 模式下，文件系统中某一个文件发生修改，webpack 监听到文件变化，根据配置文件对模块重新编译打包，每次编译都会产生一个唯一的 hash 值，

构建 bundle 的时候，加入一段 HMR runtime 的 js 和一段和服务沟通的 js 。文件修改会触发 webpack 重新构建，服务器通过向浏览器发送更新消息，浏览器通过 jsonp 拉取更新的模块文件，jsonp 回调触发模块热替换逻辑。

![image](https://user-gold-cdn.xitu.io/2019/9/27/16d7184d654dea3e?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)
