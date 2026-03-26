#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== ELK (Elasticsearch + Kibana) Installation ===${NC}"

# Check if kubectl is connected
if ! kubectl cluster-info > /dev/null 2>&1; then
    echo "Error: Could not connect to Kubernetes cluster."
    exit 1
fi

echo "Applying Kubernetes manifests..."
kubectl apply -f charts/elk/00-namespace.yaml
kubectl apply -f charts/elk/storage.yaml
kubectl apply -f charts/elk/elasticsearch-service.yaml
kubectl apply -f charts/elk/elasticsearch-statefulset.yaml
kubectl apply -f charts/elk/kibana-deployment.yaml
kubectl apply -f charts/elk/kibana-service.yaml
kubectl apply -f charts/elk/kibana-ingress.yaml
kubectl apply -f charts/elk/filebeat-rbac.yaml
kubectl apply -f charts/elk/filebeat-daemonset.yaml
echo -e "${GREEN}✓ Manifests applied${NC}"

echo "Restarting services to pick up changes..."
kubectl rollout restart statefulset/elasticsearch -n elk || true
kubectl rollout restart deployment/kibana -n elk

echo "Waiting for Elasticsearch to be ready..."
kubectl wait --for=condition=ready pod/elasticsearch-0 -n elk --timeout=300s
echo -e "${GREEN}✓ Elasticsearch is ready${NC}"

echo "Waiting for Kibana to be ready..."
kubectl wait --for=condition=available deployment/kibana -n elk --timeout=300s
echo -e "${GREEN}✓ Kibana is ready${NC}"

echo -e "${BLUE}=== Installation Complete ===${NC}"
echo -e "Access Kibana at: ${GREEN}https://kibana.k8s.orb.local${NC}"
