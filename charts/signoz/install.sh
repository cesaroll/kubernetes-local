#!/bin/bash

# Add SigNoz Helm repository
helm repo add signoz https://charts.signoz.io
helm repo update

# Install SigNoz in signoz namespace
helm install signoz signoz/signoz \
  --namespace signoz \
  --create-namespace \
  --values values.yaml

# Apply manual ingress as the chart one seems problematic in this version
kubectl apply -f ingress.yaml

echo "Waiting for SigNoz to be ready..."
kubectl rollout status statefulset/signoz -n signoz --timeout=600s
