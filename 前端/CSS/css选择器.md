# css 选择器
## 选择器类型
选择器分为五类：
- 元素选择器
- 关系选择器
- 属性选择器
- 伪类选择器
- 伪对象选择器

### 元素选择器
选择器|名称|描述
--|--|--|
* | 通配选择器 | 选择所有的元素
p | 元素选择器 | 选择指定的元素
`#idName` |id选择器 | 选择id属性为idName的元素
`.className` | class选择器 | 选择class属性包含className的元素

### 关系选择器
选择器|名称|描述
--|--|--|
`E F`  | 包含选择器 | 选择所有包含在E元素里面的F元素
`E>F` | 子选择器 | 选择所有作为E元素的子元素F
`E+F` | 相邻选择器 | 选择紧贴在E元素之后的F元素
`E~F` | 兄弟选择器 | 选择E元素所有兄弟元素F

### 属性选择器
选择器 | 描述
--|--|
`E[att]` | 选择具有att属性的E元素
`E[att="val"]`|	选择具有att属性且属性值等于val的E元素
`E[att~="val"]`|	选择具有att属性且属性值其中一个等于val的E元素（包含只有一个值且该值等于val的情况）
`E[att|="val"]`	| 选择具有att属性且属性值为以val开头并用连接符-分隔的字符串的E元素，如果属性值仅为val，也将被选择
`E[att^="val"]`	| 选择具有att属性且属性值为以val开头的字符串的E元素
`E[att$="val"]`	| 选择具有att属性且属性值为以val结尾的字符串的E元素
`E[att*="val"]`	| 选择具有att属性且属性值为包含val的字符串的E元素

### 伪类选择器
选择器 | 描述
--|--|
E:link | 设置超链接a在未被访问前的样式
E:visited | 设置超链接a已被访问过时的样式
E:hover | 设置元素鼠标在其悬停时的样式
E:active | 设置元素在被用户激活（在鼠标点击与释放之间发生的事件）时的样式
E:focus	|设置元素在成为输入焦点（该元素的onfocus事件发生）时的样式。(一般应用于表单元素)
E:checked|	匹配用户界面上处于选中状态的元素E。(用于input type为radio与checkbox时)
E:enabled	|匹配用户界面上处于可用状态的元素E。(一般应用于表单元素)
E:disabled|	匹配用户界面上处于禁用状态的元素E。(一般应用于表单元素)
E:empty|	匹配没有任何子元素（包括text节点）的元素E
E:root|	匹配E元素在文档的根元素。在HTML中，根元素永远是HTML
E:not(s)|	匹配不含有s选择符的元素E
E:first-child	|匹配父元素的第一个子元素E
E:last-child|	匹配父元素的最后一个子元素E
E:only-child|	匹配父元素仅有的一个子元素E
E:nth-child(n)|	匹配父元素的第n个子元素E
E:nth-last-child(n)|	匹配父元素的倒数第n个子元素E
E:first-of-type |	匹配同类型中的第一个同级兄弟元素E
E:last-of-type|	匹配同类型中的最后一个同级兄弟元素E
E:only-of-type|	匹配同类型中的唯一的一个同级兄弟元素E
E:nth-of-type(n)	| 匹配同类型中的第n个同级兄弟元素E
E:nth-last-of-type(n)|	匹配同类型中的倒数第n个同级兄弟元素E
:root | html 根元素
:not() | 否定选择器
:only-child | 只有一个子元素时才会生效
:empty | 代表没有子元素的元素。

### 伪对象选择器
选择器 | 描述
--|--|
E:before/E::before |	在目标元素E的前面插入的内容。用来和content属性一起使用
E:after/E::after|	在目标元素E的后面插入的内容。用来和content属性一起使用
E:first-letter/E::first-letter |	设置元素内的第一个字符的样式
E:first-line/E::first-line|	设置元素内的第一行的样式
E::placeholder |	设置元素文字占位符的样式。(一般用于input输入框)
E::selection|	设置元素被选择时的字体颜色和背景颜色

# 伪类和伪元素
伪类和伪元素的根本区别在于：它们是否创造了新的元素

## 扩展选择器

- 后代选择器，如 .polaris span img{}，后代选择器实际上是使用多个选择器加上中间的空格来找到具体的要控制标签。
- 群组选择器，如 div,span,img{}，群组选择器实际上是对 CSS 的一种简化写法，只不过把有相同定义的不同选择器放在一起，省了很多代码。

