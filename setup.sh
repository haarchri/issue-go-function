#!/bin/bash
set -e

kind create cluster --name=issue-go-function
kubectx kind-issue-go-function

kubectl create namespace upbound-system

helm install uxp --namespace upbound-system upbound-stable/universal-crossplane --devel --version 1.14.5-up.1
kubectl -n upbound-system wait --for=condition=Available deployment --all --timeout=5m

sleep 60

kubectl kustomize . -o tt.yaml
kubectl apply -f tt.yaml
rm -rf tt.yaml

sleep 60

kubectl apply -f examples/xr.yaml