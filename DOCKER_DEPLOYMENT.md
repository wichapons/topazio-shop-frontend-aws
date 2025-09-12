# Topazio Shop Frontend - Docker Deployment Guide

## Prerequisites

1. **AWS EC2 Instance**: Linux-based instance (Amazon Linux 2, Ubuntu, etc.)
2. **Docker**: Installed on your EC2 instance
3. **Security Group**: Configure to allow HTTP (port 80) and HTTPS (port 443) traffic

## Building and Running the Docker Container

### 1. Build the Docker Image

```bash
# Build the image
docker build -t topazio-shop-frontend .

# Or build with a specific tag
docker build -t topazio-shop-frontend:v1.0.0 .
```

### 2. Run the Container

```bash
# Run on port 80
docker run -d --name topazio-shop --restart unless-stopped -p 80:80 topazio-shop-frontend

# Or run on a different port (e.g., 3000)
docker run -d --name topazio-shop --restart unless-stopped -p 3000:80 topazio-shop-frontend
```

### 3. Verify the Deployment

```bash
# Check if container is running
docker ps

# Check logs
docker logs topazio-shop

# Test the application
curl http://localhost
```

## AWS EC2 Deployment Steps

### 1. Set up EC2 Instance

1. Launch an Amazon Linux 2 or Ubuntu EC2 instance
2. Configure Security Group:
   - HTTP (80) - 0.0.0.0/0
   - HTTPS (443) - 0.0.0.0/0
   - SSH (22) - Your IP only

### 2. Install Docker on EC2

**For Amazon Linux 2:**
```bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
```

**For Ubuntu:**
```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ubuntu
```

### 3. Deploy the Application

**Option A: Build on EC2**
```bash
# Clone your repository
git clone https://github.com/wichapons/topazio-shop-frontend-aws.git
cd topazio-shop-frontend-aws

# Build and run
docker build -t topazio-shop-frontend .
docker run -d --name topazio-shop --restart unless-stopped -p 80:80 topazio-shop-frontend
```

**Option B: Push to Registry and Pull**
```bash
# Tag and push to registry (Docker Hub, ECR, etc.)
docker tag topazio-shop-frontend:latest your-registry/topazio-shop-frontend:latest
docker push your-registry/topazio-shop-frontend:latest

# On EC2, pull and run
docker pull your-registry/topazio-shop-frontend:latest
docker run -d --name topazio-shop --restart unless-stopped -p 80:80 your-registry/topazio-shop-frontend:latest
```

## Environment Variables (if needed)

If your application requires environment variables, create a `.env` file and use it:

```bash
docker run -d --name topazio-shop --restart unless-stopped -p 80:80 --env-file .env topazio-shop-frontend
```

## SSL/HTTPS Setup (Recommended for Production)

### Using Let's Encrypt with Certbot

1. Install Certbot:
```bash
sudo yum install -y certbot  # Amazon Linux
# or
sudo apt install -y certbot  # Ubuntu
```

2. Get SSL certificate:
```bash
sudo certbot certonly --standalone -d your-domain.com
```

3. Update nginx configuration to use SSL and run on port 443

## Monitoring and Maintenance

### Useful Docker Commands

```bash
# View logs
docker logs topazio-shop

# Restart container
docker restart topazio-shop

# Stop container
docker stop topazio-shop

# Remove container
docker rm topazio-shop

# View resource usage
docker stats topazio-shop

# Execute commands in running container
docker exec -it topazio-shop sh
```

### Health Check

```bash
# Add this to your nginx.conf if you want a health check endpoint
location /health {
    access_log off;
    return 200 "healthy\n";
    add_header Content-Type text/plain;
}
```

## Troubleshooting

1. **Container not starting**: Check logs with `docker logs topazio-shop`
2. **Port conflicts**: Use different port mapping `-p 8080:80`
3. **Permission issues**: Ensure user is in docker group
4. **Build failures**: Check if all dependencies are properly installed

## Performance Optimization

1. **Enable gzip compression**: Already configured in nginx.conf
2. **Set proper cache headers**: Configured for static assets
3. **Use CDN**: Consider using CloudFront for better performance
4. **Monitor resources**: Use CloudWatch or similar monitoring tools