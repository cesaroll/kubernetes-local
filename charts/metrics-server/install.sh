#!/bin/bash
# Metrics Server Installation Script

set -e

echo "=== Metrics Server Installation ==="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if kubectl is configured
echo -e "${YELLOW}Checking kubectl connection...${NC}"
if ! kubectl cluster-info &> /dev/null; then
    echo -e "${RED}Error: kubectl is not configured or cannot connect to cluster${NC}"
    exit 1
fi
echo -e "${GREEN}✓ kubectl connected${NC}"
echo ""

# Apply manifests
echo -e "${YELLOW}Installing Metrics Server manifests...${NC}"
kubectl apply -f /Users/cesarl/k8s/charts/metrics-server/components.yaml
echo -e "${GREEN}✓ Manifests applied${NC}"
echo ""

# Wait for deployment to be ready
echo -e "${YELLOW}Waiting for Metrics Server to be ready...${NC}"
kubectl wait --for=condition=available --timeout=120s deployment/metrics-server -n kube-system
echo -e "${GREEN}✓ Metrics Server is ready${NC}"
echo ""

echo "=== Installation Complete ==="
echo ""
echo "Metrics are now being collected. You can check them with:"
echo "  kubectl top nodes"
echo "  kubectl top pods -A"
echo ""
