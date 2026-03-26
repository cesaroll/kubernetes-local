#!/bin/bash
# Homepage Uninstallation Script

set -e

echo "=== Homepage Uninstallation ==="
echo ""

# Colors for output
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Deleting Homepage resources...${NC}"
kubectl delete -f /Users/cesarl/k8s/charts/homepage/ --ignore-not-found
echo -e "${GREEN}✓ Resources deleted${NC}"
echo ""

echo -e "${YELLOW}Deleting Homepage namespace...${NC}"
kubectl delete namespace homepage --ignore-not-found
echo -e "${GREEN}✓ Namespace deleted${NC}"
echo ""

echo "=== Uninstallation Complete ==="
