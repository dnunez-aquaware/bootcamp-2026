#!/bin/bash

kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx \
  --port=80 \
  --target-port=80 \
  --name=nginx

kubectl create deployment echo --image=httpd
kubectl expose deployment echo \
  --port=80 \
  --target-port=80 \
  --name=echo
