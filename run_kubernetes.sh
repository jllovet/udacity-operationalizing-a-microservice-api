#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=jllovet/udacitydevops

# Step 2
# Run the Docker Hub container with kubernetes
# Create deployment with external service for load balancer
kubectl apply -f jllovet-udacitydevops.yaml

# Step 3:
# List kubernetes pods
kubectl get pod

# Step 4:
# Forward the container port to a host
# Resource found here for port forwarding from localhost
# https://alesnosek.com/blog/2017/02/14/accessing-kubernetes-pods-from-outside-of-the-cluster/
kubectl port-forward service/jllovet-udacitydevops-service 8000:8000
