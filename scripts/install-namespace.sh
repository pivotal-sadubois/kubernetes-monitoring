#!/bin/bash

export NAMESPACE=monitoring
kubectl create namespace ${NAMESPACE}
kubectl config set-context $(kubectl config current-context) --namespace=${NAMESPACE}

