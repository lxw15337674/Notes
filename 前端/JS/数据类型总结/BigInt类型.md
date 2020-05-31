# BigInt类型
在JS中，Number类型都以双精度64位浮点格式表示（表示-9007199254740991(-(2^53-1))和9007199254740991（(2^53-1)），导致过大的数字会导致失去精度。
为解决这个问题，新增BigInt新的数据类型，用于当整数值大于Number数据类型支持的范围时。
```
console.log(999999999999999);  //=>10000000000000000
9007199254740992 === 9007199254740993;    // => true 
```
## 创建BigInt方式
1. 在数字末尾追加n
```
console.log( 9007199254740995n );    // → 9007199254740995n
```
2. 用BigInt()构造函数
```
BigInt("9007199254740995")
```
## 注意点
1. BigInt不支持一元加号运算符

```
let a = 123n
a += 1 
//VM369:2 Uncaught TypeError: Cannot mix BigInt and other types, use explicit conversions
a++
//124n
```
2. 不允许在bigint和 Number 之间进行混合操作
```
10 + 10n;    // → TypeError
```
3. 不能将BigInt传递给Web api和内置的 JS 函数，这些函数需要一个 Number 类型的数字。尝试这样做会报TypeError错误。
```
Math.max(2n, 4n, 6n);    // → TypeError

```
4. 当 Boolean 类型与 BigInt 类型相遇时，BigInt的处理方式与Number类似，换句话说，只要不是0n，BigInt就被视为truthy的值。
```
if(0n){//条件判断为false

}
if(3n){//条件为true

}
```
5. 元素都为BigInt的数组可以进行sort。
6. BigInt可以正常地进行位运算，如|、&、<<、>>和^
7. BigInt 与普通整数是两种值，它们之间并不相等。
```
42n === 42 // false
```

