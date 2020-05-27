 OOP （Object Oriented Programming）
> 面向对象三要素：
 封装: 创建一个对象，集中存储一个事务的属性和功能
 继承: 父对象的成员，子对象无需创建可直接使用
 多态: 同一失误，在不用情况下，表现出不同的状态
>
写一个类Person，拥有属性age和name，拥有方法say(something)，
再写一个类Superman，继承Person，拥有自己的属性power，拥有自己的方法fly(height) ES5方式
```
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