StatefulSets
================================
用于管理有状态应用程序的工作负载api对象，提供了pod排序和唯一性保证。 

statefulset为每个pod维护一个粘性标识，（statefulset.kubernetes.io/pod-name=$(statefulset name)-$(ordinal)，保证在任何重新安排的时候可以保留。

优点 
---------------------------

- 稳定，独特的网络标识符
- 稳定，持久的存储
- 有序，优雅的部署和扩展
- 有序的自动滚动更新

限制
--------------------------

- version>1.9
- pv需要预先分配和设置
- 需要无头服务负责pod的调度（clusterIP=None)(域名为$(service name).$(namespace).svc.cluster.local）
- 删除statefulset时候，不会对pod的种植提供任何保证。


