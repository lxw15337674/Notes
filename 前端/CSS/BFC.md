# BFC

## 块格式化上下文（Block Formatting Context，BFC）

CSS 中的一个渲染机制，BFC 就相当于一个盒子，内部的元素与外界的元素互不干扰。它不会影响外部的布局，外部的布局也不会影响到它。

## 形成条件

- 根元素或其它包含它的元素；
- 浮动 (元素的 float 不为 none)；
- 绝对定位元素 (元素的 position 为 absolute 或 fixed)；
- 行内块 inline-blocks(元素的 display: inline-block)；
- 表格单元格(元素的 display: table-cell，HTML 表格单元格默认属性)；
- overflow 的值不为 visible 的元素；
- 弹性盒 flex boxes (元素的 display: flex 或 inline-flex)；

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
