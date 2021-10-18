pod开销
==========================================
在节点上运行pod时，pod本身占用大量系统资源，这些资源运行pod内容器所需要的资源附加资源，pod开销是一个特性，用于计算pod基础设施在容器请求和限制只上消耗的资源。



定义开销
---------------------------

.. code-block:: yaml

  ---
  kind: RuntimeClass
  apiVersion: node.k8s.io/v1
  metadata:
      name: kata-fc
  handler: kata-fc
  overhead:
      podFixed:
          memory: "120Mi"
          cpu: "250m"
  