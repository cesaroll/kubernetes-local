#!/bin/bash
# Kafka Uninstallation Script

set -e

echo "=== Kafka Uninstall ==="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

NAMESPACE="kafka"

echo -e "${YELLOW}Checking kubectl connection...${NC}"
if ! kubectl cluster-info &> /dev/null; then
    echo -e "${RED}Error: kubectl is not configured or cannot connect to cluster${NC}"
    exit 1
fi
echo -e "${GREEN}✓ kubectl connected${NC}"
echo ""

echo -e "${YELLOW}Deleting Kafka resources...${NC}"
kubectl delete -f /Users/cesarl/k8s/charts/kafka/ --ignore-not-found
echo -e "${GREEN}✓ Resources deleted${NC}"
echo ""

echo -e "${YELLOW}Waiting for namespace to terminate...${NC}"
kubectl wait --for=delete namespace/${NAMESPACE} --timeout=60s || true
echo -e "${GREEN}✓ Namespace terminated${NC}"
echo ""

echo -e "${GREEN}✓ Uninstall complete${NC}"
echo ""
