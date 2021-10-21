api发起的驱逐
==========================================
api发起的住区是调用eviction api 创建驱逐对象，在体面的终止pid的过程。

可以通过kubectl drain 这样的命令发起驱逐。 

API 发起的驱逐将遵从你的 PodDisruptionBudgets 和 terminationGracePeriodSeconds 配置。


