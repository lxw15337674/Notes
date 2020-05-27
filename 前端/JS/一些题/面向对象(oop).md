 OOP （Object Oriented Programming）
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