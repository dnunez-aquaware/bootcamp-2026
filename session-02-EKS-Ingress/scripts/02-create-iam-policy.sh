#!/bin/bash

PROFILE="bootcamp"

curl -fsSL -o iam_policy.json \
  https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy-dnunez \
  --policy-document file://iam_policy.json \
  --profile $PROFILE
