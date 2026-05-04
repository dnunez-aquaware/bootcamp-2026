#!/bin/bash

CLUSTER="bootcamp-dnunez"
REGION="us-east-1"
PROFILE="bootcamp"

kubectl delete ingress bootcamp-dnunez

helm uninstall aws-load-balancer-controller -n kube-system

eksctl delete iamserviceaccount \
  --cluster $CLUSTER \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --region $REGION \
  --profile $PROFILE

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text --profile $PROFILE)

aws iam delete-policy \
  --policy-arn arn:aws:iam::$ACCOUNT_ID:policy/AWSLoadBalancerControllerIAMPolicy-dnunez \
  --profile $PROFILE

kubectl delete svc nginx echo
kubectl delete deployment nginx echo

eksctl delete cluster \
  --name $CLUSTER \
  --region $REGION \
  --profile $PROFILE
