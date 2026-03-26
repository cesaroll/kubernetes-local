#!/bin/bash
# IT-Tools Installation Script

set -e

echo "=== IT-Tools Installation ==="
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

# Apply all manifests
echo -e "${YELLOW}Installing IT-Tools manifests...${NC}"
kubectl apply -f /Users/cesarl/k8s/charts/it-tools/00-namespace.yaml
kubectl apply -f /Users/cesarl/k8s/charts/it-tools/
echo -e "${GREEN}✓ Manifests applied${NC}"
echo ""

# Wait for deployment to be ready
echo -e "${YELLOW}Waiting for IT-Tools to be ready...${NC}"
kubectl wait --for=condition=available --timeout=300s deployment/it-tools -n it-tools
echo -e "${GREEN}✓ IT-Tools is ready${NC}"
echo ""

# Show status
echo "=== Installation Complete ==="
echo ""
echo "IT-Tools is now running in the it-tools namespace."
echo ""
echo "Check status:"
echo "  kubectl get pods -n it-tools"
echo "  kubectl get svc -n it-tools"
echo "  kubectl get ingress -n it-tools"
echo ""
echo "Connection info (From Mac/Host):"
echo "  Internal URL (HTTP): http://it-tools.it-tools.svc.cluster.local"
echo "  External URL (HTTPS): https://it-tools.k8s.orb.local"
echo ""
