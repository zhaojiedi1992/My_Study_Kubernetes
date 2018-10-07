#!/bin/bash 


kubectl create  cm cm-nginx --from-literal=NGINX_PORT=80 --from-literal=SERVER_NAME=www.linuxpanda.tech
kubectl get cm
kubectl describe cm cm-ngnx
kubectl  create cm cm-www.linuxpanda.tech --from-file=www.linuxpanda.tech
