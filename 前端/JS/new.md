# new

根据构造函数创建对象

## 步骤

- 创建空对象 obj，并原型指向构造函数的原型。
- 改变 this 的指向,传递参数。
- 如果返回值为对象则返回该对象，如果无返回值或返回值部位对象则返回 obj 对象。

```
function myNew(Fn,...arg){
  // 创建新对象,并继承构造方法的prototype属性, 这一步是为了把obj挂原型链上, 相当于obj.__proto__ = Foo.prototype
    const obj = Object.create(Fn.prototype);
      // 执行构造方法, 并为其绑定新this, 这一步是为了让构造方法能进行this.name = name之类的操作, args是构造方法的入参, 因为这里用myNew模拟, 所以入参从myNew传入
    const obj1 = Fn.apply(obj, arg);
      // 如果构造方法已经return了一个对象, 那么就返回该对象, 一般情况下，构造方法不会返回新实例，但使用者可以选择返回新实例来覆盖new创建的对象 否则返回myNew创建的新对象
    return obj1 instanceof Object ? obj1 : obj;
}
```
