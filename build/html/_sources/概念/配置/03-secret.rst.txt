secret
========================
secret是包含少量敏感信息，对比confimap来说，这个就是机密信息。其他基本一致。 

如何使用configmap的数据
------------------------------------

- 作为挂载到一个或多个容器上的 卷 中的文件。
- 作为容器的环境变量
- 由 kubelet 在为 Pod 拉取镜像时使用


secret的类型
---------------------------------------

.. csv-table:: secret的类型
   :header: 内置类型,用法
   :widths: 30,30
   Opaque,	用户定义的任意数据
   kubernetes.io/service-account-token,	服务账号令牌
   kubernetes.io/dockercfg,	~/.dockercfg 文件的序列化形式
   kubernetes.io/dockerconfigjson,	~/.docker/config.json 文件的序列化形式
   kubernetes.io/basic-auth,	用于基本身份认证的凭据
   kubernetes.io/ssh-auth,	用于 SSH 身份认证的凭据
   kubernetes.io/tls,	用于 TLS 客户端或者服务器端的数据
   bootstrap.kubernetes.io/token,	启动引导令牌数据

服务账号令牌 Secret 
---------------------------
服务账号用于存储服务账号令牌信息的， 可以使用注解来使用kubernetes.io/service-account-name ，然后pod可以通过serviceAccountName指定。

Docker 配置 Secret 
---------------------------

.. code-block:: bash 

  kubectl create secret docker-registry secret-tiger-docker \
    --docker-username=tiger \
    --docker-password=pass113 \
    --docker-email=tiger@acme.com

基本身份认证 Secret 
---------------------------
kubernetes.io/basic-auth 类型用来存放用于基本身份认证所需的凭据信息。 使用这种 Secret 类型时，Secret 的 data 字段必须包含以下两个键：

- username: 用于身份认证的用户名；
- password: 用于身份认证的密码或令牌。

SSH 身份认证 Secret 
---------------------------
提供 SSH 身份认证类型的 Secret 仅仅是出于用户方便性考虑。 

TLS Secret 
---------------------------
字段必须包含 tls.key 和 tls.crt 主键，尽管 API 服务器 实际上并不会对每个键的取值作进一步的合法性检查。







