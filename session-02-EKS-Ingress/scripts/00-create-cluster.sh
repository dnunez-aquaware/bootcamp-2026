#!/bin/bash

CLUSTER="bootcamp-dnunez"
REGION="us-east-1"
PROFILE="bootcamp"

eksctl create cluster \
  --name $CLUSTER \
  --region $REGION \
  --node-type t3.small \
  --nodes 2 \
  --managed \
  --profile $PROFILE
