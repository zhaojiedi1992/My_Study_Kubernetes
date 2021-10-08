jobs
===========================

jobs是创建一个或者多个pods的，当数量达到成功的个数阈值时候，任务就结束了，
job是可以配置并行的。


job样例
----------------------------

.. literalinclude:: ../../../scripts/jobs/job.yaml
   :language: yaml
   :linenos:

应用一下，通过如下命令查看

.. code-block:: bash

        kubectl get job                                                                                                              
        NAME   COMPLETIONS   DURATION   AGE
        pi     0/1 of 2      4s         4s

        kubectl describe job pi                                                                                                        
        Name:             pi
        Namespace:        default
        Selector:         controller-uid=d4d9a0cc-92c2-4d62-b632-9f209f765d16
        Labels:           controller-uid=d4d9a0cc-92c2-4d62-b632-9f209f765d16
                                job-name=pi
        Annotations:      <none>
        Parallelism:      2
        Completions:      <unset>
        Completion Mode:  NonIndexed
        Start Time:       Wed, 06 Oct 2021 11:37:21 +0800
        Completed At:     Wed, 06 Oct 2021 11:37:45 +0800
        Duration:         24s
        Pods Statuses:    0 Running / 2 Succeeded / 0 Failed
        Pod Template:
        Labels:  controller-uid=d4d9a0cc-92c2-4d62-b632-9f209f765d16
                job-name=pi
        Containers:
        pi:
            Image:      perl
            Port:       <none>
            Host Port:  <none>
            Command:
            perl
            -Mbignum=bpi
            -wle
            print bpi(2000)
            Environment:  <none>
            Mounts:       <none>
        Volumes:        <none>
        Events:
        Type    Reason            Age   From            Message
        ----    ------            ----  ----            -------
        Normal  SuccessfulCreate  51s   job-controller  Created pod: pi--1-rwc87
        Normal  SuccessfulCreate  51s   job-controller  Created pod: pi--1-9r6qf
        Normal  Completed         27s   job-controller  Job completed


job的并行执行
----------------------------

- 非并行: 通常启用一个pod,当pod终止后，视为pod完成状态。
- 具有确定完成计数的job: .spec.completions设为一个非0的，当成功的pod个数达到spec.completions后就认为pod完成。spec.completionmod=indexed时候，每个pod会有一个不同的索引。
- 带有工作队列冰箱的job: .spec.parallelism 多个pod协同，每个pod从队列取出来部分任务，每个pod都可以确定其他的pod是否完成，job任何pod成功终止，不在创建新的pod。