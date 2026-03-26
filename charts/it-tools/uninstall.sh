#!/bin/bash
# IT-Tools Uninstallation Script

set -e

echo "=== IT-Tools Uninstallation ==="
echo ""

# Colors for output
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Deleting IT-Tools resources...${NC}"
kubectl delete -f /Users/cesarl/k8s/charts/it-tools/ --ignore-not-found
echo -e "${GREEN}✓ Resources deleted${NC}"
echo ""

echo -e "${YELLOW}Deleting IT-Tools namespace...${NC}"
kubectl delete namespace it-tools --ignore-not-found
echo -e "${GREEN}✓ Namespace deleted${NC}"
echo ""

echo "=== Uninstallation Complete ==="
