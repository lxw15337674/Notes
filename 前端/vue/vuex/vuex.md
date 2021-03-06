## 一、前言

当我们的应用遇到多个组件共享状态时，会需要多个组件依赖于同一状态抑或是来自不同视图的行为需要变更同一状态。以前的解决办法：

**a.将数据以及操作数据的行为都定义在父组件;**

**b.将数据以及操作数据的行为传递给需要的各个子组件(有可能需要多级传递)**

传参的方法对于多层嵌套的组件将会非常繁琐，并且对于兄弟组件间的状态传递无能为力。在搭建下面页面时，你可能会对 vue 组件之间的通信感到崩溃 ，特别是非父子组件之间通信。此时就应该使用vuex，轻松可以搞定组件间通信问题。

[![组件间通信](https://camo.githubusercontent.com/c7c3a9a7ec7ea669ec3de23b17dca4690905ab39/68747470733a2f2f757365722d676f6c642d63646e2e786974752e696f2f323031382f352f32332f313633386233386130383038386231323f773d3131393426683d34383626663d706e6726733d313333323535)](https://camo.githubusercontent.com/c7c3a9a7ec7ea669ec3de23b17dca4690905ab39/68747470733a2f2f757365722d676f6c642d63646e2e786974752e696f2f323031382f352f32332f313633386233386130383038386231323f773d3131393426683d34383626663d706e6726733d313333323535)

## 二、什么是Vuex

Vuex 是一个专为 Vue.js 应用程序开发的状态管理模式。它采用集中式存储管理应用的所有组件的状态，并以相应的规则保证状态以一种可预测的方式发生变化。这里的关键在于集中式存储管理。**简单来说,对 vue 应用中多个组件的共享状态进行集中式的管理(读/写)**。

## 三、Vuex的原理是什么

#### 1.简要介绍Vuex原理

[![img](https://camo.githubusercontent.com/b3225626827d2dc96d84e76ed470d367adc20a7e/68747470733a2f2f757365722d676f6c642d63646e2e786974752e696f2f323031382f382f32352f313635366632623932373765636531393f773d37363126683d34363426663d706e6726733d313234373838)](https://camo.githubusercontent.com/b3225626827d2dc96d84e76ed470d367adc20a7e/68747470733a2f2f757365722d676f6c642d63646e2e786974752e696f2f323031382f382f32352f313635366632623932373765636531393f773d37363126683d34363426663d706e6726733d313234373838)

Vuex实现了一个单向数据流，在全局拥有一个State存放数据，当组件要更改State中的数据时，必须通过Mutation进行，Mutation同时提供了订阅者模式供外部插件调用获取State数据的更新。而当所有异步操作(常见于调用后端接口异步获取更新数据)或批量的同步操作需要走Action，但Action也是无法直接修改State的，还是需要通过Mutation来修改State的数据。最后，根据State的变化，渲染到视图上。

#### 2.简要介绍各模块在流程中的主要功能：

- Vue Components：Vue组件。HTML页面上，负责接收用户操作等交互行为，执行dispatch方法触发对应action进行回应。
- dispatch：操作行为触发方法，是唯一能执行action的方法。
- actions：**操作行为处理模块,由组件中的`$store.dispatch('action 名称', data1)`来触发。然后由commit()来触发mutation的调用 , 间接更新 state**。负责处理Vue Components接收到的所有交互行为。包含同步/异步操作，支持多个同名方法，按照注册的顺序依次触发。向后台API请求的操作就在这个模块中进行，包括触发其他action以及提交mutation的操作。该模块提供了Promise的封装，以支持action的链式触发。
- commit：状态改变提交操作方法。对mutation进行提交，是唯一能执行mutation的方法。
- mutations：**状态改变操作方法，由actions中的`commit('mutation 名称')`来触发**。是Vuex修改state的唯一推荐方法。该方法只能进行同步操作，且方法名只能全局唯一。操作之中会有一些hook暴露出来，以进行state的监控等。
- state：页面状态管理容器对象。集中存储Vue components中data对象的零散数据，全局唯一，以进行统一的状态管理。页面显示所需的数据从该对象中进行读取，利用Vue的细粒度数据响应机制来进行高效的状态更新。
- getters：state对象读取方法。图中没有单独列出该模块，应该被包含在了render中，Vue Components通过该方法读取全局state对象。

> Vue组件接收交互行为，调用dispatch方法触发action相关处理，若页面状态需要改变，则调用commit方法提交mutation修改state，通过getters获取到state新值，重新渲染Vue Components，界面随之更新。



## actions和mutations区别

actions和上面的Mutations功能基本一样，不同点是，**actions是异步的改变state状态，而Mutations是同步改变状态**。

---尤雨溪：
- mutations里的同步意义在于，每个mutation执行完毕之后，可以得到对应的状态，使用devtools可以跟踪状态的变化

- 如果是异步的，就没法知道状态是什么时候更新的，才有了actions。

- actions用来专门处理异步，里面触发mutations，就可以很清楚的看到mutation是何时被记录下来的，并且立即查看他们对应的状态。这样异步更新也可以清楚看到状态的流程。

- actions只是一个架构，并不是必须的，它只是一个函数，在里面想干嘛干嘛，只要最后触发mutation就行。

## 引用

https://github.com/ljianshu/Blog/issues/36