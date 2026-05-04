#!/bin/bash

CLUSTER="bootcamp-dnunez-v2"
REGION="us-east-1"
PROFILE="bootcamp"

kubectl delete svc nginx
kubectl delete deployment nginx

eksctl delete cluster \
	--name $CLUSTER \
	--region $REGION \
	--profile $PROFILE


