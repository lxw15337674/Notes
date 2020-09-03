# this 指向

this始终指向调用它的那个对象。

![img](https://camo.githubusercontent.com/def60b06a778b4cac63b8a7a157f4a22976907cd/68747470733a2f2f757365722d676f6c642d63646e2e786974752e696f2f323031382f392f32342f313636303733376339633034636538643f773d3130393326683d35383826663d706e6726733d313236313233)


## 场景
1.绑定事件指向事件本身
2.普通函数的，指向方法体。
3.new函数的指向当前类 
4.箭头函数，指向上级上下文
5.call/apply/bind
## 修改this指向的方法
```
    var name = "windowsName";

    var a = {
        name : "Cherry",

        func1: function () {
            console.log(this.name)     
        },

        func2: function () {
            setTimeout(  function () {
                this.func1()
            },100);
        }

    };

    a.func2()     // this.func1 is not a function
```
### es6的箭头函数
箭头函数的this始终指向函数定义时的this，而非执行时。
箭头函数中没有this指向，必须通过查找作用域来决定其值。
```
    var name = "windowsName";

    var a = {
        name : "Cherry",

        func1: function () {
            console.log(this.name)     
        },

        func2: function () {
            setTimeout( () => {
                this.func1()
            },100);
        }

    };

    a.func2()     // Cherry
```
### 使用_this=this
将调用函数的对象保存在变量_this中。
```
    var name = "windowsName";

    var a = {

        name : "Cherry",

        func1: function () {
            console.log(this.name)     
        },

        func2: function () {
            var _this = this;
            setTimeout( function() {
                _this.func1()
            },100);
        }

    };

    a.func2()       // Cherry
```

### 使用apply、call、bind
使用 apply、call、bind 函数也是可以改变 this 的指向。
```
    var a = {
        name : "Cherry",

        func1: function () {
            console.log(this.name)
        },

        func2: function () {
            setTimeout(  function () {
                this.func1()
            }.apply(a),100);
        }

    };

    a.func2()            // Cherry
```

## 面试题


```javascript
var num = 10
const obj = {num: 20}
obj.fn = (function (num) {
  this.num = num * 3
  num++
  return function (n) {
    this.num += n
    num++
    console.log(num)
  }
})(obj.num)
var fn = obj.fn
fn(5)
obj.fn(10)
console.log(num, obj.num)


```

答案

```javascript
\\输出结果: 1,3,3,4,4
var num = 1;
let obj = {
    num: 2,
    add: function() {
        this.num = 3;
        // 这里的立即指向函数，因为我们没有手动去指定它的this指向，所以都会指向window
        (function() {
            // 所有这个 this.num 就等于 window.num
            console.log(this.num);
            this.num = 4;
        })();
        console.log(this.num);
    },
    sub: function() {
        console.log(this.num)
    }
}
// 下面逐行说明打印的内容

/**
 * 在通过obj.add 调用add 函数时，函数的this指向的是obj,这时候第一个this.num=3
 * 相当于 obj.num = 3 但是里面的立即指向函数this依然是window,
 * 所以 立即执行函数里面console.log(this.num)输出1，同时 window.num = 4
 *立即执行函数之后，再输出`this.num`,这时候`this`是`obj`,所以输出3
 */
obj.add() // 输出 1 3

// 通过上面`obj.add`的执行，obj.name 已经变成了3
console.log(obj.num) // 输出3
// 这个num是 window.num
console.log(num) // 输出4
// 如果将obj.sub 赋值给一个新的变量，那么这个函数的作用域将会变成新变量的作用域
const sub = obj.sub
// 作用域变成了window window.num 是 4
sub() // 输出4

```



## 参考

https://segmentfault.com/a/1190000006731988  
https://juejin.im/post/59bfe84351882531b730bac2
[JavaScript 的 this 原理](http://www.ruanyifeng.com/blog/2018/06/javascript-this.html)
