## this 指向
this始终指向调用它的那个对象。


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



## 参考
https://segmentfault.com/a/1190000006731988  
https://juejin.im/post/59bfe84351882531b730bac2