#!/bin/bash

# Topazio Shop Frontend Deployment Script
# Usage: ./deploy.sh [build|run|stop|restart|logs|clean]

APP_NAME="topazio-shop"
IMAGE_NAME="topazio-shop-frontend"
PORT="80"

case "$1" in
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
        echo "Usage: $0 {build|run|stop|restart|logs|clean|deploy|status}"
        echo ""
        echo "Commands:"
        echo "  build   - Build Docker image"
        echo "  run     - Run container"
        echo "  stop    - Stop container"
        echo "  restart - Restart container"
        echo "  logs    - Show container logs"
        echo "  clean   - Remove container and image"
        echo "  deploy  - Build and run (full deployment)"
        echo "  status  - Show container status"
        exit 1
        ;;
esac