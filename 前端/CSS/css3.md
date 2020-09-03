# css3 新增属性



## 总结

- 背景，支持RGBA透明度，一次多背景图

- 支持媒体查询

- 支持阴影，渐变，阴影	

- 支持边框图片，border-image: url(border.png) 30 30 round

- 支持transform位移系列

- 支持过渡效果transition	

- 支持自定义字体

- 引入flex/grid布局

- 引入多种选择器


  

## 边框属性
### border-color 边框颜色

```
p

  {

  border-style:solid;  

  border-color:#ff0000 #0000ff;

  }
```
#### demo
http://jsrun.net/WtfKp/edit

### border-iamge 图片边框

```
div

{

-webkit-border-image:url(border.png) 30 30 round; /* Safari 5 */

-o-border-image:url(border.png) 30 30 round; /* Opera */

border-image:url(border.png) 30 30 round;

}

```
### border-radius 圆角边框
```
div
{
border:2px solid;
border-radius:25px;
}

```

### box-shadow 阴影效果
```
div{
box-shadow: 10px 10px 5px #888888;
}
```
## 背景属性
### background-size 指定背景图片尺寸
```
div
{
background-image:url("https://user-gold-cdn.xitu.io/2020/4/7/17153ee6979713f3?imageView2/0/w/1280/h/960/format/webp/ignore-error/1");
background-size:80px 60px;
background-repeat:no-repeat;
}
```
### background-origin：指定背景图片从哪里开始显示
```
div
{
background-image:url('smiley.gif');
background-repeat:no-repeat;
background-position:left;
background-origin:content-box;
}

```
### background-clip 指定背景图片从什么位置开始裁剪
```
div

{

background-color:yellow;

background-clip:content-box;

}
```
## 文字效果
### text-shadow 文件阴影
```
h1

{

text-shadow: 5px 5px 5px #FF0000;

}
```
### word-wrap 自动换行
单词太长的话就可能无法超出某个区域，允许对长单词进行拆分，并换行到下一行
```
p {word-wrap:break-word;}
```
## 动画效果
### transform 变换效果
transform 属性向元素应用 2D 或 3D 转换。该属性允许我们对元素进行旋转、缩放、移动或倾斜。
#### 详解
https://www.w3school.com.cn/cssref/pr_transform.asp

### annimation 动画效果

#### 详解
https://www.w3school.com.cn/css3/css3_animation.asp

### transition 过渡效果
### 详解
https://www.runoob.com/cssref/css3-pr-transition.html