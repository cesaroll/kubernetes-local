#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Homepage Uninstallation ===${NC}"

echo "Deleting Homepage resources..."
kubectl delete -f charts/homepage/ingress.yaml --ignore-not-found
kubectl delete -f charts/homepage/deployment.yaml --ignore-not-found
kubectl delete -f charts/homepage/service.yaml --ignore-not-found
kubectl delete -f charts/homepage/service-account.yaml --ignore-not-found
# Clean up any leftover configmap if it exists
kubectl delete configmap homepage-config -n homepage --ignore-not-found
echo -e "${GREEN}✓ Resources deleted${NC}"

echo "Deleting Homepage namespace..."
kubectl delete -f charts/homepage/00-namespace.yaml --ignore-not-found
echo -e "${GREEN}✓ Namespace deleted${NC}"

echo -e "${BLUE}=== Uninstallation Complete ===${NC}"
