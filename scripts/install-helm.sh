#!/bin/bash

kubectl apply -f tiller-rbac.yaml
helm init --service-account tiller
