Kubernetes组件
==========================

主要组件
--------------------------


kube-apiserver
    提供集群管理的api入口
etcd
    一致且高度可用的kv存储，为k8s集群数据提供后端存储
kube-scheduler
    集群的调度管理
kube-controller-manager
    控制器管理器管理多个控制器， 每个控制器管理对应的资源
cloud-controller-manager
    云厂商提供的控制器管理器， 有多个控制器， 管理k8s和对应云资源的管理分配


节点组件
------------------------------

kubelet
    每个集群节点都要运行的服务，确保容器在pod中运行
kube-proxy
    维护主机网络规划和转发来实现服务的抽象，维护节点上的网络规则，运行从集群内部或者外部的网络会话
    与pod进行网络通信。
Container Runtime
    负责容器运行的容器软件，如docker,rtk等实现了kubernetes cri运行时接口的。

插件
--------------------------------

DNS
    集群dns服务
Web UI 
    web管理的面板
Container Resource Monitoring
    容器资源的监控
Cluster-level Logging
    提供一个统一的方式查看和分析日志