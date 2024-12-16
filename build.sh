#!/bin/bash
IMAGE_NAME="customdocker-web"
IMAGE_TAG="latest"

echo "Building Docker image: $IMAGE_NAME:$IMAGE_TAG..."

# Build the Docker image using the pre-built 'build/' directory
docker build -t $IMAGE_NAME:$IMAGE_TAG .
