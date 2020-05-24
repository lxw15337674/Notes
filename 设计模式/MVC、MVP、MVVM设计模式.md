# MVC（Model-View-Controller）
![image](https://user-gold-cdn.xitu.io/2019/5/13/16aae4f327f8e68c?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

### 结构：
- View（模型）：检测用户的键盘、鼠标等行为，传递调用Controller执行应用逻辑。View更新需要重新获取Model的数据。
- Controller（视图）：ew和Model之间协作的应用逻辑或业务逻辑处理。
- Model（控制器）：Model变更后，通过观察者模式通知View更新视图。

### 优点：

- 职责分离：模块化程度高、Controller可替换、可复用性、可扩展性强。
- 多视图更新：使用观察者模式可以做到单Model通知多视图实现数据更新。

### 缺点：

- 测试困难：View需要UI环境，因此依赖View的Controller测试相对比较困难（现在Web前端的很多测试框架都已经解决了该问题）。
- 依赖强烈：View强依赖Model(特定业务场景)，因此View无法组件化设计。

# MVP(model-view-presenter)

![image](https://user-gold-cdn.xitu.io/2019/5/13/16aae4f32c5e6933?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

### 结构:
- Passive View：View不再处理同步逻辑，对Presenter提供接口调用。由于不再依赖Model，可以让View从特定的业务场景中抽离，完全可以做到组件化。
- Presenter（Supervising Controller）：和经典MVC的Controller相比，任务更加繁重，不仅要处理应用业务逻辑，还要处理同步逻辑(高层次复杂的UI操作)。
- Model：Model变更后，通过观察者模式通知Presenter，如果有视图更新，Presenter又可能调用View的接口更新视图。

### 优点

- Presenter便于测试、View可组件化设计

### 缺点

- Presenter厚、维护困难

# MVVM（Model-View-ViewModel)
![image](https://user-gold-cdn.xitu.io/2019/5/13/16aae4f32c4c587a?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

### 结构
- ViewModel：内部集成了Binder(Data-binding Engine，数据绑定引擎)，在MVP中派发器View或Model的更新都需要通过Presenter手动设置，而Binder则会实现View和Model的双向绑定，从而实现View或Model的自动更新。
- View：可组件化，例如目前各种流行的UI组件框架，View的变化会通过Binder自动更新相应的Model。
- Model：Model的变化会被Binder监听(仍然是通过观察者模式)，一旦监听到变化，Binder就会自动实现视图的更新。

### 优点
- 提升了可维护性，解决了MVP大量的手动同步的问题，提供双向绑定机制。
- 简化了测试，同步逻辑是交由Binder处理，View跟着Model同时变更，所以只需要保证Model的正确性，View就正确。

### 缺点
- 产生性能问题，对于简单的应用会造成额外的性能消耗。
- 对于复杂的应用，视图状态较多，视图状态的维护成本增加，ViewModel构建和维护成本高。

## 面试题
### MVVM模式的优点以及与MVC模式的区别
MVVM模式的优点:
- 低耦合:View可以独立于Model变化和修改,一个ViewModel可以绑定到不同的View上,当View变化的时候Model可以不变,当Model变化的时候View也可以不变。
- 可重用性: 可以把一些视图逻辑放在一个ViewModel里面,让很多View重用这段视图逻辑。
- 独立开发: 开发人员可以专注于业务逻辑和数据的开发,设计人员可以专注于页面的设计。

MVVM和MVC的区别:
- MVC中Controller演变成MVVM中的ViewModel
- MVVM通过数据来显示视图层而不是节点操作
- MVVM主要解决了MVC中大量的dom操作使页面渲染性能降低,加载速度变慢,影响用户体验

![image](https://user-gold-cdn.xitu.io/2019/6/9/16b3b5946e265f2d?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)