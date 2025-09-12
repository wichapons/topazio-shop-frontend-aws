#!/bin/bash

# Topazio Shop Frontend Deployment Script
# Usage: ./deploy.sh [setup|build|run|stop|restart|logs|clean|deploy|status]

APP_NAME="topazio-shop"
IMAGE_NAME="topazio-shop-frontend"
PORT="80"

case "$1" in
    setup)
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
        
        echo ""
        echo "Setup completed!"
        echo "IMPORTANT: Please logout and login again (or reboot) for Docker group changes to take effect:"
        echo "  sudo reboot"
        echo ""
        echo "After reboot, verify with:"
        echo "  docker --version"
        echo "  docker run hello-world"
        ;;
    
    build)
        echo "Building Docker image..."
        docker build -t $IMAGE_NAME .
        echo "Build completed!"
        ;;
    
    run)
        echo "Stopping existing container (if any)..."
        docker stop $APP_NAME 2>/dev/null || true
        docker rm $APP_NAME 2>/dev/null || true
        
        echo "Running new container..."
        docker run -d --name $APP_NAME --restart unless-stopped -p $PORT:80 $IMAGE_NAME
        echo "Container started on port $PORT"
        ;;
    
    stop)
        echo "Stopping container..."
        docker stop $APP_NAME
        echo "Container stopped"
        ;;
    
    restart)
        echo "Restarting container..."
        docker restart $APP_NAME
        echo "Container restarted"
        ;;
    
    logs)
        echo "Showing container logs..."
        docker logs -f $APP_NAME
        ;;
    
    clean)
        echo "Cleaning up..."
        docker stop $APP_NAME 2>/dev/null || true
        docker rm $APP_NAME 2>/dev/null || true
        docker rmi $IMAGE_NAME 2>/dev/null || true
        echo "Cleanup completed"
        ;;
    
    deploy)
        echo "Full deployment: build and run..."
        $0 build
        $0 run
        echo "Deployment completed!"
        ;;
    
    status)
        echo "Container status:"
        docker ps | grep $APP_NAME || echo "Container not running"
        ;;
    
    *)
        echo "Usage: $0 {setup|build|run|stop|restart|logs|clean|deploy|status}"
        echo ""
        echo "Commands:"
        echo "  setup   - Install required software on fresh Amazon Linux 2 EC2"
        echo "  build   - Build Docker image"
        echo "  run     - Run container"
        echo "  stop    - Stop container"
        echo "  restart - Restart container"
        echo "  logs    - Show container logs"
        echo "  clean   - Remove container and image"
        echo "  deploy  - Build and run (full deployment)"
        echo "  status  - Show container status"
        echo ""
        echo "For fresh EC2 instance, run: $0 setup"
        exit 1
        ;;
esac