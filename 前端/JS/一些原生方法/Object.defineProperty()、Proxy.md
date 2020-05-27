### Object.defineProperty()
#### 参数

属性|描述
---|---
Configurable|能否用 delete 删除属性从而重新定义属性。默认为 true
Enumerable|能否通过 for-in 遍历，即是否可枚举。默认为 true
Writable|是否能修改属性的值。默认为 true
Value|包含这个属性的数据值，读写属性的时候其实就在这里读写。默认为 undefined
get|读取属性时调用的函数，默认 undefined
set|写入属性时调用的函数，默认 undefined
#### 缺点
- 无法监听数组的变化（目前的数组监听都基于对原生数组的一些方法进行hack，所以如果要使数组响应化，需要注意使用Vue官方推荐的一些数组方法）
- 无法深层次监听对象属性
- 无法对整个对象进行劫持。
#### 使用
先考虑这么一个场景,在你的项目中你有这么一个对象如下所示:
```javascript
var dreamapple = {
    firstName: 'dream',
    lastName: 'apple'
};
```
我们的要求就是你要给`dreamapple`添加一个`fullName`属性,当`dreamapple`的`firstName`或者`lastName`发生变化的时候,`fullName`也要随之变化;而且当我们设置了`fullName`的值的时候,那么相应的它的`firstName`和`lastName`也随之发生变化; 那么我们应该怎么做呢?

如果你使用过`Vue.js`的话,那么你可以使用它的`计算属性`来达到这个目的,大概的代码应该是下面这个样子:
```javascript
// ...
computed: {
  fullName: {
    // getter
    get: function () {
      return this.firstName + ' ' + this.lastName
    },
    // setter
    set: function (newValue) {
      var names = newValue.split(' ')
      this.firstName = names[0]
      this.lastName = names[names.length - 1]
    }
  }
}
// ...
```
那我们使用原生的`JavaScript`可不可以达到这个目的呢?当然可以了;那么我们需要怎么做呢?比较简单的做法就是给这个对象的属性`fullName`设置一个`getter`和一个`setter`,因为这是`ES5`的特性所以较低版本的浏览器不支持这种特性,但是基本所有的现代浏览器都已经支持.我们只需要写出下面的代码就可以了:

```javascript
var dreamapple = {
    firstName: 'dream',
    lastName: 'apple',
    get fullName() {
        return this.firstName + ' ' + this.lastName;
    },
    set fullName(fullName) {
        var names = fullName.trim().split(' ');
        if(2 === names.length) {
            this.firstName = names[0];
            this.lastName = names[1];
        }
    }
};

dreamapple.firstName = 'Dream';
dreamapple.lastName = 'Apple';
console.log(dreamapple.fullName); // Dream Apple

dreamapple.fullName = 'Jams King';
console.log(dreamapple.firstName); // Jams
console.log(dreamapple.lastName); // King
```
是不是很方便呢?我们通过给`dreamapple`这个对象设置了属性`fullName`的`getter`和`setter`方法,就达到了我们想要的那种效果.

当然更好的一种方法就是使用[`Object.defineProperty()`][1]这个函数了,下面我们就来好好的探讨一下这个函数.这个方法的作用就是直接在一个对象上定义一个新属性,或者修改一个已经存在的属性,并返回这个对象;我们先来看一下怎么使用这个方法:
```javascript
Object.defineProperty(obj, prop, descriptor)
```
其中参数`obj`表示的是需要定义属性的那个对象,参数`prop`表示需要被定义或者修改的属性名,参数`descriptor`就是我们定义的那个属性`prop`的描述;我们接下来主要讲解这个`descriptor`.它是一个对象,它有许多的属性,我们接下来来分析这些属性都是干什么用的:

+ **value** 该属性对应的值,可以是任何有效的JavaScript值(数值,对象,函数等),默认为`undefined`.我们可以看下面的一个小例子:
    ```javascript
    var dream = {};
    Object.defineProperty(dream, 'name', {
        value: 'dreamapple'
    });
    
    console.log(dream.name); // dreamapple
    dream.name = 'apple'; // 修改name属性
    console.log(dream.name); // 并不是apple,依旧是dreamapple
    ```
从上面的代码中我们可以看到,我们给`dream`定义了一个新的属性`name`,然后我们打印出这个属性就是我们预期的那样,得到的是`dreamapple`;但是,当我们尝试改变这个属性的时候,却发现这个属性并没有改变,还以第一次我们赋给它的值;这是为什么呢?原来,只有当我们这个属性的`writable`修饰为`true`时,我们这个属性才可以被修改.

+ **writable** 当且仅当仅当该属性的`writable`为`true`时,该属性才能被赋值运算符改变;它的默认值为false.我们来修改一下上面的代码,让属性`name`可以被修改:
    ```javascript
    Object.defineProperty(dream, 'name', {
        value: 'dreamapple',
        writable: true
    });
    
    console.log(dream.name); // dreamapple
    dream.name = 'apple'; // 修改name属性
    console.log(dream.name); // apple
    ```
我们可以看到,当我们把`writable`修改为`true`时,我们就可以修改`name`属性了.

+ **enumerable** 这个特性决定了我们定义的属性是否是可枚举的类型,默认是`false`;只有我们把它设置为`true`的时候这个属性才可以使用`for(prop in obj)`和`Object.keys()`中枚举出来.就像下面这样:
    ```javascript
    Object.defineProperty(dream, 'a', {
        value: 1,
        enumerable: false // 不可枚举
    });
    Object.defineProperty(dream, 'b', {
        value: 2,
        enumerable: true // 可枚举
    });
    
    // 只会输出 b
    for(prop in dream) {
        console.log(prop);
    }
    
    console.log(Object.keys(dream)); // ['b']
    
    console.log(dream.propertyIsEnumerable('a')); // false
    console.log(dream.propertyIsEnumerable('b')); // true
    ```
所以当我们想给你个对象添加一个不可枚举的属性的时候,就应该把`enumerable`设置为`false`.

+ **configurable** 这个特性决定了对象的属性是否可以被删除,以及除`writable`特性外的其它特性是否可以被修改;并且`writable`特性值只可以是`false`我们可以写一个代码示例来演示一下这个特性:
    ```javascript
    Object.defineProperty(dream, 'c', {
        value: 3,
        configurable: false
    });
     //throws a TypeError
    Object.defineProperty(dream, 'c', {
        configurable: true
    });
     //throws a TypeError
    Object.defineProperty(dream, 'c', {
        writable: true
    });
     //won't throws a TypeError
    Object.defineProperty(dream, 'c', {
        writable: false
    });
    delete dream.c; // 属性不可以被删除
    console.log(dream.c); // 3 
    ```
+ **get** 一个给属性提供`getter`的方法,如果没有`getter`则为`undefined`;该方法返回值被用作属性值,默认为undefined.
+ **set** 一个给属性提供`setter`的方法,如果没有`setter`则为`undefined`;该方法将接受唯一参数,并将该参数的新值分配给该属性,默认为undefined.知道了这些之后我们就可以使用更标准的一种方式去解决我们在文中开头的问题了:
    
    ```javascript
    Object.defineProperty(dreamapple, 'fullName', {
        enumerable: true,
        get: function () {
            return this.firstName + ' ' + this.lastName;
        },
        set: function (fullName) {
            var names = fullName.trim().split(' ');
            if (2 === names.length) {
                this.firstName = names[0];
                this.lastName = names[1];
            }
        }
    });
    ```
还有一点需要注意的是,`value`和`get,set`是不可以共存的,就是说你定义了`value`后就不能够再定义`get,set`特性了.


### [MDN详解](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty)

## Vue3.x 响应式数据原理
### proxy
### 区别
Vue2 中，对于给定的 data，如 { count: 1 }，是需要根据具体的 key 也就是 count，去对「修改 data.count 」 和 「读取 data.count」进行拦截
```
Object.defineProperty(data, 'count', {
  get() {},
  set() {},
})
```
而 Vue3 所使用的 Proxy，拦截的「修改 data 上的任意 key」 和 「读取 data 上的任意 key」。而且可以拦截更多的操作符
```
new Proxy(data, {
  get(key) { },
  set(key, value) { },
})
```
### Proxy.revocable() 
Proxy.revocable方法返回一个可取消的 Proxy 实例。
```
let target = {};
let handler = {};

let {proxy, revoke} = Proxy.revocable(target, handler);

proxy.foo = 123;
proxy.foo // 123

revoke();
proxy.foo // TypeError: Revoked
```
#### 应用场景
目标对象不允许直接访问，必须通过代理访问，一旦访问结束，就收回代理权，不允许再次访问。

### 拦截操作
#### get(target, propKey, receiver)
拦截对象属性的读取，比如`proxy.foo`和`proxy['foo']`。
#### set(target, propKey, value, receiver)
拦截对象属性的设置，比如`proxy.foo = v`或`proxy['foo'] = v`，返回一个布尔值。
#### has(target, propKey)
拦截`propKey in proxy`的操作，返回一个布尔值。
#### deleteProperty(target, propKey)
拦截`delete proxy[propKey]`的操作，返回一个布尔值。
#### ownKeys(target)
拦截对象自身属性的读取操作。返回目标对象所有自身的属性的属性名，而Object.keys()的返回结果仅包括目标对象自身的可遍历属性。
#### 拦截的操作
- `Object.getOwnPropertyNames(proxy)`
- `Object.getOwnPropertySymbols(proxy)`
- `Object.keys(proxy)`
- `for...in`

#### getOwnPropertyDescriptor(target, propKey)
拦截`Object.getOwnPropertyDescriptor(proxy, propKey)`，返回属性的描述对象。
#### defineProperty(target, propKey, propDesc)
拦截`Object.defineProperty(proxy, propKey, propDesc）`、`Object.defineProperties(proxy, propDescs)`，返回一个布尔值。
#### preventExtensions(target)
拦截`Object.preventExtensions(proxy)`，返回一个布尔值。
> Object.preventExtensions():让一个对象变的不可扩展,也就是永远不能再添加新的属性。

#### getPrototypeOf(target)
用来拦截获取对象的原型，返回一个对象。
##### 拦截的操作
- `Object.prototype.__proto__`
- `Object.prototype.isPrototypeOf()`
- `Object.getPrototypeOf()`
- `Reflect.getPrototypeOf()`
- `instanceof`

#### isExtensible(target)：
拦截`Object.isExtensible(proxy)`，返回一个布尔值。
> `Object.isExtensible(proxy)`判断一个对象是否是可扩展的

#### setPrototypeOf(target, proto)
拦截`Object.setPrototypeOf(proxy, proto)`，返回一个布尔值。如果目标对象是函数，那么还有两种额外操作可以拦截。
> `Object.setPrototypeOf(proxy, proto)`设置一个指定的对象的原型 

#### apply(target, object, args)
拦截 Proxy 实例作为函数调用的操作，比如`proxy(...args)、proxy.call(object, ...args)`、`proxy.apply(...)`。
#### 默认操作
```
var handler = {
  apply (target, ctx, args) {
    return Reflect.apply(...arguments);
  }
};
```
#### construct(target, args)
拦截 Proxy 实例作为构造函数调用的操作，比如`new proxy(...args)`。
#### 默认方法
```
var handler = {
  construct (target, args, newTarget) {
    return new target(...args);
  }
};
```
### 详解
https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Proxy

## Proxy 与 Object.defineProperty 优劣对比
### proxy优势
- Proxy 可以直接监听对象而非属性；
- Proxy 可以直接监听数组的变化；
- Proxy 有多达 13 种拦截方法,不限于 apply、ownKeys、deleteProperty、has 等等是 Object.defineProperty 不具备的；
- Proxy 返回的是一个新对象,我们可以只操作新的对象达到目的,而 Object.defineProperty 只能遍历对象属性直接修改；
- Proxy 作为新标准将受到浏览器厂商重点持续的性能优化，也就是传说中的新标准的性能红利。

### Object.defineProperty 的优势
- 兼容性好，支持 IE9，而 Proxy 的存在浏览器兼容性问题,而且无法用 polyfill 磨平，因此 Vue 的作者才声明需要等到下个大版本( 3.0 )才能用 Proxy 重写。