# travel-site Helm Chart

Helm chart for deploying the travel-site application (frontend + backend) to Amazon EKS.

## Components

- **Frontend** - React application served via nginx on port 80
- **Backend** - Node.js Express API on port 4000

## Install

```bash
# Development
helm install travel-site ./helm -f helm/values.yaml -f helm/values-dev.yaml

# Production
helm install travel-site ./helm -f helm/values.yaml -f helm/values-prod.yaml
```

## Upgrade

```bash
helm upgrade travel-site ./helm -f helm/values.yaml -f helm/values-prod.yaml
```

## Configuration

See `values.yaml` for all configurable parameters. Environment-specific overrides
are in `values-dev.yaml` and `values-prod.yaml`.

### Key Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `frontend.replicaCount` | Frontend replicas | `2` |
| `backend.replicaCount` | Backend replicas | `2` |
| `ingress.host` | Ingress hostname | `travel-site.example.com` |
| `ingress.tls.enabled` | Enable TLS | `false` |
| `serviceAccount.irsaRoleArn` | IAM role ARN for IRSA | `""` |
| `secret.dbPassword` | Database password | `CHANGE_ME` |
| `secret.apiKey` | API key | `CHANGE_ME` |
