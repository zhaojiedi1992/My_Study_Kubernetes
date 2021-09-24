DaemonSet
====================
守护集用于每个节点部署一个， 随节点个数变动而变动， 典型运用场景： 

- 集群存储后台
- 日志收集守护程序
- 节点监控程序

daemonset的容器重启策略默认值为always，默认的daemonset是会运行在所有的节点上面的。 
可以设置.spec.template.spec.nodeSelector来控制pod只运行特定的节点上面。 

如下设置

.. code-block:: yaml 

    nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchFields:
        - key: metadata.name
            operator: In
            values:
            - node1 
            - node2 
            - node4


