#!/bin/bash
echo "🚀 Deploying to Local Minikube..."

# Check if Minikube is running
if ! minikube status >/dev/null 2>&1; then
    echo "Starting Minikube..."
    minikube start
    minikube addons enable ingress
fi

# Set Docker environment to use Minikube's Docker
eval $(minikube docker-env)

echo "📦 Building Docker images locally..."
docker build -t anupsharma329/backend:local ./backend
docker build -t anupsharma329/frontend:local ./frontend

echo "⚙️ Deploying to Kubernetes..."
kubectl apply -f k8s/

echo "⏳ Waiting for deployment to complete..."
kubectl rollout status deployment/backend-deployment -n fullstack-app --timeout=180s
kubectl rollout status deployment/frontend-deployment -n fullstack-app --timeout=180s

echo "🌐 Application URLs:"
echo "Minikube IP: $(minikube ip)"
echo "Frontend: http://$(minikube ip):30000"  # Adjust port based on your service
echo "Backend API: http://$(minikube ip):30001"
echo ""
echo "🎯 Quick commands:"
echo "  minikube service frontend-svc -n fullstack-app --url"
echo "  kubectl get all -n fullstack-app"
echo "  kubectl logs -n fullstack-app deployment/frontend-deployment"

echo "✅ Local deployment complete!"