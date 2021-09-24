ReplicaSet
===================

ReplicaSet是下一代副本控制器， 和replicationController之前的唯一区别是选择器的支持问题 ，前者基于新的集合选择器， 后者仅仅支持基于等同的选择器要求。 

不要直接编写ReplicaSet， 而是使用deployment来部署。
