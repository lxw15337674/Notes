# Ajax

思路：

- 返回一个新的`Promise`实例

- 创建`HMLHttpRequest`异步对象

- 调用`open`方法，打开`url`，与服务器建立链接（发送前的一些处理）

- 监听`Ajax`状态信息

- 如果`xhr.readyState == 4`（表示服务器响应完成，可以获取使用服务器的响应了）
  - `xhr.status == 200`，返回`resolve`状态
  - `xhr.status == 404`，返回`reject`状态

- `xhr.readyState !== 4`，把请求主体的信息基于`send`发送给服务器

```javascript
function ajax(url, method) {
    return new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest()
        xhr.open(url, method, true)
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    resolve(xhr)
                } else if (xhr.status === 404) {
                    reject(new Error('404'))
                }
            } else {
                reject('请求数据失败')
            }
        }
        xhr.send(null)
    })
}
```

