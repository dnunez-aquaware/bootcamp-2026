#!/bin/bash

CLUSTER="bootcamp-dnunez"
REGION="us-east-1"
PROFILE="bootcamp"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text --profile $PROFILE)

eksctl create iamserviceaccount \
  --cluster $CLUSTER \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole-dnunez \
  --attach-policy-arn arn:aws:iam::$ACCOUNT_ID:policy/AWSLoadBalancerControllerIAMPolicy-dnunez \
  --approve \
  --region $REGION \
  --profile $PROFILE
