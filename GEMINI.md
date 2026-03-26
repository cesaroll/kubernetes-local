# Workspace Context & Architectural Decisions

This file serves as a persistent memory of the architectural choices, constraints, and project state for the `kubernetes-local` project.

## 📌 Project Constraints
- **Environment**: Local Kubernetes (OrbStack).
- **Tooling**: GitHub CLI (`gh`) and `git` for repository management.
- **Access Pattern**: Services must be accessible from **both** the Kubernetes cluster and the local Mac/Host.
- **Naming Convention**: Configuration files follow the pattern `00-namespace.yaml`, `deployment.yaml`, `service.yaml`, etc.
- **Workflow Mandate**: **STRICTLY NEVER** commit or push changes unless explicitly directed by the user for that specific change.
- **Storage Preference**: For complex dashboards like Homepage, prefer `hostPath` volumes over `ConfigMaps` to allow for live-reloading, local editing on the Mac, and bypass read-only filesystem issues.

## 🏗️ Architectural Decisions

### 1. Networking & Service Discovery
- **ClusterIP Pattern**: All core services (`postgresql`, `redis`, `kafka`) use `ClusterIP`.
- **OrbStack Integration**: Leveraging OrbStack's ability to resolve `.svc.cluster.local` domains directly from the Mac host. 
- **Ingress & SSL**: NGINX Ingress Controller handles HTTPS via OrbStack's automatic certificate management for `*.k8s.orb.local` domains.

### 2. Homepage Architecture (The "No-Storage" Evolution)
- **Host-Path Sync**: Homepage configuration is mounted via `hostPath` from `charts/homepage/config/` to `/app/config`. This allows the user to edit YAML files on macOS and see changes instantly without rebuilding or restarting.
- **RBAC for Kubernetes Integration**: A dedicated `ServiceAccount`, `ClusterRole`, and `ClusterRoleBinding` are used to allow Homepage to query the Kubernetes API for cluster and node statistics.
- **Service Monitoring**: 
  - **siteMonitor**: Used for health checks. TCP handshakes (`tcp://`) are used for non-HTTP services like PostgreSQL and Redis.
  - **Custom Widgets**: PostgreSQL and Redis widgets are configured to show real-time metrics (e.g., active connections).

### 3. Kafka Implementation (KRaft Mode)
- **Mode**: KRaft (no ZooKeeper).
- **Listeners**: Simplified to a single `PLAINTEXT` listener.
- **Advertised Listeners**: Configured to `PLAINTEXT://kafka.kafka.svc.cluster.local:9092` to satisfy both internal and external (Mac host) clients.

### 4. Automation & Maintenance
- **Standardized Scripts**: Every service includes `install.sh` and `uninstall.sh`.
- **Rollout Lifecycle**: Installation scripts for services with local volumes include a `rollout restart` to ensure configuration changes are picked up immediately.

## 🛠️ Current State
- **PostgreSQL**: Stable, includes Homepage widget integration.
- **Redis**: Stable, includes Homepage widget integration.
- **Kafka Suite**: 
  - `kafka`: Stable (StatefulSet).
  - `kafka-ui`: Stable (HTTPS).
  - `kafka-rest` & `schema-registry`: Stable.
- **IT-Tools**: Stable, accessible via `it-tools.k8s.orb.local`.
- **Homepage**: Stable and highly customized. Accessible at `https://homepage.k8s.orb.local`.
  - Categories: Tools, Storage, Infrastructure, Network.
  - Includes Kubernetes cluster/node widgets and individual service health monitors.
- **Metrics Server**: Stable (Insecure TLS enabled for OrbStack).

---
*Note: This file is automatically updated as the project evolves.*
