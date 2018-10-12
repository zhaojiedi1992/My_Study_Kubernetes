pod分配给节点
=================================

使用nodeselector来给pod设置节点的选择条件。 


步骤： 

1. 给节点打标签：  kubectl label nodes <node-name> <label-key>=<label-value>
2. 给pod设置nodeselector: .spec.nodeSelector

内置节点标签
----------------------------------------

- kubernetes.io/hostname    主机名
- failure-domain.beta.kubernetes.io/zone  可用区
- failure-domain.beta.kubernetes.io/region 区域
- beta.kubernetes.io/instance-type      实例类型
- beta.kubernetes.io/os                 操作系统类型
- beta.kubernetes.io/arch               架构



节点亲和力和反亲和力
---------------------------------------------

- requiredDuringSchedulingIgnoredDuringExecution： 硬要求
- preferDuringSchedulingIgnoredDuringExecution: 软要求

其中ignoredDuringExecution表示， 如果调度到节点上，即使节点的标签修改了。 是被忽略的。 也就是原有的pod不会变动， 
还在原来的节点上面运行。 

样例： 

.. code-block:: yaml 

    apiVersion: v1
    kind: Pod
    metadata:
    name: with-node-affinity
    spec:
    affinity:
      nodeAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
            - key: kubernetes.io/e2e-az-name
                operator: In
                values:
                - e2e-az1
                - e2e-az2
        preferredDuringSchedulingIgnoredDuringExecution:
        - weight: 1
            preference:
            matchExpressions:
            - key: another-node-label-key
                operator: In
                values:
                - another-node-label-value
    containers:
    - name: with-node-affinity
        image: k8s.gcr.io/pause:2.0

上面的表示此pod只能运行在e2e-az1和2上， 但是满足第二个条件的是优先的。 

.. note:: 亲和度只在调度的时候生效。 

pod亲和： podAffinity
pod反亲和： podAntiAffinity



