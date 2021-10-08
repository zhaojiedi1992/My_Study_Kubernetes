crontab
===========================
cronjob可以完成周期调度，执行作业的。 区别了单独一次的job.

crontab简述
----------------------------
cronjobs对于创建周期性的，反复重复的任务很有用。

cronjob样例
----------------------------

.. literalinclude:: ../../../scripts/jobs/job.yaml
   :language: yaml
   :linenos:

具体crontab表达式可以参考下
`crontab.guru <https://crontab.guru/>`_

CronJob 限制 
----------------------------

cronjob根据其计划编排，在每次执行任务的时候大约会创建一个job,之所以是大约，在某些情况下会创建2个job，或者无job。因此job应该是幂等的。

.. warning:: 如果 startingDeadlineSeconds 的设置值低于 10 秒钟，CronJob 可能无法被调度。 这是因为 CronJob 控制器每 10 秒钟执行一次检查。

CronJob 仅负责创建与其调度时间相匹配的 Job，而 Job 又负责管理其代表的 Pod。


