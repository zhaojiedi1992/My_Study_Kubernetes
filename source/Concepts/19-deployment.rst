deployment
=============================

创建部署
--------------------------

.. code-block:: yaml 

    controllers/nginx-deployment.yaml  
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: nginx-deployment
    labels:
        app: nginx
    spec:
    replicas: 3
    selector:
        matchLabels:
        app: nginx
    template:
        metadata:
        labels:
            app: nginx
        spec:
        containers:
        - name: nginx
            image: nginx:1.15.4
            ports:
            - containerPort: 80

使用如下命令完成部署
kubectl apply -f  https://k8s.io/examples/controllers/nginx-deployment.yaml

更新部署

修改nginx-deployment文件， 然后再次应用
kubectl apply -f  https://k8s.io/examples/controllers/nginx-deployment.yaml

.. note:: 在注解片段设置 kubernetes.io/change-cause="image updated to 1.9.1" 可以指定更新信息。方面通过history获取更新信息。 

查看相关的状态信息

.. code-block:: bash 

    kubectl rollout status deployments nginx-deployment
    kubectl get deployment 
    kubectl describe deployment nginx-deployment 
    kubectl get pod 
    kubectl get rs 

查看部署历史

.. code-block:: bash 

    kubectl rollout history deployment/nginx-deployment
    kubectl rollout history  deployment nginx --revision=3 

回滚特定历史版本

.. code-block:: bash 

    kubectl rollout undo deployment/nginx-deployment
    kubectl rollout undo deployment/nginx-deployment --to-revision=2

可以回滚的历史可以通过.spec.revisionHistoryLimit指定。 

扩展部署

.. code-block:: bash 

    kubectl scale deployment nginx-deployment --replicas=10
    kubectl autoscale deployment ngnx-deployment --min=2 --max=12  --cpu-percent=80

暂停部署
---------------------------------------

.. code-block:: bash 

    kubectl rollout pause deployment/nginx-deployment

恢复暂停部署
------------------------------------------

.. code-block:: bash 

    kubectl rollout resume deploy/nginx-deployment
