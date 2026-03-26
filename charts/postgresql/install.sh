#!/bin/bash
# PostgreSQL Installation Script
# This script installs PostgreSQL using raw Kubernetes manifests

set -e

echo "=== PostgreSQL Installation ==="
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
echo -e "${YELLOW}Installing PostgreSQL manifests...${NC}"
kubectl apply -f /Users/cesarl/k8s/charts/postgresql/00-namespace.yaml
kubectl apply -f /Users/cesarl/k8s/charts/postgresql/
echo -e "${GREEN}✓ Manifests applied${NC}"
echo ""

# Wait for deployment to be ready
echo -e "${YELLOW}Waiting for PostgreSQL to be ready...${NC}"
kubectl wait --for=condition=available --timeout=300s deployment/postgresql -n postgresql
echo -e "${GREEN}✓ PostgreSQL is ready${NC}"
echo ""

# Show status
echo "=== Installation Complete ==="
echo ""
echo "PostgreSQL is now running in the postgresql namespace."
echo ""
echo "Check status:"
echo "  kubectl get pods -n postgresql"
echo "  kubectl get svc -n postgresql"
echo ""
echo "Connection info:"
echo "  Service: postgresql.postgresql.svc.cluster.local:5432"
echo "  Database: postgres"
echo "  User: postgres"
echo "  Password: postgres"
echo ""
echo "Test connection:"
echo "  kubectl exec -n postgresql deployment/postgresql -- psql -U postgres -c 'SELECT version();'"
echo ""
