# Kafka KRaft Chart

This chart deploys Apache Kafka 7.8.0 in KRaft mode (without ZooKeeper) to the cluster using raw Kubernetes manifests.

## Configuration

- **Namespace**: kafka
- **Image**: confluentinc/cp-kafka:7.9.6
- **Storage**: 512Mi persistent volume at `/Users/cesarl/k8s/vol1/kafka`
- **Resources**: 1Gi-2Gi memory, 500m-1000m CPU
- **Storage Class**: local-path

## Components

- **Kafka**: Single broker in KRaft mode
- **Kafka UI**: Web interface for managing the cluster
- **Kafka REST Proxy**: HTTP interface for Kafka
- **Schema Registry**: Storage and retrieval of schemas

## Access Methods

### Internal (from within cluster)
- **Bootstrap Server**: kafka.kafka.svc.cluster.local:9092
- **REST Proxy**: http://kafka-rest.kafka.svc.cluster.local:80
- **Schema Registry**: http://schema-registry.kafka.svc.cluster.local:8081

### Mac/Host Access (via OrbStack)
- **Kafka Bootstrap**: kafka.kafka.svc.cluster.local:9092
- **Kafka UI**: http://kafka-ui.kafka.svc.cluster.local
- **REST Proxy**: http://kafka-rest.kafka.svc.cluster.local
- **Schema Registry**: http://schema-registry.kafka.svc.cluster.local:8081

## Quick Tests

```bash
# List all topics
kubectl exec -it kafka-0 -n kafka -- kafka-topics --bootstrap-server localhost:9092 --list

# Create a test topic
kubectl exec -it kafka-0 -n kafka -- kafka-topics --bootstrap-server localhost:9092 --create --topic test-topic --partitions 1 --replication-factor 1

# Produce messages
kubectl exec -it kafka-0 -n kafka -- kafka-console-producer --bootstrap-server localhost:9092 --topic test-topic

# Consume messages
kubectl exec -it kafka-0 -n kafka -- kafka-console-consumer --bootstrap-server localhost:9092 --topic test-topic --from-beginning
```

## Installation

```bash
cd /Users/cesarl/k8s/charts/kafka
./install.sh
```

## Uninstallation

```bash
cd /Users/cesarl/k8s/charts/kafka
./uninstall.sh
```

## Manual Installation

```bash
mkdir -p /Users/cesarl/k8s/vol1/kafka
kubectl apply -f /Users/cesarl/k8s/charts/kafka/
```

## Manual Uninstallation

```bash
kubectl delete -f /Users/cesarl/k8s/charts/kafka/
rm -rf /Users/cesarl/k8s/vol1/kafka
```
