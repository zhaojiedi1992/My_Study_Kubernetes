init容器
===========================
Init 容器是一种特殊容器，在 Pod 内的应用容器启动之前运行。Init 容器可以包括一些应用镜像中不存在的实用工具和安装脚本。

和普通容器区别
----------------------------
init容器支持应用容器的全部字段和特性，包括资源限制、数据卷和安全设置，

init不支持lifecycle livenessprobe,readinessprobe和startupProbe.

init的容器是顺序执行的，上一个成功了，当前这个才可以执行，所有的都运行完成了， pod才开始正常的pod工作。



init容器使用场景
----------------------------

- 使用一些工具生成一个新的镜像
- 镜像构建和部署镜像分离
- 权限分离， init容器可以读写，pod容器只能读取。
- 延迟启动，确保容器启动前置成功。


注意点
----------------------------

如果pod重启，所有init容器必须重新执行的,对init容器的image修改，会触发容器重启的，
请注意保持init容器代码幂等性。
