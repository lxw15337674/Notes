# 手动实现JSONP跨域
思路：

- 创建`script`标签
- 设置`script`标签的`src`属性，以问号传递`参数`，设置好回调函数`callback`名称
- 插入到`html`文本中
- 调用回调函数，`res`参数就是获取的数据

```javascript
let script = document.createElement('script');

script.src = 'http://www.baidu.cn/login?username=JasonShu&callback=callback';

document.body.appendChild(script);

function callback (res) {
    console.log(res);
}

```

