 # DNS解析

- DNS解析就是根据域名找到对应的IP地址。

  ISP：互联网服务提供商（如中国电信）
  根DNS服务器：国际顶级域名服务器，如.com,.cn等。

- DNS域名系统，是应用层协议，运行UDP协议之上，使用端口43。

- 查询顺序：浏览器缓存-->操作系统缓存-->本地host文件-->路由器缓存-->ISP DNS缓存-->根DNS服务器。

- DNS查询分为两种方式：递归查询和迭代查询。

  递归查询：递归查询指的是查询请求发出后，域名服务器代为向下一级域名服务器发出请求，最后向用户返回查询的最终结果。使用递归 查询，用户只需要发出一次查询请求。

  迭代查询：迭代查询指的是查询请求后，域名服务器返回单次查询的结果。下一级的查询由用户自己请求。使用迭代查询，用户需要发出 多次的查询请求。

  所以一般而言，**「本地服务器查询是递归查询」**，而**「本地 DNS 服务器向其他域名服务器请求的过程是迭代查询的过程」**。

- DNS 为什么使用 UDP 协议作为传输层协议？

  **「DNS 使用 UDP 协议作为传输层协议的主要原因是为了避免使用 TCP 协议时造成的连接时延。」**

  - 为了得到一个域名的 IP 地址，往往会向多个域名服务器查询，如果使用 TCP 协议，那么每次请求都会存在连接时延，这样使 DNS 服务变得很慢。
  - 大多数的地址查询请求，都是浏览器请求页面时发出的，这样会造成网页的等待时间过长。

![image](https://user-images.githubusercontent.com/34484322/89356512-95168e80-d6f0-11ea-93aa-c4f59fd36942.png)



![image](https://mmbiz.qpic.cn/mmbiz_png/iccXN8sGPLT5NB9m3hYAibU72RswyO9mQ4GUcpTyBxaTReprueTOy6LQvhh1Eu4L2ncdpQAmfjSzEdPGjQvWiaJtQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)


![image](https://user-gold-cdn.xitu.io/2019/4/27/16a5ef76a0a1ee1c?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

> 

> 



