#!/bin/bash

# Add SigNoz Helm repository
helm repo add signoz https://charts.signoz.io
helm repo update

# Install SigNoz
helm install signoz signoz/signoz \
  --namespace platform \
  --create-namespace \
  --values values.yaml

echo "Waiting for SigNoz to be ready..."
kubectl rollout status statefulset/signoz -n platform --timeout=300s
