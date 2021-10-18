configmap
========================
configmap是一种api对象，用来将费机密性的数据保持到键值对中，


ConfigMap
-------------------------
使用configmap可以保障配置和应用程序代码的分离。


configmap创建样例
-------------------------


.. code-block:: yaml 

    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: game-demo
    data:
      # 类属性键；每一个键都映射到一个简单的值
      player_initial_lives: "3"
      ui_properties_file_name: "user-interface.properties"

      # 类文件键
      game.properties: |
        enemy.types=aliens,monsters
        player.maximum-lives=5    
      user-interface.properties: |
        color.good=purple
        color.bad=yellow
        allow.textmode=true    

data部分是个kv数据， 如果多行数据的话， 可以使用|来使用。

如何使用configmap的数据
------------------------------------

- 容器命令和参数内
- 容器的环境变量
- 只读卷添加一个文件，应用读取
- 编写代码在pod中运行，通过api方式读取configmap。


pod使用configmap样例
----------------------------------------

.. code-block:: yaml 

    apiVersion: v1
    kind: Pod
    metadata:
      name: configmap-demo-pod
    spec:
      containers:
        - name: demo
          image: alpine
          command: ["sleep", "3600"]
          env:
            # 定义环境变量
            - name: PLAYER_INITIAL_LIVES # 请注意这里和 ConfigMap 中的键名是不一样的
              valueFrom:
                configMapKeyRef:
                  name: game-demo           # 这个值来自 ConfigMap
                  key: player_initial_lives # 需要取值的键
            - name: UI_PROPERTIES_FILE_NAME
              valueFrom:
                configMapKeyRef:
                  name: game-demo
                  key: ui_properties_file_name
          volumeMounts:
          - name: config
            mountPath: "/config"
            readOnly: true
      volumes:
        # 你可以在 Pod 级别设置卷，然后将其挂载到 Pod 内的容器中
        - name: config
          configMap:
            # 提供你想要挂载的 ConfigMap 的名字
            name: game-demo
            # 来自 ConfigMap 的一组键，将被创建为文件
            items:
            - key: "game.properties"
              path: "game.properties"
            - key: "user-interface.properties"
              path: "user-interface.properties"

这个pod使用了2种， 第一种环境变量方式， 通过valuefrom方式，指定了环境变量的value从一个configmap的特定key获取。 
第二种方式，通过读取一个configmap的特定key，弄成多个文件，然后这个卷包含多个文件的， 挂载到pod中，然后给pod使用。

几种方式的不同
--------------------------

通过环境变量的方式，不会自动更新的，通过文件方式，文件可以自动改变的。 

不可变更的 ConfigMap 
---------------------------
Kubernetes 特性 不可变更的 Secret 和 ConfigMap 提供了一种将各个 Secret 和 ConfigMap 设置为不可变更的选项。

一旦某 ConfigMap 被标记为不可变更，则 无法 逆转这一变化，，也无法更改 data 或 binaryData 字段的内容。
你只能删除并重建 ConfigMap。 因为现有的 Pod 会维护一个对已删除的 ConfigMap 的挂载点，建议重新创建 这些 Pods。








