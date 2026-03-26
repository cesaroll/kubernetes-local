#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== ELK Uninstallation ===${NC}"

echo "Deleting ELK resources..."
kubectl delete -f charts/elk/kibana-ingress.yaml --ignore-not-found
kubectl delete -f charts/elk/filebeat-daemonset.yaml --ignore-not-found
kubectl delete -f charts/elk/filebeat-rbac.yaml --ignore-not-found
kubectl delete -f charts/elk/kibana-service.yaml --ignore-not-found
kubectl delete -f charts/elk/kibana-deployment.yaml --ignore-not-found
kubectl delete -f charts/elk/elasticsearch-statefulset.yaml --ignore-not-found
kubectl delete -f charts/elk/elasticsearch-service.yaml --ignore-not-found
kubectl delete -f charts/elk/storage.yaml --ignore-not-found
echo -e "${GREEN}✓ Resources deleted${NC}"

echo "Deleting ELK namespace..."
kubectl delete -f charts/elk/00-namespace.yaml --ignore-not-found
echo -e "${GREEN}✓ Namespace deleted${NC}"

echo -e "${BLUE}=== Uninstallation Complete ===${NC}"
