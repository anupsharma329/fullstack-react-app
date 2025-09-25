#!/bin/bash

# Fullstack React App Kubernetes Deployment Script
set -e

echo "🚀 Starting Kubernetes deployment..."

# Create namespace
echo "📦 Creating namespace..."
kubectl apply -f namespace.yaml

# Apply ConfigMap
echo "⚙️  Applying ConfigMap..."
kubectl apply -f configmap.yaml

# Deploy backend
echo "🔧 Deploying backend..."
kubectl apply -f backend-deployment.yaml

# Deploy frontend
echo "🎨 Deploying frontend..."
kubectl apply -f frontend-deployment.yaml

# Deploy ingress
echo "🌐 Deploying ingress..."
kubectl apply -f ingress.yaml

# Deploy HPA
echo "📈 Deploying Horizontal Pod Autoscalers..."
kubectl apply -f hpa.yaml

# Wait for deployments to be ready
echo "⏳ Waiting for deployments to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/backend-deployment -n fullstack-app
kubectl wait --for=condition=available --timeout=300s deployment/frontend-deployment -n fullstack-app

echo "✅ Deployment completed successfully!"
echo ""
echo "📊 Deployment Status:"
kubectl get pods -n fullstack-app
echo ""
echo "🌐 Services:"
kubectl get svc -n fullstack-app
echo ""
echo "🔗 Ingress:"
kubectl get ingress -n fullstack-app
echo ""
echo "📈 HPA Status:"
kubectl get hpa -n fullstack-app
