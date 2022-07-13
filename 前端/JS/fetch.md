# fetch

在 传统Ajax 时代，进行 API 等网络请求都是通过XMLHttpRequest或者封装后的框架进行网络请求,然而配置和调用方式非常混乱，对于刚入门的新手并不友好。今天我们介绍的Fetch提供了一个更好的替代方法，它不仅提供了一种简单，合乎逻辑的方式来跨网络异步获取资源，而且可以很容易地被其他技术使用，例如 Service Workers。

## 二 与Ajax对比

使用Ajax请求一个 JSON 数据一般是这样：

```
var xhr = new XMLHttpRequest();
xhr.open('GET', url/file,true);
xhr.onreadystatechange = function() {
   if(xhr.readyState==4){
        if(xhr.status==200){
            var data=xhr.responseText;
             console.log(data);
   }
};
xhr.onerror = function() {
  console.log("Oh, error");
};
xhr.send();
```

同样我们使用fetch请求JSON数据：

```
fetch(url).then(response => response.json())//解析为可读数据
  .then(data => console.log(data))//执行结果是 resolve就调用then方法
  .catch(err => console.log("Oh, error", err))//执行结果是 reject就调用catch方法
```

优点：
1. 更加底层，提供的API丰富（request, response）
2. 脱离了XHR，是ES规范里新的实现方式
缺点：
1. fetch只对网络请求报错，对400，500都当做成功的请求，需要封装去处理
2. fetch默认不会带cookie，需要添加配置项： fetch(url, {credentials: 'include'})
3. fetch不支持abort，不支持超时控制，使用setTimeout及Promise.reject的实现的超时控制并不能阻止请求过程继续在后台运行，造成了流量的浪费
4. fetch没有办法原生监测请求的进度，而XHR可以

## 与axios区别
1. 从浏览器中创建 XMLHttpRequest
2. 从 node.js 发出 http 请求
3. 支持 Promise API
4. 拦截请求和响应
5. 转换请求和响应数据
6. **提供了一些并发请求的接口**
7. 取消请求（cancelToken）
8. 自动转换JSON数据
9. 客户端支持防止CSRF/XSRF

> 防止CSRF:就是让你的每个请求都带一个从cookie中拿到的key, 根据浏览器同源策略，假冒的网站是拿不到你cookie中得key的，这样，后台就可以轻松辨别出这个请求是否是用户在假冒网站上的误导输入，从而采取正确的策略。


## 引用

https://github.com/ljianshu/Blog/issues/47

https://segmentfault.com/a/1190000012836882