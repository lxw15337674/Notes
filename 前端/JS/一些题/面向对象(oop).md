 OOP （Object Oriented Programming）
> 面向对象三要素：
 封装: 将对数据的操作细节隐藏起来，只暴露对外的接口。外界调用端不需要（也不可能）知道细节，就能通过对外提供的接口来访问该对象，同时也保证了外界无法任意更改对象内部的数据。
 继承: 子类继承父类，子类除了拥有父类的所有特性外，还有一些更具体的特性。
 多态: 由继承而产生了相关的不同的类，对同一个方法可以有不同的响应。比如 Cat 和 Dog 都继承自 Animal，但是分别实现了自己的 eat 方法。此时针对某一个实例，我们无需了解它是 Cat 还是 Dog，就可以直接调用 eat 方法，程序会自动判断出来应该如何执行 eat。
>
写一个类Person，拥有属性age和name，拥有方法say(something)，
再写一个类Superman，继承Person，拥有自己的属性power，拥有自己的方法fly(height) ES5方式
```
// 寄生组合式继承
function Person(age, name) {
    this.age = age
    this.name = name
}
Person.prototype.say = function (something) {
    console.log(`say:${something}`)
}

function Superman(name, age, power) {
    Person.call(this, ...arguments)
    this.power = power
}
Superman.prototype = new Person()

Superman.prototype.fly = function (height) {
    console.log(`fly:${height}`)
}

let a = new Superman(1, 2, 3)
a.fly(22)
```