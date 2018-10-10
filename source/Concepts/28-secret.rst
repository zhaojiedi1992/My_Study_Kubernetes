secret
=============================
用于保存比较私密的数据。 


创建secret
-----------------------------

.. code-block:: bash 

$ echo -n 'admin' > ./username.txt
$ echo -n '1f2d1e2e67df' > ./password.txt
$ kubectl create secret generic db-user-pass --from-file=./username.txt --from-file=./password.txt


获取secret的密码
-----------------------------

.. code-block:: bash 

    kubectl get secret mysecret -o yaml
    apiVersion: v1
    data:
    username: YWRtaW4=
    password: MWYyZDFlMmU2N2Rm
    kind: Secret
    metadata:
    creationTimestamp: 2016-01-22T18:41:56Z
    name: mysecret
    namespace: default
    resourceVersion: "164619"
    selfLink: /api/v1/namespaces/default/secrets/mysecret
    uid: cfee02d6-c137-11e5-8d73-42010af00002
    type: Opaque

    echo 'MWYyZDFlMmU2N2Rm' | base64 --decode
    1f2d1e2e67df

secret不是绝对的加密，只是使用了base64编码而已。 


通过文件创建
-----------------------

.. code-block:: bash 

    kubectl create secret generic db_info --from_literal=a=b --dry-run -o yaml >db_info.yml

使用secret
----------------

secret可以作为env，也可以作为volume在pod中使用

步骤： 

1. 创建secret
2. .spec.volumes[].secret.secretName 设置卷采用的secret
3. .spec.containers[].volumeMounts[] 设置pod的容器挂载特定的卷，


向特定路径投射secret
----------------------------

.. code-block:: yaml 

    apiVersion: v1
    kind: Pod
    metadata:
      name: mypod
    spec:
      containers:
      - name: mypod
        image: redis
        volumeMounts:
        - name: foo
          mountPath: "/etc/foo"
          readOnly: true
      volumes:
      - name: foo
        secret:
          secretName: mysecret
          items:
          - key: username
            path: my-group/my-username

如果secret下的所有key需要挂到特定目录， 只需要设置mountPath就可以了。 
如果secret下的多个key分别需要挂到多个目录， 在item.path里面设置多个路径就可以了。 
可以使用defaultMode: 256来指定权限， 这个权限不能写0777这样的权限， 0777权限对应的值为0*8*8*8+7*8*8+7*8+7=511


使用secret作为环境变量
------------------------------

步骤： 

1. 创建secret
2. env[].valueFrom.secretKeyRef 设置环境变量从secret来。 
3. 修改镜像或者entrypoint，让其可以获取到注入的环境变量。
