#!/bin/bash
# Kafka Installation Script

set -e

echo "=== Kafka Installation ==="
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

# Create Kafka volume directory
echo -e "${YELLOW}Creating Kafka volume directory...${NC}"
mkdir -p /Users/cesarl/k8s/vol1/kafka
echo -e "${GREEN}✓ Kafka volume directory created${NC}"
echo ""

# Apply all manifests
echo -e "${YELLOW}Installing Kafka manifests...${NC}"
kubectl apply -f /Users/cesarl/k8s/charts/kafka/00-namespace.yaml
kubectl apply -f /Users/cesarl/k8s/charts/kafka/
echo -e "${GREEN}✓ Manifests applied${NC}"
echo ""

# Wait for Kafka to be ready
echo -e "${YELLOW}Waiting for Kafka pod to be ready...${NC}"
kubectl wait --for=condition=ready pod/kafka-0 -n kafka --timeout=300s
echo -e "${GREEN}✓ Kafka is ready${NC}"
echo ""

# Show status
echo "=== Installation Complete ==="
echo ""
echo "Kafka is now running in the kafka namespace."
echo ""
echo "Check status:"
echo "  kubectl get pods -n kafka"
echo "  kubectl get svc -n kafka"
echo "  kubectl get ingress -n kafka"
echo ""
echo "Connection info:"
echo "  Kafka Bootstrap: kafka.kafka.svc.cluster.local:9092"
echo "  Kafka UI (HTTPS): https://kafka-ui.k8s.orb.local"
echo "  Kafka UI (Internal): http://kafka-ui.kafka.svc.cluster.local"
echo "  Kafka REST: http://kafka-rest.kafka.svc.cluster.local"
echo "  Schema Registry: http://schema-registry.kafka.svc.cluster.local:8081"
echo ""
