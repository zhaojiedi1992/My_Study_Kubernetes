pod拓扑分布约束
===========================
拓扑分布约束来控制pod在集群内故障域之间的分布。例如区域（region),可用区（zone)这样有利于实现高可用并提升资源使用率。


先决条件 
----------------------------
可以给节点所在的区域进行拓扑标记。

.. code-block:: bash

    # 给其中一个节点进行标记，标记为region区域， zone 可用区
    kubectl label  node zkdemo-1.epc.duxiaoman.com region=beijing zone=a
    # 确认下
    kubectl get node --show-labels=true

这里我没有那么多机器，应该根据实际部署的位置进行标记， 这里我们假定我有2个区域，每个区域都有2个可用区。 一共4个work节点。


拓扑标记建议使用如下标签名字： topology.kubernetes.io/region和 topology.kubernetes.io/zone.
这个如果有cloud-coller-manager的时候应该会自动设置的。



pod分布约束
----------------------------

.. literalinclude:: ../../../scripts/pod拓扑/one-constraint.yaml
   :encoding: utf-8
   :language: yaml
   :linenos:

先说明下几个字段

- topologySpreadConstraints: 指定拓扑约束的， 可以有多个约束规则的。
- maxSkew: 描述分布不均匀程度，是2个拓扑域差值
- topologyKey: 拓扑标签的key,这里我们使用了zone
- whenUnsatisfiable: 如果pod不满足分布约束的时候如何处理， donotschedule是不要调度，scheduleanyway是继续调度，进行偏差最小化。
- labelSelector: 用于查找匹配的po,根据这个来统计各个拓扑域的pod数量。


设置集群级别的默认约束
----------------------------

.. code-block:: yaml

    apiVersion: kubescheduler.config.k8s.io/v1beta1
    kind: KubeSchedulerConfiguration

    profiles:
    - pluginConfig:
        - name: PodTopologySpread
            args:
            defaultConstraints:
                - maxSkew: 1
                topologyKey: topology.kubernetes.io/zone
                whenUnsatisfiable: ScheduleAnyway
            defaultingType: List

