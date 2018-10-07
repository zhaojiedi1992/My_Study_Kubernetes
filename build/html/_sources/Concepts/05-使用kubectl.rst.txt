使用kubectl
======================


势在必行的命令
----------------------

.. code-block:: bash 

    kubectl run nginx --image=nginx 

    kubectl create deployment nginx --image=nginx

使用对象配置文件
-------------------------------

.. code-block:: bash 

    kubectl create -f nginx.yaml

使用配置目录
--------------------------------

.. code-block:: bash 

    kubectl apply -R -f configs/

从命令式命令迁移到命令式对象配置
-----------------------------------

1. 将活动对象导出到本地对象配置文件

.. code-block:: bash 
    kubectl get <kind>/<name> -o yaml --export > <kind>_<name>.yaml

2. 从对象配置文件中手动删除状态字段。
3. 对于后续对象管理，请replace专门使用。

.. code-block:: bash 
    kubectl replace -f <kind>_<name>.yaml

从命令式对象配置迁移到声明性对象配置
-----------------------------------

1. kubectl.kubernetes.io/last-applied-configuration在对象上设置注释：

.. code-block:: bash 

    kubectl replace --save-config -f <kind>_<name>.yaml

2. 更改kubectl apply用于专门管理对象的进程。






