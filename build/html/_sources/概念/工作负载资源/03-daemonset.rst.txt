daemonset
===========================

daemonset是确保全部或者部分节点上运行一个pod的副本，当有节点接入的时候，能自动添加一个pod上去，移除的时候，pod也会被回收。


使用场景
----------------------------

- 每个节点运行集群的守护进程
- 日志收集守护进程
- 运行监控守护进程

创建daemonset
----------------------------

.. literalinclude:: ../../../scripts/daemonset/demo-daemonset.yaml
   :language: yaml
   :linenos:

应用一下，通过如下命令查看

.. code-block:: bash 

   kubectl get pod -n kube-system |grep flu                                                                                          ✔  2701  17:07:17
   fluentd-elasticsearch-724f7                                 0/1     ContainerCreating   0               19s
   fluentd-elasticsearch-r8jth                                 0/1     ContainerCreating   0               19s

发现，我们3个节点的， 一个master,2个node的， 可以看到这个没有调度到pod上面的。 问题出在哪里了。看下

master节点是有污点的，不可调度的，也就是，需要修改配置文件，添加我们的ds容忍这个污点即可。

具体添加片段如下： 

.. code-block:: yaml 

    spec:
      tolerations:
      # this toleration is to have the daemonset runnable on master nodes
      # remove it if your masters can't run pods
      - key: node-role.kubernetes.io/master
        operator: Exists
        effect: NoSchedule

通过describe可以看到

.. code-block::  text 

   Tolerations:              
                             node.kubernetes.io/disk-pressure:NoSchedule op=Exists
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists
                             node.kubernetes.io/unreachable:NoExecute op=Exists
                             node.kubernetes.io/unschedulable:NoSchedule op=Exists

部分容忍我们都没有配置的，发现ds控制器自动帮忙给添加了。


daemon pod通信
----------------------------

- 推送，在ds pod里面直接把数据推送到一个数据库里面。
- node ip port: pod可以使用host port 每个节点监听特定端口即可被访问。
- dns: 创建一个无头服务，可以通过endpoint或者域名解析获取
- service: 这个没办法获取所有节点的， 每次请求被调度到一个节点，不确定是哪个节点的。


