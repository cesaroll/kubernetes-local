#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Homepage Installation ===${NC}"

# Check if kubectl is connected
if ! kubectl cluster-info > /dev/null 2>&1; then
    echo "Error: Could not connect to Kubernetes cluster."
    exit 1
fi

echo "Applying Kubernetes manifests..."
kubectl apply -f charts/homepage/00-namespace.yaml
kubectl apply -f charts/homepage/service-account.yaml
kubectl apply -f charts/homepage/service.yaml
kubectl apply -f charts/homepage/deployment.yaml
kubectl apply -f charts/homepage/ingress.yaml
echo -e "${GREEN}✓ Manifests applied${NC}"

echo "Waiting for Homepage to be ready..."
kubectl wait --for=condition=available --timeout=120s deployment/homepage -n homepage
echo -e "${GREEN}✓ Homepage is ready${NC}"

echo -e "${BLUE}=== Installation Complete ===${NC}"
echo -e "Access Homepage at: ${GREEN}https://homepage.k8s.orb.local${NC}"
