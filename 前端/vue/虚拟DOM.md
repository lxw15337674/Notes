# 虚拟DOM
## 概念
操作真实DOM，会导致整个DOM树的重绘和重排，性能开销大。所以通过JS对象模拟DOM对象。


```
//真实DOM
<div>
    <p>123</p>
</div>
// 虚拟DOM
var Vnode = {
    tag: 'div',
    children: [
        { tag: 'p', text: '123' }
    ]
};
```

### 设计思想

1. 提供一种方便的工具，使得开发效率得到保证。
2. 保证最小化的DOM操作，使得执行效率得到保证

## 优势：

DOM 引擎、JS 引擎 相互独立，但又工作在同一线程（主线程） JS 代码调用 DOM API 必须 挂起 JS 引擎、转换传入参数数据、激活 DOM 引擎，DOM 重绘后再转换可能有的返回值，最后激活 JS 引擎并继续执行若有频繁的 DOM API 调用，且浏览器厂商不做“批量处理”优化， 引擎间切换的单位代价将迅速积累若其中有强制重绘的 DOM API 调用，重新计算布局、重新绘制图像会引起更大的性能消耗。

其次是 VDOM 和真实 DOM 的区别和优化：

1. 虚拟 DOM 不会立马进行排版与重绘操作
2. 虚拟 DOM 进行频繁修改，然后一次性比较并修改真实 DOM 中需要改的部分，最后在真实 DOM 中进行排版与重绘，减少过多DOM节点排版与重绘损耗
3. 虚拟 DOM 有效降低大面积真实 DOM 的重绘与排版，因为最终与真实 DOM 比较差异，可以只渲染局部




### 完整的Vnode

```
// body下的 <div id="v" class="classA"><div> 对应的 oldVnode 就是

{
  el:  div  //对真实的节点的引用，本例中就是document.querySelector('#id.classA')
  tagName: 'DIV',   //节点的标签
  sel: 'div#v.classA'  //节点的选择器
  data: null,       // 一个存储节点属性的对象，对应节点的el[prop]属性，例如onclick , style
  children: [], //存储子节点的数组，每个子节点也是vnode结构
  text: null,    //如果是文本节点，对应文本节点的textContent，否则为null
}

需要注意的是，el属性引用的是此 virtual dom对应的真实dom，patch的vnode参数的el最初是null，因为patch之前它还没有对应的真实dom。
```

## diff算法
diff算法是虚拟DOM技术的必然产物：通过新旧虚拟DOM作比较（即diff）,将变化的地方更新在真是DOM上。
vue为了降低watcher粒度，每个组件只有一个watcher与之对应，只有引入diff才能精确找到发生变化的地方。

DOM是多叉树的解构，如果需要完整对比两颗树的差异，那么时间复杂度是(n ^ 3)，
```
 O(n^3) => 将两个DOM树的所有节点两两对比，时间复杂度 O(n^2)

  prev                   last   

       A                        A
     /   \                    /   \
   D    B     =>       B    D
  /                                  \
C                                      C


  所有节点两两相互对比：
  pA => lA
  pA => lB
  pA => lD
  pA => lC
  ...
  pC => lC

再进行树的编辑(插入、替换、删除)需要遍历一次，因此时间复杂度为 O(n^3)
```


## vue优化后的算法
改为只比较同层的节点，而不是跨层对比，因为在实际业务中很少会去跨层的移动DOM元素。
整体策略改为：深度优先，同层比较。时间复杂度优化为O(n)
```
<div>
    <p>123</p>
</div>

<div>
    <span>456</span>
</div>
```
![image](https://user-gold-cdn.xitu.io/2018/5/19/163776ba7bda2d47?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

### diff流程图
当数据发生改变时，set方法会让调用Dep.notify通知所有订阅者Watcher，订阅者就会调用patch给真实DOM打补丁，更新响应的视图。

流程总结：
1. 先判断新旧节点是否指得比较，根据标签选择器和key值进行比较，如果不值得比较，直接替换（为新node创建真实dom，然后删除旧节点），如果值得比较则继续。
2. 比较新node与旧node。分5种情况：
    - 如果相同，则认为没有变化。
    - 如果节点的文本不同，则只修改旧节点的文本。
    - 如果两个节点都有子节点，而且不一样，则进行子节点比较
    - 如果新节点有子节点，老节点没有，则直接在老节点添加子节点
    - 如果新节点没有子节点，老节点有，则直接删除老节点。
3. 进行子节点比较
    利用双指针，对新老的子节点进行比较。一共4中比较方式，如果4种比较都没匹配，如果设置了key，则会用key进行比较，在比较的过程汇总，变量会往中间靠，一旦遍历完成即会结束比较。
    

![image](https://github.com/aooy/blog/blob/master/images/issues-2/diff2.png?raw=true)



![image](https://user-gold-cdn.xitu.io/2018/5/19/163777930be304eb?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)



## 具体的两组子节点diff分析
即父节点相同，子节点的比较，
利用双指针，对新旧DOM比较，尽可能复用。
策略：
首先对新旧dom的头尾节点进行4次比对，如果没有找到相同节点才遍历查找，查找结束再按情况处理剩下的节点；
设置key和不设置key的区别：
不设key，newCh和oldCh只会进行头尾两端的相互比较，设key后，除了头尾两端的比较外，还会从用key生成的对象中查找匹配的节点，时间复杂度为O(n)，所以为节点设置key可以更高效的利用DOM。

遍历分为3种dom操作：
1. 当`oldStartVnode` `newEndVnode`值得比较，说明`oldStartVnode.el`跑到`oldEndVnode.el`的后面。

    ![image](https://github.com/aooy/blog/blob/master/images/issues-2/diff3.png?raw=true)

2. 当`oldEndVnode`，`newStartVnode`指得比较，说明`oldEndVnode.el`跑到`oldEndVnode.el`的前面

    ![image](https://github.com/aooy/blog/blob/master/images/issues-2/diff4.png?raw=true)

3. 当newCh中的节点oldCh里没有， 将新节点插入到`oldStartVnode.el`的前边。
   
    ![image](https://github.com/aooy/blog/blob/master/images/issues-2/diff5.png?raw=true)

结束时，分两种情况
1. `oldStartIdx > oldEndIdx`，可以认为`oldCh`先遍历完。当然也有可能`newCh`此时也正好完成了遍历，统一都归为此类。此时`newStartIdx`和`newEndIdx`之间的vnode是新增的，把他们全部插进`before`的后边。
    ![image](https://github.com/aooy/blog/blob/master/images/issues-2/diff6.png?raw=true)

2. `newStartIdx` > `newEndIdx`,可以认为`newCh`先遍历完。此时`oldStartIdx`和`oldEndIdx`之间的vnode在新的子节点里已经不存在了，将它们从dom里删除。
    ![image](https://github.com/aooy/blog/blob/master/images/issues-2/diff7.png?raw=true)


## 详解
[图解updateChildren](https://juejin.im/post/5affd01551882542c83301da#heading-9)

[解析vue2.0的diff算法
](https://github.com/aooy/blog/issues/2)
[Virtual Dom 算法简述](http://caibaojian.com/interview-map/frontend/framework.html#virtual-dom-%E7%AE%97%E6%B3%95%E7%AE%80%E8%BF%B0)
[揭秘Vue中的Virtual Dom](https://github.com/ljianshu/Blog/issues/69)
[全面理解虚拟DOM，实现虚拟DOM](http://foio.github.io/virtual-dom/)