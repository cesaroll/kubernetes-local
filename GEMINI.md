# Workspace Context & Architectural Decisions

This file serves as a persistent memory of the architectural choices, constraints, and project state for the `kubernetes-local` project.

## 📌 Project Constraints
- **Environment**: Local Kubernetes (OrbStack).
- **Tooling**: GitHub CLI (`gh`) and `git` for repository management.
- **Access Pattern**: Services must be accessible from **both** the Kubernetes cluster and the local Mac/Host.
- **Naming Convention**: Configuration files follow the pattern `00-namespace.yaml`, `deployment.yaml`, `service.yaml`, etc.
- **Workflow Mandate**: **NEVER** commit or push changes unless explicitly directed by the user.

## 🏗️ Architectural Decisions

### 1. Networking & Service Discovery
- **ClusterIP Pattern**: All services (`postgresql`, `redis`, `kafka`, `kafka-ui`, `kafka-rest`, `schema-registry`) use `ClusterIP`.
- **OrbStack Integration**: Leveraging OrbStack's ability to resolve `.svc.cluster.local` domains directly from the Mac host. 
- **Ingress & SSL**: Installed **NGINX Ingress Controller** to handle HTTPS via OrbStack's automatic certificate management for `*.k8s.orb.local` domains. 
- **Removal of LoadBalancers**: Eliminated standalone `LoadBalancer` services to simplify the setup.

### 2. Storage Strategy
- **Local Path Provisioning**: Uses the `local-path` storage class.
- **Persistent Volume Mapping**: 
  - Host path: `/Users/cesarl/k8s/vol1/<service>`
  - Container path: Standard data directories (e.g., `/var/lib/postgresql/data/pgdata`, `/app/config/logs` for Homepage).
- **Git Hygiene**: The `.gitignore` is configured to ignore the entire `vol1/` directory and any other folder starting with `vol` to prevent local data from being committed.

### 3. Kafka Implementation (KRaft Mode)
- **Mode**: KRaft (no ZooKeeper).
- **Listeners**: Simplified to a single `PLAINTEXT` listener.
- **Advertised Listeners**: Configured to `PLAINTEXT://kafka.kafka.svc.cluster.local:9092` to satisfy both internal and external (Mac host) clients.
- **Probe Tuning**: `schema-registry` requires significant `initialDelaySeconds` (60s+) to initialize its internal `_schemas` topic before passing health checks.

### 4. Automation Scripts
- **install.sh / uninstall.sh**: Standardized across all charts with:
  - Color-coded output.
  - Automatic volume directory creation.
  - Pre-flight `kubectl` connection checks.
  - Readiness wait logic (`kubectl wait`).

## 🛠️ Current State
- **PostgreSQL**: Stable, English README, ClusterIP.
- **Redis**: Stable, ClusterIP.
- **Kafka Suite**: 
  - `kafka`: Stable (StatefulSet).
  - `kafka-ui`: Stable (Verified HTTPS access).
  - `kafka-rest`: Stable (Verified Avro production/consumption).
  - `schema-registry`: Stable (Verified schema registration & Avro flow).
- **IT-Tools**: Stable, ClusterIP.
- **Homepage**: Stable, ClusterIP, with Kubernetes integration.
- **Metrics Server**: Stable (Insecure TLS enabled for OrbStack).
- **Git**: Repository `cesaroll/kubernetes-local` created and updated with stable Kafka suite configuration.

---
*Note: This file is automatically updated as the project evolves.*
