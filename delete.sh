#!/bin/bash

qctl='kubectl --namespace=smilo-test  --kubeconfig=/home/smilo/k8s_config --insecure-skip-tls-verify '
$qctl delete -f out/smilo-shared-config.yaml
$qctl delete -f out/smilo-services.yaml
$qctl delete -f out/smilo-deployments.yaml
$qctl delete -f out/smilo-keyconfigs.yaml
