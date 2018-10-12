pod优先级
==========================

使用优先级
------------------------

1. 添加一个或者多个PriorityClasses
2. 创建pod并制定优先级类到pod上面来， 如果pod受到deployment控制， 直接在pod的template里面制定就可以了。 

禁用优先级
--------------------------

设置--feature-gates=PodPriority=false 可以禁用优先级， 当然也会自动禁用抢占。
如果只想禁用抢占，设置disablePreemption=false

