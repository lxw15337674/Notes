## 一句话总结Promise：
用于解决异步操作结束后的方法执行问题。

## 诞生原因
最开始解决异步函数的方法是回调函数，将要执行的函数作为参数，传入异步操作中。导致会无限嵌套，也就是回掉地狱，影响代码可读性。例如`asyncfn1(asyncfn2(asyncfn3()))`。

## 原理
将要执行的函数放入一个队列里，在异步函数执行结束后执行这个队列。

## 特点
1. 不受外界影响，由执行函数内部决定成功和失败。
2. 一旦状态改变，就不会再变。状态共三种：
- `pending`，初始态（执行态），代表执行中。
- `fulfilled`成功态，代表操作成功完成。
- `rejected`失败态，代表操作失败。
## 缺点
1. 错误必须被捕获（不捕获反应不到外面）。
2. 需要写回调函数。
3. 一旦新建就会立即执行，无法中途取消。
4. 无法得知pending状态，当处于 pending 状态时，无法得知目前进展到哪一个阶段（刚刚开始还是即将完成）。

### 参数
#### executor
executor作为接收`resolve`和`reject`的函数。
`resolve` 是用于处理操作成功结束的情况，会将`promise`对象的状态从执行态转为成功态，并将异步操作的结果作为参数传递出去。
`reject` 是用于处理操作失败的情况，将`promise` 对象的状态从执行态转为失败态，并将错误作为参数传递出去。

### 原型方法
#### `Promise.prototype.then(onFulfilled,onRejected)`  
将成功和失败的执行函数传入promise，返回一个新的promise，将返回值做为resolve。  

#### `Promise.prototype.catch(onRejected)`  
只处理失败情况，相当于`  
Promise.prototype.then(undefined, onRejected) `  

#### `Promise.prototype.finall(onFinally)`  

不管成功失败都会执行的函数，并且会把之前的值原封不动的传递给后面的then  


### 方法
#### `resolve(value) `
返回一个带有成功值的promise对象，如果参数是promise，则返回参数。  

#### `reject(value)`
返回一个带有拒绝值的promise对象，如果参数是promise，则返回参数。  

#### `all(iterable)`
返回一个promise，执行参数迭代器中所有的promise，如果都正确，则返回一个所有promise结果的列表，如果有一个失败，则返回第一个失败结果。

#### `race(iterable)`
返回一个promise，执行参数迭代器中所有的promise，返回最先执行完成的promise结果。

#### `allSettled(iterable)`
返回一个promise，执行参数迭代器中所有的promise，只有等到所有参数实例都返回结果，才会结束。返回一个所有promise结果的列表，每个对象都有`status`属性，该属性的值只可能是字符串`fulfilled`或字符串`rejected`。`fulfilled`时，对象有`value`属性，`rejected`时有`reason`属性，对应两种状态的返回值。

#### `any(iterable)`
返回一个promise，执行参数迭代器中所有的promise。只要参数实例有一个变成`fulfilled`状态，包装实例就会变成`fulfilled`状态；如果所有参数实例都变成`rejected`状态，包装实例就会变成`rejected`状态。

```javascript
const resolved = Promise.resolve(42);
const rejected = Promise.reject(-1);

const allSettledPromise = Promise.allSettled([resolved, rejected]);

allSettledPromise.then(function (results) {
  console.log(results);
});
// [
//    { status: 'fulfilled', value: 42 },
//    { status: 'rejected', reason: -1 }
// ]
```

## 实现
## 参考
https://juejin.im/post/5e3b9ae26fb9a07ca714a5cc
https://github.com/xieranmaya/blog/issues/3
###  简单版实现
```javascript
class myPromise{
    constructor(fn){
        this.resolveQueue = []
        this.rejectQueue = []
        let _resolve = (resolve) =>{
            for(let fn of this.resolveQueue){
                fn(resolve)
            }
        }
        let _reject = (reject)=>{
            for(let fn of this.resolveQueue){
                fn(reject)
            }
        }
        fn(_resolve,_reject)
    }
    then(resolveFn,rejectFn){
        this.resolveQueue.push(resolveFn)
        this.rejectQueue.push(rejectFn)
    }
}
const p1 = new myPromise((resolve, reject) => {
  setTimeout(() => {
    resolve('result')
  }, 1000);
})
p1.then(res => console.log(res))
//一秒后输出result
```



完整实现：
```javascript
//Promise/A+规范的三种状态
const PENDING = 'pending'
const FULFILLED = 'fulfilled'
const REJECTED = 'rejected'

class myPromise {
    constructor(executor) {
        this.status = PENDING
        this.data = null
        this.resolveQueue = []
        this.rejectQueue = []
        let resolve = (value) => {
            let run = () => {
                if (this.status !== PENDING) return
                this.status = FULFILLED
                this.data = null
                for (let callback of this.resolveQueue) {
                    callback(value)
                }
            }
            setTimeout(run)
        }
        let reject = (reason) => {
            let run = () => {
                if (this.status !== PENDING) return
                this.status = REJECTED
                this.data = null
                for (let callback of this.rejectQueue) {
                    callback(reason)
                }
            }
            setTimeout(run)
        }
        executor(resolve, reject)
    }
    then(resolveFn, rejectFn) {
        return new myPromise((resolve, reject) => {
            let fulfilledfn = value => {
                try {
                    resolve(resolveFn(value))
                }
                catch (error) {
                    reject(error)
                }
            }
            let rejectedFn = error => {
                try {
                    resolve(rejectFn(error))
                } catch (error) {
                    reject(error)
                }
            }
            switch (this.status) {
                case PENDING:
                    this.resolveQueue.push(fulfilledfn);
                    this.rejectQueue.push(rejectedFn)
                    break
                case FULFILLED:
                    fulfilledfn(this.data)
                    break
                case REJECTED:
                    rejectFn(this.data)
                    break
            }
        })
    }
    catch(rejectFn) {
        return this.then(null, rejectFn)
    }
    finally(callback) {
        return this.then(
            (res) => {
                callback()
                return res
            },
            (res) => {
                callback()
                throw res
            }
        )
    }
    resolve(value) {
        return new Promise(resolve => resolve(value))
    }
    reject(value) {
        return new Promise((reject, reject) => { this.reject(value) })
    }
    all(promiseList) {
        let list = []
        return new Promise((resolve, reject) => {
            promiseList.forEach((p, i) => {
                resolve(p).then(
                    val => {
                        list.push(val)
                        if (i === promiseList.length) {
                            resolve(result)
                        }
                    },
                    err => {
                        reject(err)
                    }
                )
            })

        })
    }
    race(promiseArr) {
        return new myPromise((resolve, reject) => {
            for (let p of promiseArr) {
                resolve(p).then(
                    value => {
                        resolve(value)
                    },
                    err => {
                        reject(err)
                    }
                )
            }
        })
    }
}


new myPromise(function (resolve, reject) {
    setTimeout(() => {
        console.log('test')
        resolve(2)
    }, 1000)
    resolve(2)
}).then((res) => {
    console.log(`res1${res}`)
    return 3
}).then(res => {
    console.log(`res2${res}`)
    return 4
}).then(res => {
    console.log(`res3${res}`)
    return 5
}).finally(() => {
    console.log('test')
}).then(res => {
    console.log(res)
})


​```~
```

## 引用

https://github.com/ljianshu/Blog/issues/81
[详解Promise/Promise/A+ 规范](https://www.jianshu.com/p/2207b01e1174)
