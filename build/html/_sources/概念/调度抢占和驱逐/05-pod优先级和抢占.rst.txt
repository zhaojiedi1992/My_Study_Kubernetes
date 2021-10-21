优先级和抢占
==========================================
pod可以有优先级，优先级表示已一个pod相对其他的pod的重要性，如果一个pod无法调度，调度程序会尝试抢占优先级毕竟低的pod。

.. warning:: 可以通过创建resourcequota来限制用户创建高优先级的pod。 避免驱逐别的pod.

如何使用优先级
--------------------------

* 先创建一个优先级类
* 然后在使用pod的deployment或者其他类资源的template指定对应priorityClassName为新建的优先级类

k8s内置了2个优先级类，system-cluster-critical 和system-node-critical 



PriorityClass
----------------------------------------------------

PriorityClass 还有两个可选字段：globalDefault 和 description。 
globalDefault 字段表示这个 PriorityClass 的值应该用于没有 priorityClassName 的 Pod。 系统中只能存在一个 globalDefault 设置为 true 的


样例
----------------------------------------------------

.. code-block:: yaml 

    apiVersion: scheduling.k8s.io/v1
    kind: PriorityClass
    metadata:
      name: high-priority
    value: 1000000
    globalDefault: false
    description: "此优先级类应仅用于 XYZ 服务 Pod。"


抢占策略
-------------------------------------------
PreemptionPolicy默认是PreeemptLowerPriority的， 可以抢占低优先级的pod的， 如果这个值为never那就不会抢占的。 

Pod 优先级对调度顺序的影响
-------------------------------------------
当启用 Pod 优先级时，调度程序会按优先级对悬决 Pod 进行排序， 并且每个悬决的 Pod 会被放置在调度队列中其他优先级较低的悬决 Pod 之前。 
因此，如果满足调度要求，较高优先级的 Pod 可能会比具有较低优先级的 Pod 更早调度。 如果无法调度此类 Pod，调度程序将继续并尝试调度其他较低优先级的 Pod。



被提名节点
-------------------------------------------
当 Pod P 抢占节点 N 上的一个或多个 Pod 时， Pod P 状态的 nominatedNodeName 字段被设置为节点 N 的名称。 该字段帮助调度程序跟踪为 Pod P 保留的资源，并为用户提供有关其集群中抢占的信息。
请注意，Pod P 不一定会调度到“被提名的节点（Nominated Node。

抢占的限制
-------------------------------------------

被抢占的牺牲者体面终止， 如果想让低优先级快速终止，可以设置终止时间为很小的一个数值。

支持pdb pod disruptionbudget,但不保证。允许多副本应用程序的所有者限制因自愿性质的干扰而同时终止的 Pod 数量。

是仅针对同等或更高优先级的 Pod 设置 Pod 间亲和性。

