层叠上下文（z-index）



一个 DOM 元素，在不考虑层叠上下文的情况下，会按照层叠水平决定元素在 z 轴上的显示顺序，通俗易懂地讲，不同的 DOM 元素组合在一起发生重叠的时候，它们的的显示顺序会遵循层叠水平的规则，而 z-index 是用来调整某个元素显示顺序，使该元素能够上浮下沉。

## 比较两个DOM元素显示顺序
- 如果是在相同的层叠上下文，按照层叠水平的规则来显示元素
- 如果是在不同的层叠上下文中，先找到共同的祖先层叠上下文，然后比较共同层叠上下文下这个两个元素所在的局部层叠上下文的层叠水平。

![7阶层叠水平](https://user-gold-cdn.xitu.io/2019/2/21/16910b0d024ec8e8?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

https://juejin.im/post/6844903781004476423
https://juejin.im/post/6844903667175260174
https://segmentfault.com/a/1190000019011282