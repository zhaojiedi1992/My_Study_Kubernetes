statefulset
===========================

statefulset是用来管理有状态应用的工作负载api对象
和deployment不同的是，这些pod都有每个独立的粘性id,永久不变的id.


使用场景
----------------------------

- 稳定的唯一标识的
- 稳定的、持久的存储
- 有序的，优雅的部署和缩放
- 有序的，自动的滚动更新。

创建statefulset
----------------------------

需要一个svc

.. literalinclude:: ../../../scripts/statefulset/demo_svc.yml
   :language: yaml
   :linenos:

需要存储类

.. literalinclude:: ../../../scripts/statefulset/demo_storageclass.yml
   :language: yaml
   :linenos:

创建sts 

.. literalinclude:: ../../../scripts/statefulset/demo_stateful.yml
   :language: yaml
   :linenos:


创建出来的pod名称是$(StatefulSet 名称)-$(序号)，管理域的这个服务格式为: $(服务名称).$(命名空间).svc.cluster.local，其中 cluster.local 是集群域。 

pod对应的dns域为$(pod 名称).$(所属服务的 DNS 域名)



部署和缩容保障
--------------------------------------------------------

- 对于n个副本的sts，当部署pod的时候，依次创建的，顺序为0..N-1
- 删除pod的时候,它们是逆序终止的，顺序为 N-1..0。
- 在将缩放操作应用到 Pod 之前，它前面的所有 Pod 必须是 Running 和 Ready 状态。


主要属性说明
--------------------------------------------------------

- podManagementPolicy: OrderedReady 一个一个来，Parallel 并行的。