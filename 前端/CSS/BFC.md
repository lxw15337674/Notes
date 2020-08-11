# BFC

## 块格式化上下文（Block Formatting Context，BFC）

CSS 中的一个渲染机制，BFC 就相当于一个盒子，内部的元素与外界的元素互不干扰。它不会影响外部的布局，外部的布局也不会影响到它。

## 形成条件

- float为 left|right
- overflow为 hidden|auto|scroll
- display为 table-cell|table-caption|inline-block|inline-flex|flex
- position为 absolute|fixed
- 根元素

## BFC布局规则

- 内部的Box会在垂直方向，一个接一个地放置(即块级元素独占一行)。
- BFC的区域不会与float box重叠(**利用这点可以实现自适应两栏布局**)。
- 内部的Box垂直方向的距离由margin决定。属于同一个BFC的两个相邻Box的margin会发生重叠(**margin重叠三个条件:同属于一个BFC;相邻;块级元素**)。
- 计算BFC的高度时，浮动元素也参与计算。（清除浮动 haslayout）
- BFC就是页面上的一个隔离的独立容器，容器里面的子元素不会影响到外面的元素。反之也如此。

## 特性

- 内部的盒子会在垂直方向上一个接一个的放置
- 对于同一个 BFC 的俩个相邻的盒子的 margin 会发生重叠，与方向无关。
- 每个元素的左外边距与包含块的左边界相接触（从左到右），即使浮动元素也是如此
- BFC 的区域不会与 float 的元素区域重叠
- 计算 BFC 的高度时，浮动子元素也参与计算
- BFC 就是页面上的一个隔离的独立容器，容器里面的子元素不会影响到外面的元素，反之亦然

## 使用场景

- 解决边距重叠问题
- BFC 不与 float 元素重叠
- 清除浮动（父级元素会计算浮动元素的高度）

## 应用场景

- 清除浮动：BFC 内部的浮动元素会参与高度计算，因此可用于清除浮动，防止高度塌陷
- 避免某元素被浮动元素覆盖：BFC 的区域不会与浮动元素的区域重叠
- 阻止外边距重叠：属于同一个 BFC 的两个相邻 Box 的 margin 会发生折叠，不同 BFC 不会发生折叠

![image](https://user-gold-cdn.xitu.io/2020/4/6/1714e0acba58457f?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

## 详解

https://developer.mozilla.org/zh-CN/docs/Web/Guide/CSS/Block_formatting_context

https://juejin.im/post/59b73d5bf265da064618731d

http://47.98.159.95/my_blog/css/008.html

https://github.com/ljianshu/Blog/issues/15