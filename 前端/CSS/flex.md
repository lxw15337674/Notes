# flex

## 容器属性

- flex-direction 控制主副轴
  - row（默认值）：主轴为水平方向，起点在左端。
  - row-reverse：主轴为水平方向，起点在右端。
  - column：主轴为垂直方向，起点在上沿。
  - column-reverse：主轴为垂直方向，起点在下沿。
- flex-wrap 控制换行(默认不换行)
  - nowrap：不换行
  - wrap ：换行，从上往下。
  - wrap-reverse：换行，从下往上。
- flex-flow 是 flex-direction 和 flex-wrap 的结合
- justify-content 主轴对齐方式
  - flex-start ：左对齐
  - flex-end：右对齐
  - center：居中
  - space-between：两端对齐，项目之间间距相等
  - space-around：每个项目两侧的间隔相等。所以，项目之间的间隔比项目与边框的间隔大一倍。
- align-items 交叉轴对齐方式
  - flex-start：交叉轴起点对齐
  - flex-end：交叉轴终点对齐
  - center：交叉轴的重点对齐。
  - baseline：以项目第一行文字的基线对齐
  - stretch：如果项目未设置高度或 auto，将占满整个容器高度
- align-content：多根轴线的对齐方式
  - flex-start：与交叉轴的起点对齐。
  - flex-end：与交叉轴的终点对齐。
  - center：与交叉轴的中点对齐。
  - space-between：与交叉轴两端对齐，轴线之间的间隔平均分布。
  - space-around：每根轴线两侧的间隔都相等。所以，轴线之间的间隔比轴线与边框的间隔大一倍。
  - stretch（默认值）：轴线占满整个交叉轴。

## 项目（子元素）的属性

- order：定义项目的排列顺序。数值越小，排列越靠前，默认为 0。
- flex-grow：项目的放大比例，默认为 0，即如果存在剩余空间，也不放大。
- flex-shrink：项目的缩小比例，默认为 1，即如果空间不足，该项目将缩小。
- flex-basis: 定义在分配多余空间之前，项目占据的主轴空间（main size）。
- flex: flex :是 flex-grow, flex-shrink 和 flex-basis 的简写，默认值为 0 1 auto。后两个属性可选。
- align-self:允許单个项目有与其他项目不一样的对齐方式，可覆盖 align-items 属性。默认值为 auto，表示继承父元素的 align-items 属性，如果没有父元素，则等同于 stretch。

## 引用

[Flex 布局教程：语法篇](http://www.ruanyifeng.com/blog/2015/07/flex-grammar.html)
