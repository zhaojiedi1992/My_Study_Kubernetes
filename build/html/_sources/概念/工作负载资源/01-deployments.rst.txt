deployments
===========================



创建depolyments 
----------------------------

.. literalinclude:: ../../../scripts/deployments/deploy-nginx.yml
   :encoding: utf-8
   :language: yaml
   :linenos:

.. code-block:: text 

   kubectl apply -f deploy-nginx.yml 

   kubectl get pod 
   NAME                                READY   STATUS    RESTARTS   AGE
   nginx-deployment-66b6c48dd5-bxwbl   1/1     Running   0          4m19s
   nginx-deployment-66b6c48dd5-xppgn   1/1     Running   0          4m19s
   nginx-deployment-66b6c48dd5-xv65j   1/1     Running   0          4m19s

   NAME               READY   UP-TO-DATE   AVAILABLE   AGE
   nginx-deployment   3/3     3            3           7m2s

主要字段说明:

* NAME: 列出名称
* READY: 显示的是就绪个数/期望个数
* UP-TO-DATE: 已经更新的副本数量
* AVAILABLE: 当前可供应用使用的副本数量
* AGE: 应用程序运行的时间

更新
----------------------------

修改文件的镜像版本，然后再次apply一次。


.. code-block:: bash 

   kubectl get deploy -w
   NAME               READY   UP-TO-DATE   AVAILABLE   AGE
   nginx-deployment   3/3     1            3           18m
   nginx-deployment   4/3     1            4           19m
   nginx-deployment   3/3     1            3           19m
   nginx-deployment   3/3     2            3           19m
   nginx-deployment   4/3     2            4           20m
   nginx-deployment   4/3     3            4           20m
   nginx-deployment   3/3     3            3           20m
   nginx-deployment   4/3     3            4           20m
   nginx-deployment   3/3     3            3           20m


查看变更
----------------------------

.. code-block:: bash 

   kubectl rollout history deploy nginx-deployment                                1 ↵  2470  21:04:51
   deployment.apps/nginx-deployment 
   REVISION  CHANGE-CAUSE
   1         <none>
   2         <none>
   3         <none>


获取上线进度
----------------------------

.. code-block:: bash 

   vim deploy_nginx.yml                                       
   kubectl apply -f deploy_nginx.yml                           
   deployment.apps/nginx-deployment configured
   kubectl rollout status deployment nginx-deployment          
   Waiting for deployment "nginx-deployment" rollout to finish: 1 out of 3 new replicas have been updated...
   Waiting for deployment "nginx-deployment" rollout to finish: 1 out of 3 new replicas have been updated...
   Waiting for deployment "nginx-deployment" rollout to finish: 1 out of 3 new replicas have been updated...
   Waiting for deployment "nginx-deployment" rollout to finish: 2 out of 3 new replicas have been updated...
   Waiting for deployment "nginx-deployment" rollout to finish: 2 out of 3 new replicas have been updated...
   Waiting for deployment "nginx-deployment" rollout to finish: 2 out of 3 new replicas have been updated...
   Waiting for deployment "nginx-deployment" rollout to finish: 1 old replicas are pending termination...
   Waiting for deployment "nginx-deployment" rollout to finish: 1 old replicas are pending termination...
   deployment "nginx-deployment" successfully rolled out


升级失败的可能原因
----------------------------

- 镜像拉取问题
- 权限不足
- 配额不足
- 就绪探测错误
- 限制范围问题
- 运行时候配置错误