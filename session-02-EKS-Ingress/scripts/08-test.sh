#!/bin/bash

ALB=$(kubectl get ingress bootcamp-dnunez -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "Testing /"
curl -sI "http://$ALB/" | head -1

echo "Testing /echo"
curl -sI "http://$ALB/echo" | head -1

echo "Body /"
curl -s "http://$ALB/" | head -3

echo "Body /echo"
curl -s "http://$ALB/echo" | head -3
