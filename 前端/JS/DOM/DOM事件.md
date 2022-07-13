# DOM 事件
DOM级别一共可以分为四个级别：DOM0级、DOM1级、DOM2级和DOM3级。而**DOM事件分为3个级别：DOM 0级事件处理，DOM 2级事件处理和DOM 3级事件处理**。由于DOM 1级中没有事件的相关内容，所以没有DOM 1级事件。

## 事件级别

### DOM 0级
写法： `el.onclick=function(){}`
> 当希望为同一个元素/标签绑定多个同类型事件的时候（如给上面的这个btn元素绑定3个点击事件），是不被允许的。DOM0事件绑定，给元素的事件行为绑定方法，这些方法都是在当前元素事件行为的冒泡阶段(或者目标阶段)执行的。
>
### DOM 1级
没有事件的相关内容

### DOM 2级
el.addEventListener(event-name, callback, useCapture)
> event-name:事件名称，可以是标准的dom事件
> callback：回调函数，当事件触发式，函数会被注入一个参数为当前的事件对象event
> useCapture：默认是false，代表事件句柄是否在捕获阶段执行

### DOM 3级
DOM 3级写法和DOM2级一致 只是在DOM 2级事件的基础上添加了更多的事件类型

> UI事件，当用户与页面上的元素交互时触发，如：load、scroll
>焦点事件，当元素获得或失去焦点时触发，如：blur、focus
>鼠标事件，当用户通过鼠标在页面执行操作时触发如：dblclick、mouseup
>滚轮事件，当使用鼠标滚轮或类似设备时触发，如：mousewheel
>文本事件，当在文档中输入文本时触发，如：textInput
>键盘事件，当用户通过键盘在页面上执行操作时触发，如：keydown、keypress
>合成事件，当为IME（输入法编辑器）输入字符时触发，如：compositionstart
>变动事件，当底层DOM结构发生变化时触发，如：DOMsubtreeModified
>同时DOM3级事件也允许使用者自定义一些事件。

## DOM事件模型 
事件模型分为：捕获和冒泡

### 事件冒泡与事件捕获

![image](https://pic1.zhimg.com/80/v2-bf3b8dbab027713a2b21b9e8a5b7a6c4_720w.jpg)

### 事件委托（代理）

利用冒泡的原理，将元素的事件委托给它的父级或者更外级的元素处理。

### 优点

1. 同类元素的事件委托给上级元素，不需要给每个元素都绑定事件，减少内存占用，提升性能
2. 动态新增元素无需重新绑定事件。

### 缺点
1. 利用事件冒泡的原理，不支持不冒泡的事件； 
2. 层级过多，冒泡过程中，可能会被某层阻止掉；
3. 把所有事件都用代理就可能会出现事件误判。比如，在document中代理了所有button的click事件，另外的人在引用改js时，可能不知道，造成单击button触发了两个click事件。
   
### 注意点

1. 事件委托的实现依靠的冒泡，因此不支持事件冒泡的事件就不适合使用事件委托。



## Event对象使用
1. 阻止默认行为：`event.preventDefault()`
2. 组织冒泡
- event.stopPropagation() 阻止事件冒泡到父元素
- event.stopImmediatePropagation()  既能阻止事件向父元素冒泡，也能阻止元素同事件类型的其它监听器被触发
3. event.target & event.currentTarget
>event.currentTarget始终是监听事件者，而event.target是事件的真正发出者