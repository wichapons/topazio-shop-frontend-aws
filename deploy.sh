#!/bin/bash

# Topazio Shop Frontend Deployment Script
# Usage: ./deploy.sh

APP_NAME="topazio-shop"
IMAGE_NAME="topazio-shop-frontend"
PORT="80"

echo "Starting full deployment of Topazio Shop Frontend..."

echo "Setting up fresh Amazon Linux 2 EC2 instance..."
echo "Updating system..."
sudo yum update -y

echo "Installing Docker..."
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

echo "Installing Git..."
sudo yum install -y git

echo "Installing useful tools..."
sudo yum install -y nano wget curl htop

echo "Installing SSL certificate tools..."
sudo yum install -y certbot

echo "Waiting for system to be ready after setup..."
sleep 5

echo "Building Docker image..."
sudo docker build -t $IMAGE_NAME .

echo "Stopping existing container (if any)..."
sudo docker stop $APP_NAME 2>/dev/null || true
sudo docker rm $APP_NAME 2>/dev/null || true

echo "Running new container..."
sudo docker run -d --name $APP_NAME --restart unless-stopped -p $PORT:80 $IMAGE_NAME

echo ""
echo "Full deployment completed!"
echo "Container started on port $PORT"
echo ""
echo "You can check status with:"
echo "  sudo docker ps | grep $APP_NAME"
echo "  sudo docker logs $APP_NAME"