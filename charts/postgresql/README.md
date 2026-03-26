# PostgreSQL Chart

This chart deploys PostgreSQL 18 to the OrbStack cluster using raw Kubernetes manifests.

## Configuration

- **Namespace**: postgresql
- **Image**: postgres:18 (PostgreSQL 18)
- **Storage**: 10GB persistent volume at `/Users/cesarl/k8s/volume01/postgresql`
- **Resources**: 256Mi-512Mi memory, 100m-500m CPU
- **Storage Class**: local-path

## Database Configuration

- **Database**: postgres
- **User**: postgres
- **Password**: postgres
- **Data Directory**: /var/lib/postgresql/data/pgdata

## Access Methods

### Internal (from within cluster)
- **Service**: postgresql.postgresql.svc.cluster.local:5432
- **Direct Pod**: Use `kubectl exec` for psql access

## Quick Tests

```bash
# Test database connectivity
kubectl exec -n postgresql deployment/postgresql -- psql -U postgres -c "SELECT version();"

# Create a test database
kubectl exec -n postgresql deployment/postgresql -- psql -U postgres -c "CREATE DATABASE myapp;"

# List all databases
kubectl exec -n postgresql deployment/postgresql -- psql -U postgres -c "\l"

# Interactive psql session
kubectl exec -it -n postgresql deployment/postgresql -- psql -U postgres
```

## File Structure

- `namespace.yaml` - Creates postgresql namespace
- `storage.yaml` - PV/PVC for data persistence (10GB)
- `secret.yaml` - Database credentials
- `deployment.yaml` - PostgreSQL deployment with security context
- `service.yaml` - ClusterIP service
- `install.sh` - Installation script
- `uninstall.sh` - Uninstallation script

## Installation

```bash
cd /Users/cesarl/k8s/charts/postgresql
./install.sh
```

## Uninstallation

```bash
cd /Users/cesarl/k8s/charts/postgresql
./uninstall.sh
```

## Manual Installation

```bash
mkdir -p /Users/cesarl/k8s/vol1/postgresql
kubectl apply -f /Users/cesarl/k8s/charts/postgresql/
```

## Manual Uninstallation

```bash
kubectl delete -f /Users/cesarl/k8s/charts/postgresql/
rm -rf /Users/cesarl/k8s/vol1/postgresql
```
