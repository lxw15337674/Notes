# Event Loop（js的事件循环机制）
## 作用
解决单线程的js对异步任务的问题。
## 机制
js中的**事件触发器**维护宏任务和微任务两个队列，微任务的优先级高于宏任务。
每次宏任务执行完后都会执行所有微任务，然后再执行下一个宏任务。

![image](https://mmbiz.qpic.cn/mmbiz_jpg/WmXepF87uPkGGGia6u0aic2pyZGuSIus9bUsAGCABpT7yftDWYVkeibTprb5upDk5xzyPw40Qz3wicgWCAqUwtibhBA/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

## 常见宏任务（macrotask）
- script(整体代码)
- setTimeout / setInterval
- setImmediate(Node.js 环境)
- I/O
- UI render
- postMessage
- MessageChannel

## 常见微任务（microtask）
- process.nextTick(Node.js 环境)
- Promise
- Async/Await
- MutationObserver（监视对DOM树所做更改）

## 关于process.nextTick的一点说明
process.nextTick 是一个独立于 eventLoop 的任务队列。

在每一个 eventLoop 阶段完成后会去检查这个队列，如果里面有任务，会让这部分任务优先于微任务执行。

## 引用
- [一文带你搞懂JavaScript事件循环](
https://juejin.im/post/5d2036106fb9a07eb15d76e9 )
- [阮一峰：JavaScript 运行机制详解：再谈Event Loop
](http://www.ruanyifeng.com/blog/2014/10/event-loop.html )
- [这一次，彻底弄懂 JavaScript 执行机制
](https://juejin.im/post/59e85eebf265da430d571f89 ) 
- [从浏览器多进程到JS单线程，JS运行机制最全面的一次梳理](https://segmentfault.com/a/1190000012925872#item-7  )
- [浏览器与Node的事件循环(Event Loop)有何区别](https://github.com/ljianshu/Blog/issues/54)