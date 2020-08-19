# 切换npm源
方法：
1. npm config set registry http://registry.npm.taobao.org
2. 安装nrm管理
    ```
    npm install -g nrm  nrm 安装
    nrm ls  列出可用的源
    nrm use taobao 选择国内淘宝的源
    nrm test npm 测试速度
    nrm add taobao http://192.168.10.127:8081/repository/npm-public/  添加源
    nrm del  taobao删除对应的源

    ```