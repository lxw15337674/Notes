## 前言

AJAX即“Asynchronous Javascript And XML”，是指一种创建交互式网页应用的网页开发技术。AJAX 是一种用于创建快速动态网页的技术。它可以令开发者只向服务器获取数据（而不是图片，HTML文档等资源），互联网资源的传输变得前所未有的轻量级和纯粹，这激发了广大开发者的创造力，使各式各样功能强大的网络站点，和互联网应用如雨后春笋一般冒出，不断带给人惊喜。

[![img](https://camo.githubusercontent.com/fd2d3d91e15090e3d87935fe880f6a07f13cbf08/68747470733a2f2f757365722d676f6c642d63646e2e786974752e696f2f323031382f31322f32342f313637653035626464666438646365393f773d3135353026683d36363826663d706e6726733d323635303335)](https://camo.githubusercontent.com/fd2d3d91e15090e3d87935fe880f6a07f13cbf08/68747470733a2f2f757365722d676f6c642d63646e2e786974752e696f2f323031382f31322f32342f313637653035626464666438646365393f773d3135353026683d36363826663d706e6726733d323635303335)

## 一、什么是Ajax

Ajax是一种异步请求数据的web开发技术，对于改善用户的体验和页面性能很有帮助。简单地说，在不需要重新刷新页面的情况下，Ajax 通过异步请求加载后台数据，并在网页上呈现出来。常见运用场景有表单验证是否登入成功、百度搜索下拉框提示和快递单号查询等等。**Ajax的目的是提高用户体验，较少网络数据的传输量**。同时，由于AJAX请求获取的是数据而不是HTML文档，因此它也节省了网络带宽，让互联网用户的网络冲浪体验变得更加顺畅。

## 二、Ajax原理是什么

在解释Ajax原理之前，我们不妨先举个“领导想找小李汇报一下工作”例子，领导想找小李问点事，就委托秘书去叫小李，自己就接着做其他事情，直到秘书告诉他小李已经到了，最后小李跟领导汇报工作。

[![img](https://camo.githubusercontent.com/f8a5dca0eda6c4c64fc37a02af3975de339389d0/68747470733a2f2f757365722d676f6c642d63646e2e786974752e696f2f323031382f31322f31382f313637626430313932343061343537623f773d35343826683d32343626663d706e6726733d3635373039)](https://camo.githubusercontent.com/f8a5dca0eda6c4c64fc37a02af3975de339389d0/68747470733a2f2f757365722d676f6c642d63646e2e786974752e696f2f323031382f31322f31382f313637626430313932343061343537623f773d35343826683d32343626663d706e6726733d3635373039)

Ajax请求数据流程与“领导想找小李汇报一下工作”类似。其中最核心的依赖是浏览器提供的XMLHttpRequest对象，它扮演的角色相当于秘书，使得浏览器可以发出HTTP请求与接收HTTP响应。浏览器接着做其他事情，等收到XHR返回来的数据再渲染页面。

[![img](https://camo.githubusercontent.com/8c44fcb913563be506704a3df529c50f1bbdab06/68747470733a2f2f757365722d676f6c642d63646e2e786974752e696f2f323031382f31322f31382f313637626430323338353563306266373f773d35363326683d32343026663d706e6726733d3733383234)](https://camo.githubusercontent.com/8c44fcb913563be506704a3df529c50f1bbdab06/68747470733a2f2f757365722d676f6c642d63646e2e786974752e696f2f323031382f31322f31382f313637626430323338353563306266373f773d35363326683d32343026663d706e6726733d3733383234)

理解了Ajax的工作原理后，接下来我们探讨下如何使用Ajax。

## 三、Ajax的使用

### 1.创建Ajax核心对象XMLHttpRequest(记得考虑兼容性)

```
	1. var xhr=null;  
	2. if (window.XMLHttpRequest)  
	3.   {// 兼容 IE7+, Firefox, Chrome, Opera, Safari  
	4.   xhr=new XMLHttpRequest();  
	5.   } else{// 兼容 IE6, IE5 
	6.     xhr=new ActiveXObject("Microsoft.XMLHTTP");  
	7.   } 
```

### 2.向服务器发送请求

```
    1. xhr.open(method,url,async);  
    2. send(string);//post请求时才使用字符串参数，否则不用带参数。
```

- method：请求的类型；GET 或 POST
- url：文件在服务器上的位置
- async：true（异步）或 false（同步）
  **注意：post请求一定要设置请求头的格式内容**

```
xhr.open("POST","test.html",true);  
xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");  
xhr.send("fname=Henry&lname=Ford");  //post请求参数放在send里面，即请求体
```

### 3.服务器响应处理（区分同步跟异步两种情况）

responseText 获得字符串形式的响应数据。

responseXML 获得XML 形式的响应数据。

#### ①同步处理

```
	1. xhr.open("GET","info.txt",false);  
	2. xhr.send();  
	3. document.getElementById("myDiv").innerHTML=xhr.responseText; //获取数据直接显示在页面上
```

#### ②异步处理

相对来说比较复杂，要在请求状态改变事件中处理。

```
	1. xhr.onreadystatechange=function()  { 
	2.    if (xhr.readyState==4 &&xhr.status==200)  { 
	3.       document.getElementById("myDiv").innerHTML=xhr.responseText;  
	4.      }
	5.    } 
```

#### 什么是readyState？

readyState是XMLHttpRequest对象的一个属性，用来标识当前XMLHttpRequest对象处于什么状态。
readyState总共有5个状态值，分别为0~4，每个值代表了不同的含义

- 0：未初始化 -- 尚未调用.open()方法；
- 1：启动 -- 已经调用.open()方法，但尚未调用.send()方法；
- 2：发送 -- 已经调用.send()方法，但尚未接收到响应；
- 3：接收 -- 已经接收到部分响应数据；
- 4：完成 -- 已经接收到全部响应数据，而且已经可以在客户端使用了；

## 四、结束语

其实通过 XMLHttpRequest或者封装后的框架进行网络请求,这种方式已经有点老旧了，配置和调用方式非常混乱，近几年刚刚出来的Fetch提供了一个更好的替代方法，它不仅提供了一种简单，合乎逻辑的方式来跨网络异步获取资源，而且可以很容易地被其他技术使用。

想了解如何利用Fetch请求数据，请猛戳
[fetch 如何请求常见数据格式](https://juejin.im/post/5b1e9ec4f265da6e6414a871)

想了解Ajax如何请求后台数据，请猛戳
[Ajax请求后台数据](https://juejin.im/post/5b1cea356fb9a01e713592c5)

## 参考文章

- [javascript教程](https://www.liaoxuefeng.com/wiki/001434446689867b27157e896e74d51a89c25cc8b43bdb3000/001434499861493e7c35be5e0864769a2c06afb4754acc6000)
- [Ajax 简介](https://www.ibm.com/developerworks/cn/web/wa-aj-ajaxhistory/index.html)
- [再也不学AJAX了！（一）AJAX概述](https://juejin.im/post/5a1e11b86fb9a0451d413977)
- [HTTP菜鸟教程](http://www.runoob.com/http/http-tutorial.html)
- [AJAX的POST和GET请求的区别](https://juejin.im/post/5a31d0685188253da72e7458)

## 引用

https://github.com/ljianshu/Blog/issues/45