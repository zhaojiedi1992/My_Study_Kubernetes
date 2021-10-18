将pod分配给节点
==========================================

nodeselector
---------------------------
nodeselector是节点选择约束最简单的方式，

可以给node打标签，然后通过pod如下配置即可。

.. code-block:: yaml

    nodeSelector:
      disktype: ssd


亲和性和反亲和性
------------------------------------------------------
这个相对nodeselector更像是软限制，nodeselector像是强制限制。

主要是2个关键词

- requiredDuringSchedulingIgnoredDuringExecution
- preferredDuringSchedulingIgnoredDuringExecution


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


反亲和性配置
------------------------------------------------------
podAntiAffinity


nodeName
------------------------------------------------------
nodeName 是节点选择约束的最简单方法，但是由于其自身限制，通常不使用它。 






























































d之一。











