ingress
==========================================

ingress是对集群汇总服务的外部访问进行管理的api对象，典型的访问是http

ingress可以提供负载均衡、ssl终结和基于名称的虚拟托管。

ingress是什么
---------------------------
ingress是公开了从集群外部到集群内部服务的http和https路由。

先安装一个ingress控制器，这里我选择了trafik了。 安装方法参考： https://doc.traefik.io/traefik/getting-started/install-traefik/

.. code-block:: yaml

    kind: Ingress
    apiVersion: networking.k8s.io/v1
    metadata:
      name: "foo"
      namespace: production

    spec:
      rules:
        - host: example.net
          http:
            paths:
              - path: /bar
                pathType: Exact
                backend:
                  service:
                    name:  service1
                    port:
                      number: 80
              - path: /foo
                pathType: Exact
                backend:
                  service:
                    name:  service1
                    port:
                      number: 80


defaultBackend
---------------------------
没有rules的ingress将所有流量发送到同一个默认后端，这个通常是ingress控制器的配置选项，而非在ingress的资源中指定。

路径类型
---------------------------

pathtype这个就是路径类型，目前支持三种。

- ImplementationSpecific: 这种类型的具体使用看ingress class了。 
- Exact: 精确匹配URL路径，区分大小写。
- Prefix: 基于/分割的url就路径前缀匹配，

多重匹配 
---------------------------
在某些情况下，Ingress 中的多条路径会匹配同一个请求。 这种情况下最长的匹配路径优先。 如果仍然有两条同等的匹配路径，则精确路径类型优先于前缀路径类型。

主机名通配符
---------------------------

主机名可以是精确匹配（例如foo.bar.com）或者使用通配符来匹配 （例如*.foo.com）。 
精确匹配要求 HTTP host 头部字段与 host 字段值完全匹配。 通配符匹配则要求 HTTP host 头部字段与通配符规则中的后缀部分相同。

默认 Ingress 类 
---------------------------
将一个 IngressClass 资源的 ingressclass.kubernetes.io/is-default-class 注解设置为 true 将确保新的未指定 ingressClassName 字段的 Ingress 能够分配为这个默认的 IngressClass.

