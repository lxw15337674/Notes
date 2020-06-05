# FileReader
提供文件操作API。例如操作input元素选择文件的FileList对象。

## API
构造函数
```let reader = new FileReader()```

### 方法
方法名|	参数|	描述
--|--|--|
readAsBinaryString	|file|	将文件读取为二进制编码
readAsText	|file,[encoding]|	将文件读取为文本
readAsDataURL|	file|	将文件读取为DataURL
abort	|(none)|	终端读取操作

### 事件
事件|	调用时机
--|--|
onabort|	当读取操作被中止时调用|
onerror|	当读取操作发生错误时调用
onload|	当读取操作成功完成时调用
onloadend|	当读取操作完成时调用,不管是成功还是失败.该处理程序在onload或者onerror之后调用
onloadstart	|当读取操作将要开始之前调用
onprogress|	在读取数据过程中周期性调用


#### 参考
[使用FileReader进行文件读取](https://dumengjie.github.io/2017/07/13/%E4%BD%BF%E7%94%A8FileReader%E8%BF%9B%E8%A1%8C%E6%96%87%E4%BB%B6%E8%AF%BB%E5%8F%96/)
