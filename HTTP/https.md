# https
## 概念
HTTPS（全称：Hyper Text Transfer Protocol over Secure Socket Layer），是以安全为目标的HTTP通道，简单讲是HTTP的安全版。即HTTP下加入TLS/SSL层，HTTPS的安全基础是SSL，因此加密的详细内容就需要SSL。 

TLS的握手阶段是发生在TCP握手之后

## https与http的区别：   
- HTTPS使用443端口，而HTTP使用80
- HTTPS需要申请证书，需要缴费。
- HTTP是超文本传输协议，是明文传输；HTTPS是经过SSL加密的协议，传输更安全
- HTTPS比HTTP慢，因为HTTPS除了TCP握手的三个包，还要加上SSL握手的九个包。一般的HTTPS连接只在第一次握手时使用非对称加密

## 作用
- 建立一个信息安全通道，保证数据传输的安全
- 确认网站的真实性，防止钓鱼网站。

### 握手分为5步
1. 客户端给出协议版本号、一个客户端生成的随机数（Client random），以及客户端支持的加密方法。

2. 服务端确认双方使用的加密方法，并给出数字证书、以及一个服务器生成的随机数（Server random）。

3. 客户端确认数字证书有效，然后生成一个新的随机数（Premaster secret），并使用数字证书中的公钥，加密这个随机数，发给服务端。

4. 服务端使用自己的私钥，获取客户端发来的随机数（即Premaster secret）。

5. 客户端和服务端根据约定的加密方法，使用前面的三个随机数，生成"对话密钥"（session key），用来加密接下来的整个对话过程。

## 7次握手（TCP三次+TLS四次）
> 1. 浏览器请求建立SSL链接，并向服务端发送一个随机数–Client random和客户端支持的加密方法，比如RSA加密，此时是明文传输。 
> 
> 2. 服务端从中选出一组加密算法与Hash算法，回复一个随机数–Server random，并将自己的身份信息以证书的形式发回给浏览器
> （证书里包含了网站地址，非对称加密的公钥，以及证书颁发机构等信息）
> 
> 3. 浏览器收到服务端的证书后
>     
>     - 验证证书的合法性（颁发机构是否合法，证书中包含的网址是否和正在访问的一样），如果证书信任，则浏览器会显示一个小锁头，否则会有提示
>     
>     - 用户接收证书后（不管信不信任），浏览器会生产新的随机数–Premaster secret，然后证书中的公钥以及指定的加密方法加密`Premaster secret`，发送给服务器。
>     
>     - 利用Client random、Server random和Premaster secret通过一定的算法生成HTTP链接数据传输的对称加密key-`session key`
>     
>     - 使用约定好的HASH算法计算握手消息，并使用生成的`session key`对消息进行加密，最后将之前生成的所有信息发送给服务端。 
>     
> 4. 服务端收到浏览器的回复 
> 
>     - 利用已知的加解密方式与自己的私钥进行解密，获取`Premaster secret`
>     
>     - 和浏览器相同规则生成`session key`
>     
>     - 使用`session key`解密浏览器发来的握手消息，并验证Hash是否与浏览器发来的一致
>     
>     - 使用`session key`加密一段握手消息，发送给浏览器
>     
> 5. 浏览器解密并计算握手消息的HASH，如果与服务端发来的HASH一致，此时握手过程结束

![image](http://www.ruanyifeng.com/blogimg/asset/2014/bg2014092004.png)

https://juejin.im/post/5b0274ac6fb9a07aaa118f49#heading-5
http://www.ruanyifeng.com/blog/2014/09/illustration-ssl.html
https://mp.weixin.qq.com/s/StqqafHePlBkWAPQZg3NrA