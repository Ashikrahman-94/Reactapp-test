#!/bin/bash
IMAGE_NAME="customdocker-web"
IMAGE_TAG="latest"
SERVER_USER="ec2-user"
SERVER_ADDRESS="3.145.162.207"
CONTAINER_NAME="react-app"

echo "Copying image to server..."
docker save $IMAGE_NAME:$IMAGE_TAG | ssh $SERVER_USER@$SERVER_ADDRESS "docker load && docker stop $CONTAINER_NAME || true && docker rm $CONTAINER_NAME || true && docker run -d --name $CONTAINER_NAME -p 80:80 $IMAGE_NAME:$IMAGE_TAG"
echo "Deployment completed successfully."
