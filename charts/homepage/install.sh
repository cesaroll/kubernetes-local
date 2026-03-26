#!/bin/bash
# Homepage Installation Script

set -e

echo "=== Homepage Installation ==="
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

# Create volume directory if it doesn't exist
echo -e "${YELLOW}Creating volume directory...${NC}"
mkdir -p /Users/cesarl/k8s/vol1/homepage
echo -e "${GREEN}✓ Volume directory ready${NC}"
echo ""

# Apply all manifests
echo -e "${YELLOW}Installing Homepage manifests...${NC}"
kubectl apply -f /Users/cesarl/k8s/charts/homepage/00-namespace.yaml
kubectl apply -f /Users/cesarl/k8s/charts/homepage/
echo -e "${GREEN}✓ Manifests applied${NC}"
echo ""

# Wait for deployment to be ready
echo -e "${YELLOW}Waiting for Homepage to be ready...${NC}"
kubectl wait --for=condition=available --timeout=300s deployment/homepage -n homepage
echo -e "${GREEN}✓ Homepage is ready${NC}"
echo ""

# Show status
echo "=== Installation Complete ==="
echo ""
echo "Homepage is now running in the homepage namespace."
echo ""
echo "Check status:"
echo "  kubectl get pods -n homepage"
echo "  kubectl get svc -n homepage"
echo "  kubectl get ingress -n homepage"
echo ""
echo "Connection info (From Mac/Host):"
echo "  Internal URL (HTTP): http://homepage.homepage.svc.cluster.local"
echo "  External URL (HTTPS): https://homepage.k8s.orb.local"
echo ""
