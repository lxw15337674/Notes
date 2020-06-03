# js的遍历
方法 | 作用
--|--
`for` | 前测试循环语句
`for...of`|允许遍历 Arrays（数组）, Strings（字符串）, Maps（映射）, Sets（集合），Arguments Object(参数对象)等可迭代的数据结构，返回的是属性值，但不允许遍历对象(除非使用`Object.keys(obj)`、`Object.values(obj)`、`Object.entries(obj)`)
`for...in`|遍历数组索引、对象的属性，用于遍历可枚举属性，包括自有属性、继承自原型的属性
`forEach` | 遍历数组,调用数组的每个元素，并将元素传递给回调函数。不能正确响应break、continue和return语句。
`array.map()` |遍历数组，与forEach类,区别是不改变原数组，可以使用return返回结果，break，contiune不生效
`Object.getOwnPropertyNames(obj)`|可以得到自身所有的属性(包括不可枚举),但得不到原型链上的属性, Symbols 属性也得不到.
`Reflect.ownKeys(target)`|该方法用于返回对象的所有属性，基本等同于 Object.getOwnPropertyNames() 与 Object.getOwnPropertySymbols 之和。
```
Reflect.ownKeys()遍历规则:
    - 首先遍历所有数值键，按照数值升序排列。
    - 其次遍历所有字符串键，按照加入时间升序排列。
    - 最后遍历所有 Symbol 键，按照加入时间升序排列。
Reflect.ownKeys({ [Symbol()]:0, b:0, 10:0, 2:0, a:0 })
// ['2', '10', 'b', 'a', Symbol()]
```

>
    for (let i = 0; i < 10; i++) {
        array.push(i)
    }
    //[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>