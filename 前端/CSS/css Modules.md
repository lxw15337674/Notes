# css modules（模块化）

1. 全局污染

   CSS 使用全局选择器机制来设置样式，优点是方便重写样式。缺点是所有的样式都是全局生效，样式可能被错误覆盖，因此产生了非常丑陋的 !important，甚至 inline !important 和复杂的选择器权重计数表，提高犯错概率和使用成本。Web Components 标准中的 Shadow DOM 能彻底解决这个问题，但它的做法有点极端，样式彻底局部化，造成外部无法重写样式，损失了灵活性。

2. 命名混乱

   由于全局污染的问题，多人协同开发时为了避免样式冲突，选择器越来越复杂，容易形成不同的命名风格，很难统一。样式变多后，命名将更加混乱。

3. 依赖管理不彻底

   组件应该相互独立，引入一个组件时，应该只引入它所需要的 CSS 样式。但现在的做法是除了要引入 JS，还要再引入它的 CSS，而且 Saas/Less 很难实现对每个组件都编译出单独的 CSS，引入所有模块的 CSS 又造成浪费。JS 的模块化已经非常成熟，如果能让 JS 来管理 CSS 依赖是很好的解决办法。Webpack 的 `css-loader` 提供了这种能力。

4. 无法共享变量

   复杂组件要使用 JS 和 CSS 来共同处理样式，就会造成有些变量在 JS 和 CSS 中冗余，Sass/PostCSS/CSS 等都不提供跨 JS 和 CSS 共享变量这种能力。

5. 代码冗余

   

通过js来管理css来解决上述问题。css模块化解决方案分为两种：

1. 彻底抛弃css，使用js或json来写样式。

   优点：能给 CSS 提供 JS 同样强大的模块化能力；

   缺点：不能利用成熟的 CSS 预处理器（或后处理器） Sass/Less/PostCSS， :hover 和 :active 伪类处理起来复杂。

2. 依旧使用 CSS，但使用 JS 来管理样式依赖。代表是CSS Modules。发布时依旧编译出单独的 JS 和 CSS。它并不依赖于 React，只要你使用 Webpack，可以在 Vue/Angular/jQuery 中使用。

css modules

默认情况下，所有类名和动画名都在本地作用域内的CSS文件。

主要功能：加入局部作用域和模块依赖。

1. 局部作用域：

   css规则都是全局的，任何一个组件的样式规则，都对整个页面有效。

   产生局部作用域的方式是给每个选择器生成独一无二的`class`名字[利用hash:base64算法]，不会与其他选择器重名。

2. 模块依赖

   可以使用`composes`引用自身模块中的样式以及另一个模块的样式

解决方式：

1. 全局命名冲突，因为CSS Modules只关心组件本身，只要保证组件本身命名不冲突，就不会有这样的问题，一个组件被编译之后的类名可能是这样的：

   ```css
   /* App.css */
   .text {
       color: red;
   }
   
   /* 编译之后可能是这样的 */
   .App__text___3lRY_ {
       color: red;
   }
   ```

2. 模块化

   可以使用`composes`引用自身模块中的样式以及另一个模块的样式：

   ```
   .serif-font {
     font-family: Georgia, serif;
   }
   
   .display {
     composes: serif-font;
     font-size: 30px;
     line-height: 35px;
   }
   ```

   应用到元素上可以这样使用：

   ```
   import type from "./type.css";
   
   element.innerHTML = 
     `<h1 class="${type.display}">
       This is a heading
     </h1>`;
   ```

   之后编译出来的模板可能是这样的：

    ```
    <h1 class="Type__display__0980340 Type__serif__404840">
      Heading title
    </h1>
    复制代码
    ```
   
   ​	从另一个模块中引入，可以这样写：	
   
   ```
   .element {
     composes: dark-red from "./colors.css";
     font-size: 30px;
     line-height: 1.2;
   }
   ```

3. 解决嵌套层次过深的问题

   因为CSS Modules只关注与组件本身，组件本身基本都可以使用扁平的类名来写，类似于这样的:
   
   ```
.root {
     composes: box from "shared/styles/layout.css";
     border-style: dotted;
     border-color: green;
   }
   
   .text {
     composes: heading from "shared/styles/typography.css";
     font-weight: 200;
     color: green;
   }
   ```
   
   



参考：http://www.ruanyifeng.com/blog/2016/06/css_modules.html

https://github.com/camsong/blog/issues/5