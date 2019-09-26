#!/bin/bash

kubectl apply -f out/01-smilo-shared-config.yaml
kubectl apply -f out/02-smilo-services.yaml
kubectl apply -f out/03-smilo-keyconfigs.yaml
kubectl apply -f out/04-smilo-deployments.yaml
