#!/bin/bash

CLUSTER="bootcamp-dnunez"
REGION="us-east-1"

helm repo add eks https://aws.github.io/eks-charts
helm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  --namespace kube-system \
  --set clusterName=$CLUSTER \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=$REGION

kubectl -n kube-system rollout status deployment/aws-load-balancer-controller
