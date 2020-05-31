# CSRF
CSRF即Cross-site request forgery(跨站请求伪造)。即攻击者借助受害者的Cookie，伪装为受害者，进行权限保护之下的操作。

利用用户的登录态发起恶意请求。

满足条件：用户已经登录。

假如黑客在自己的站点上放置了其他网站的外链，例如"www.weibo.com/api"，默认情况下，浏览器会带着weibo.com的cookie访问这个网址，如果用户已登录过该网站且网站没有对CSRF攻击进行防御，那么服务器就会认为是用户本人在调用此接口并执行相关操作，致使账号被劫持。

## 攻击方式
- 自动GET请求。
    黑客网页里面可能有一段这样的代码:
    ```html
    <img src="https://xxx.com/info?user=hhh&count=100"></img>
    ```
    进入页面后自动发送 get 请求，值得注意的是，这个请求会自动带上关于 xxx.com 的 cookie 信息(这里是假定你已经在 xxx.com 中登录过)。

- 自动POST请求。
    黑客可能自己填了一个表单，写了一段自动提交的脚本。
    ```html
    <form id='hacker-form' action="https://xxx.com/info" method="POST">
  <input type="hidden" name="user" value="hhh" />
  <input type="hidden" name="count" value="100" />
    </form>
    <script>document.getElementById('hacker-form').submit();</script>
    ```
    
- 诱导点击发送GET请求。
    在黑客的网站上，可能会放上一个链接，驱使你来点击:
    ```
    <a href="https://xxx/info?user=hhh&count=100" taget="_blank">点击进入修仙世界</a>
    ```

## 防范措施
CSRF共计主要是利用自动发送的Cookie，借助Cookie来模拟用户的身份。

1、使用CSRF Token进行验证，首先，浏览器向服务器发送请求时，服务器生成一个字符串，将其植入到返回的页面中。
然后浏览器如果要发送请求，就必须带上这个字符串，然后服务器来验证是否合法，如果不合法则不予响应。这个字符串也就是CSRF Token，通常第三方站点无法拿到这个 token, 因此也就是被服务器给拒绝。

2、验证来源站点：通过请求头的Origin和Referer，其中，Origin只包含域名信息，而Referer包含了具体的 URL 路径。来确定请求是否是合法的源。但都可以伪造。

3、设置SameSite,可以对 Cookie 设置 SameSite 属性。该属性表示 Cookie不随着跨域请求发送，但浏览器兼容不一。
 >
    SameSite可以设置为三个值，Strict、Lax和None。
    a. 在Strict模式下，浏览器完全禁止第三方请求携带Cookie。比如请求sanyuan.com网站只能在sanyuan.com域名当中请求才能携带 Cookie，在其他网站请求都不能。
    b. 在Lax模式，就宽松一点了，但是只能在 get 方法提交表单况或者a 标签发送 get 请求的情况下可以携带 Cookie，其他情况均不能。
    c. 在None模式下，也就是默认模式，请求会自动携带上 Cookie。
 >


![image](https://segmentfault.com/img/remote/1460000012693783?w=904&h=739)