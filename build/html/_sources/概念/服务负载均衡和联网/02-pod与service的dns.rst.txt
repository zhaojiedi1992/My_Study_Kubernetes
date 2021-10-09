pod与service的dns
==========================================
k8s为服务和pod创建dns记录， 可以使用dns名称而非地址访问服务。


Service 的名字空间
---------------------------
看一个service的配置文件  /etc/resolv.conf

.. code-block:: bash 

    # kubectl get svc |grep nginx
    nginxsvc                                                 ClusterIP   None             <none>        80/TCP     9d
    # kubectl exec svc/nginxsvc -- cat /etc/resolv.conf
    nameserver 10.96.0.10
    search default.svc.cluster.local svc.cluster.local cluster.local epc.duxiaoman.com
    options ndots:5

DNS记录
---------------------------
哪些对象可以获得dns记录？

* Services
* Pods

服务A记录
---------------------------

普通服务（除了无头服务）回馈有一个dns记录，my-svc.my-namespace.svc.cluster-domain.example的这种形式的。 

服务SRV记录
---------------------------
_my-port-name._my-port-protocol.my-svc.my-namespace.svc.cluster-domain.example 这种形式。

Pod A记录
---------------------------

pod-ip-address.my-namespace.pod.cluster-domain.example


Pod 的 DNS 策略
---------------------------

- Default: pod从运行的节点集成名称解析配置
- ClusterFirst: 与配置的集群与后缀不匹配的dns查询都转发到从节点集成的上游名称服务器
- ClusterFirstWithHostNet： 对于以 hostNetwork 方式运行的 Pod，应显式设置其 DNS 策略
- None： 设置忽略k8s环境变量的dns设置，pod会使用dnsconfig字段锁提供的dns设置。

.. note::  "Default" 不是默认的 DNS 策略。如果未明确指定 dnsPolicy，则使用 "ClusterFirst"。

Pod 的 DNS 配置 
---------------------------
dnsConfig 字段是可选的，它可以与任何 dnsPolicy 设置一起使用。 但是，当 Pod 的 dnsPolicy 设置为 "None" 时，必须指定 dnsConfig 字段。

- nameservers：将用作于 Pod 的 DNS 服务器的 IP 地址列表。 最多可以指定 3 个 IP 地址。当 Pod 的 dnsPolicy 设置为 "None" 时， 列表必须至少包含一个 IP 地址，否则此属性是可选的。 所列出的服务器将合并到从指定的 DNS 策略生成的基本名称服务器，并删除重复的地址。
- searches：用于在 Pod 中查找主机名的 DNS 搜索域的列表。此属性是可选的。 指定此属性时，所提供的列表将合并到根据所选 DNS 策略生成的基本搜索域名中。 重复的域名将被删除。Kubernetes 最多允许 6 个搜索域。
- options：可选的对象列表，其中每个对象可能具有 name 属性（必需）和 value 属性（可选）。 此属性中的内容将合并到从指定的 DNS 策略生成的选项。 重复的条目将被删除。


