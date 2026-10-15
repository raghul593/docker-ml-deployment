
#!/bin/bash
set -e

APP_DIR="/opt/docker-web-app"
IMAGE_NAME="aws-docker-web"
CONTAINER_NAME="aws-web-container"

cd "$APP_DIR"

# Stop and remove the previous container if it exists
if docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
    docker stop "$CONTAINER_NAME"
    docker rm "$CONTAINER_NAME"
fi

# Build the updated Docker image
docker build -t "$IMAGE_NAME:latest" .

# Start the new container
docker run -d \
    --name "$CONTAINER_NAME" \
    --restart unless-stopped \
    -p 80:80 \
    "$IMAGE_NAME:latest"

# Verify the running container
docker ps --filter "name=$CONTAINER_NAME"

# Test the website locally
curl --fail http://localhost/
