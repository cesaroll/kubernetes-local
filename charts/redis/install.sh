#!/bin/bash
# Redis Installation Script
# This script installs Redis using raw Kubernetes manifests

set -e

echo "=== Redis Installation ==="
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
echo -e "${YELLOW}Installing Redis manifests...${NC}"
kubectl apply -f /Users/cesarl/k8s/charts/redis/00-namespace.yaml
kubectl apply -f /Users/cesarl/k8s/charts/redis/
echo -e "${GREEN}✓ Manifests applied${NC}"
echo ""

# Wait for deployment to be ready
echo -e "${YELLOW}Waiting for Redis to be ready...${NC}"
kubectl wait --for=condition=available --timeout=300s deployment/redis -n redis
echo -e "${GREEN}✓ Redis is ready${NC}"
echo ""

# Show status
echo "=== Installation Complete ==="
echo ""
echo "Redis is now running in the redis namespace."
echo ""
echo "Check status:"
echo "  kubectl get pods -n redis"
echo "  kubectl get svc -n redis"
echo ""
echo "Connection info (Internal):"
echo "  Service: redis.redis.svc.cluster.local:6379"
echo ""
echo "Connection info (From Mac/Host):"
echo "  Host: redis.redis.svc.cluster.local"
echo "  Port: 6379"
echo ""
echo "Test connection:"
echo "  kubectl exec -it -n redis deployment/redis -- redis-cli ping"
echo ""
