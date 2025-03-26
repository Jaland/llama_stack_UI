# Llama Stack UI Helm Chart

This Helm chart deploys the Llama Stack UI application on OpenShift, including both the client and server components.

## Prerequisites

- OpenShift 4.x or higher
- Helm 3.x

## Installation

```bash
# Add the repository (if hosted)
# helm repo add llama-stack-ui <repository-url>
# helm repo update

# Install the chart
helm install llama-stack-ui ./helm/llama-stack-ui
```

## Configuration

The following table lists the configurable parameters of the Llama Stack UI chart and their default values.

### Global Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `global.nameOverride` | Override the name of the chart | `""` |
| `global.fullnameOverride` | Override the full name of the chart | `""` |

### Client Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `client.replicaCount` | Number of client replicas | `1` |
| `client.image.repository` | Client image repository | `llama-stack-ui-client` |
| `client.image.tag` | Client image tag | `latest` |
| `client.image.pullPolicy` | Client image pull policy | `IfNotPresent` |
| `client.service.type` | Client service type | `ClusterIP` |
| `client.service.port` | Client service port | `80` |
| `client.route.enabled` | Enable OpenShift route for client | `true` |
| `client.route.host` | Client route hostname | `""` |
| `client.route.path` | Client route path | `/` |
| `client.route.tls.enabled` | Enable TLS for client route | `true` |
| `client.route.tls.termination` | TLS termination type | `edge` |

### Server Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `server.replicaCount` | Number of server replicas | `1` |
| `server.image.repository` | Server image repository | `llama-stack-ui-server` |
| `server.image.tag` | Server image tag | `latest` |
| `server.image.pullPolicy` | Server image pull policy | `IfNotPresent` |
| `server.service.type` | Server service type | `ClusterIP` |
| `server.service.port` | Server service port | `54243` |
| `server.route.enabled` | Enable OpenShift route for server | `true` |
| `server.route.host` | Server route hostname | `""` |
| `server.route.path` | Server route path | `/api` |
| `server.route.tls.enabled` | Enable TLS for server route | `true` |
| `server.route.tls.termination` | TLS termination type | `edge` |

## Security Context

The chart is configured to run with OpenShift's security context constraints. The default values are:

```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1000680000
  fsGroup: 1000680000
```

## Example Values File

```yaml
client:
  route:
    host: ui.example.com
    tls:
      enabled: true

server:
  route:
    host: api.example.com
    tls:
      enabled: true
  env:
    - name: NODE_ENV
      value: production
```

## Upgrading

```bash
helm upgrade llama-stack-ui ./helm/llama-stack-ui
```