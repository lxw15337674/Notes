# async

## 含义
- Generator函数的语法糖，将*改成async，将yield换成await。
- 是对Generator函数的改进, 返回promise。
- 异步写法同步化，遇到await先返回，执行完异步再执行接下来的.
- 内置执行器, 无需next()


## generator（生成器）
### 用法：
通过yield关键字，把函数的执行流挂起，通过next()方法可以切换到下一个状态。
### 详解
[MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Generator)


## co函数
实现自动调用next方法
```
co(it){
    return new Promise((resolve,reject)=>{
        function next(val){
            {value,done}=it.next(val)  //手动next程序到第一个yield的地方
            if(done){ //都已经成功了还有什么好说的，直接返回结果就行了
                resolve(value)
            }else{
                return Promise.resolve(value).then(next,rejext)  
            }
        }
        next(undefined)
    })
}
co(read()).then((data)=>{
    console.log(data)
})
```
##


## 引用
[前端面试必备——异步（async）](https://segmentfault.com/a/1190000022097995/)  
[冴羽 BLOG](https://github.com/mqyqingfeng/Blog/issues/100)
## 面试题

### setTimeout、Promise、Async/Await 的区别？JS 异步解决方案的发展历程以及优缺点？

回调函数
缺点：回调地狱 没有返回值
promise
优点：解决回调地狱，提供的一些方法还是挺好用的
缺点：还是要写大量回调函数，挺麻烦的；错误必须捕获（不捕获反应不到外面）
generaotr
缺点：需要写next,或者说缺一个自执行器
async await
优点 可以用try catch 捕获异常，将异步代码改成同步代码
缺点 如果几个await没有依赖性，会有性能问题，这个啥意思呢，

### Async/Await 如何通过同步的方式实现异步
解释下generator+手写一个co函数

