# mixins 的实践与解析

vue 提供了 mixins 这个 API，可以让我们将组件中的可复用功能抽取出来，放入 mixin 中，然后在组件中引入 mixin，可以让组件显得不再臃肿，提高了代码的可复用性。

如何理解 mixins 呢 ？我们可以将 mixins 理解成一个数组，数组中有单或多个 mixin，mixin 的本质就是一个 JS 对象，它可以有 data、created、methods 等等 vue 实例中拥有的所有属性，甚至可以在 mixins 中再次嵌套 mixins，It's amazing !

mixins 与 Vue Instance 合并规则：

1. 会将 created 等钩子函数合并成数组，mixins 的钩子优先调用。
2. 当 data、methods 对象键值冲突时，以组件优先。

举个简单的栗子:

```
<div id="app">
  <h1>{{ message }}</h1>
</div>
```



```
const myMixin = {
  data() {
    return {
      message: 'this is mixin message'
    }
  },
  created() {
    console.log('mixin created')
  }
}

const vm = new Vue({
  el: '#app',
  mixins: [myMixin],
  data() {
    return {
      message: 'this is vue instance message'
    }
  },
  created() {
    console.log(this.message)
    // => Root Vue Instance
    console.log('vue instance created')
    // => created myMixin
    // => created Root Vue Instance
  }
})
```







