# js的遍历
方法 | 作用
--|--
`for...of`|允许遍历 Arrays（数组）, Strings（字符串）, Maps（映射）, Sets（集合），Arguments Object(参数对象)等可迭代的数据结构，返回的是属性值，但不允许遍历对象(除非使用`Object.keys(obj)`、`Object.values(obj)`、`Object.entries(obj)`)
`for...in`|遍历数组索引、对象的属性，用于遍历可枚举属性，包括自有属性、继承自原型的属性
`forEach` | 遍历数组,调用数组的每个元素，并将元素传递给回调函数。不能正确响应break、continue和return语句。
`array.map()` |遍历数组，与forEach类,区别是不改变原数组，可以使用return返回结果，break，contiune不生效
`Object.getOwnPropertyNames(obj)`|可以得到自身所有的属性(包括不可枚举),但得不到原型链上的属性, Symbols 属性也得不到.
`Reflect.ownKeys(target)`|该方法用于返回对象的所有属性，基本等同于 Object.getOwnPropertyNames() 与 Object.getOwnPropertySymbols 之和。
