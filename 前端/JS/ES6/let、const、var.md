# let、const和var的区别？

let/const 也存在变量声明提升，只是没有初始化分配内存。 一个变量有三个操作，声明(提到作用域顶部)，初始化(赋默认值)，赋值(继续赋值)。

- var 是一开始变量声明提升，然后初始化成 undefined，代码执行到那行的时候赋值。
- let 是一开始变量声明提升，然后没有初始化分配内存，代码执行到那行初始化，之后对变量继续操作是赋值。因为没有初始化分配内存，所以会报错，这是暂时性死区。
- const 是只有声明和初始化，没有赋值操作，所以不可变。

- var声明变量可以重复声明，而let不可以重复声明
- var是不受限于块级的，声明会提升，而let是受限于块级，仅在该块级内起作用
- var会与window相映射（会挂一个属性），而let不与window相映射
- var可以在声明的上面访问变量，而let有暂存死区，在声明的上面访问变量会报错
- const声明之后必须赋值，否则会报错
- const定义不可变的量，改变了就会报错
- const和let一样不会与window相映射、支持块级作用域、在声明的上面访问变量会报错

> 变量提升
> - 所有的声明都会提升到作用域的最顶上去。
> - 函数声明的优先级高于变量申明的优先级，并且函数声明和函数定义的部分一起被提升。



块级作用域:
```
if(true){
  var color = "red"
}
console.log(color)  //'red'

if(true){
  let color = 'red'
}
console.log(color) //ReferenceError
```


#### 在es5环境下实现let
![image](https://user-gold-cdn.xitu.io/2020/4/5/1714616e2fd53bf8?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

####  在es5环境下实现const

```
function _const(key, value) {    
    const desc = {        
        value,        
        writable: false    
    }    
    Object.defineProperty(window, key, desc)
}
    
_const('obj', {a: 1})   //定义obj
obj.b = 2               //可以正常给obj的属性赋值
obj = {}                //抛出错误，提示对象read-only

```

## 详解

[let 和 const 命令
](https://es6.ruanyifeng.com/#docs/let)