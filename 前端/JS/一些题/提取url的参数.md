提取url中search部分参数，www.taobao.com?a=1&b=2

```
let a = 'www.taobao.com?a=1&b=2&c=3444&e=444'
function getParams(url) {
    let request = url.split('?', 2)[1].split('&')
    let res = {}
    for (let item of request) {
        let [key, value] = item.split('=')
        res[key] = value
    }
    return res
}
getParams(a)

```
