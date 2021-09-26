Kubernetes API
===================

API版本控制
---------------------

为了更容易消除字段或重构资源表示，Kubernetes支持多个API版本，每个API版本位于不同的API路径，例如/api/v1或 /apis/extensions/v1beta1。

API扩展
---------------------

目前提供2种方法进行扩展

1. 自定义资源crd方式进行扩展
2. 聚合层AA方式进行扩展
