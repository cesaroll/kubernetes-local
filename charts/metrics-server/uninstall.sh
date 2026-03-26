#!/bin/bash
# Metrics Server Uninstallation Script

set -e

echo "=== Metrics Server Uninstallation ==="
echo ""

# Colors for output
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Deleting Metrics Server resources...${NC}"
kubectl delete -f /Users/cesarl/k8s/charts/metrics-server/components.yaml --ignore-not-found
echo -e "${GREEN}✓ Resources deleted${NC}"
echo ""

echo "=== Uninstallation Complete ==="
