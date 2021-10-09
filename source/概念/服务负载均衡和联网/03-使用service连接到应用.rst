使用 Service 连接到应用
==========================================


访问 Service
---------------------------
k8s支持2中查找服务的模式， 环境变量和dns

保护 Service 
---------------------------
我们只在集群内部访问了 Nginx 服务器。在将 Service 暴露到因特网之前，我们希望确保通信信道是安全的。 为实现这一目的，可能需要：

- 用于 HTTPS 的自签名证书（除非已经有了一个识别身份的证书）
- 使用证书配置的 Nginx 服务器
- 使证书可以访问 Pod 的 Secret

准备公钥和私钥

.. literalinclude:: ../../../scripts/service/create_sec.sh
   :language: bash
   :linenos:

执行上面的脚本，生成证书，然后执行下面脚本完成secret的创建
.. code-block:: bash

    # 直接跟进文件创建
    kubectl create secret  tls nginxsvc.tls --key=nginx.key --cert=nginx.crt
    # 通过命令方式，进行归档成为文件
    kubectl get secret  nginxsvc.tls  -o yaml >nginxsvc.tls

准备个nginx配置下

.. code-block:: bash

    curl 'https://raw.githubusercontent.com/kubernetes/examples/master/staging/https-nginx/default.conf'  >default.conf
    kubectl get cm nginxconfigmap -o yaml >nginxconfigmap.yaml

准备nginx service和deployment

.. literalinclude:: ../../../scripts/service/nginx-https.yml
   :language: bash
   :linenos:

访问测试

.. code-block:: bash 

    # 确认ip
    kubectl get pod my-nginx-77fd8b978f-rcvh2 -o yaml |grep podip -i                
    podIP: 10.244.2.219
    podIPs:

    # 测试访问
    $ curl -k https://10.244.2.219/ |grep Welcome
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                    Dload  Upload   Total   Spent    Left  Speed
    100   612  100   612    0     0   6274      0 --:--:-- --:--:-- --:--:--  6309
    <title>Welcome to nginx!</title>
    <h1>Welcome to nginx!</h1>