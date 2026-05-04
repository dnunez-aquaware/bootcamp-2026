#!/bin/bash

CLUSTER="bootcamp-dnunez"
REGION="us-east-1"
PROFILE="bootcamp"

eksctl utils associate-iam-oidc-provider \
  --cluster $CLUSTER \
  --region $REGION \
  --approve \
  --profile $PROFILE
