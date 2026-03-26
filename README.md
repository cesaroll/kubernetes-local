# kubernetes-local

Local Kubernetes configurations for PostgreSQL and Redis.

## Project Structure

- `charts/`: Contains Kubernetes manifest files (YAML) and installation scripts.
  - `postgresql/`: PostgreSQL deployment, service, and storage configurations.
  - `redis/`: Redis deployment and service configurations.
- `.gitignore`: Configured to ignore logs, temp files, and local volume data (`vol*/`).

## Getting Started

To install the services, navigate to their respective directories in `charts/` and use the provided `install.sh` scripts.
