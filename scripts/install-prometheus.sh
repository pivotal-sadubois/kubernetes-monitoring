#!/bin/bash

kubectl apply -f prometheus-rbac.yaml
kubectl apply -f prometheus-config-map.yaml
kubectl apply -f prometheus-deployment.yaml
kubectl get pods

