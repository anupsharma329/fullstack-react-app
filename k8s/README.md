# Kubernetes Deployment Guide

This directory contains all the Kubernetes manifests for deploying the fullstack React application.

## Prerequisites

- Kubernetes cluster (local or cloud)
- kubectl configured
- Docker images pushed to registry
- NGINX Ingress Controller installed

## File Structure

```
k8/
├── namespace.yaml          # Namespace definition
├── configmap.yaml          # Environment variables
├── backend-deployment.yaml # Backend deployment & service
├── frontend-deployment.yaml # Frontend deployment & service
├── ingress.yaml           # Ingress configuration
├── hpa.yaml              # Horizontal Pod Autoscalers
├── deploy.sh             # Deployment script
└── README.md             # This file
```

## Quick Deployment

1. **Build and push Docker images:**
   ```bash
   # Build images
   docker build -t anupsharma/backend:latest -f backend/Dockerfile.backend .
   docker build -t anupsharma/frontend:latest -f frontend/Dockerfile.frontend .
   
   # Push to registry
   docker push anupsharma/backend:latest
   docker push anupsharma/frontend:latest
   ```

2. **Deploy to Kubernetes:**
   ```bash
   cd k8
   ./deploy.sh
   ```

## Manual Deployment

If you prefer to deploy manually:

```bash
# Create namespace
kubectl apply -f namespace.yaml

# Apply ConfigMap
kubectl apply -f configmap.yaml

# Deploy backend
kubectl apply -f backend-deployment.yaml

# Deploy frontend
kubectl apply -f frontend-deployment.yaml

# Deploy ingress
kubectl apply -f ingress.yaml

# Deploy HPA
kubectl apply -f hpa.yaml
```

## Configuration

### Environment Variables
- `NODE_ENV`: Set to "production"
- `PORT`: Backend port (5001)
- `REACT_APP_API_URL`: Frontend API endpoint

### Resource Limits
- **Backend**: 128Mi-256Mi RAM, 100m-200m CPU
- **Frontend**: 64Mi-128Mi RAM, 50m-100m CPU

### Scaling
- **Min replicas**: 2 for both services
- **Max replicas**: 10 for both services
- **Auto-scaling**: Based on CPU (70%) and Memory (80%) utilization

## Monitoring

```bash
# Check deployment status
kubectl get pods -n fullstack-app

# Check services
kubectl get svc -n fullstack-app

# Check ingress
kubectl get ingress -n fullstack-app

# Check HPA
kubectl get hpa -n fullstack-app

# View logs
kubectl logs -f deployment/backend-deployment -n fullstack-app
kubectl logs -f deployment/frontend-deployment -n fullstack-app
```

## Troubleshooting

### Common Issues

1. **Images not found**: Ensure Docker images are pushed to registry
2. **Ingress not working**: Verify NGINX Ingress Controller is installed
3. **Health checks failing**: Check if `/health` endpoint exists in backend
4. **DNS resolution**: Update host in ingress.yaml to match your domain

### Useful Commands

```bash
# Describe resources for debugging
kubectl describe pod <pod-name> -n fullstack-app
kubectl describe service <service-name> -n fullstack-app
kubectl describe ingress app-ingress -n fullstack-app

# Port forward for local testing
kubectl port-forward svc/backend-svc 5001:5001 -n fullstack-app
kubectl port-forward svc/frontend-svc 3000:80 -n fullstack-app
```

## Cleanup

To remove all resources:

```bash
kubectl delete namespace fullstack-app
```

## Security Notes

- Update the host in `ingress.yaml` to your actual domain
- Consider adding SSL/TLS certificates
- Review and adjust resource limits based on your needs
- Consider using secrets for sensitive environment variables
