#!/bin/bash

kubectl expose deployment nginx \
	--port=80 \
	--type=LoadBalancer
