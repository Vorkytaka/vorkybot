#!/bin/bash

# Fail script if any command fails
set -e

# Configuration
DOCKER_USERNAME="vorkytaka"
IMAGE_NAME="vorkybot"
TAG="latest"
FULL_IMAGE_NAME="${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"

# Check if Docker username is provided
if [ -z "$DOCKER_USERNAME" ]; then
  echo "Error: Please set your Docker Hub username in the script."
  exit 1
fi

# Print what we're doing
echo "Building and pushing Docker image: ${FULL_IMAGE_NAME}"

# Navigate to project root directory (assuming this script is in tools/)
cd "$(dirname "$0")/.."

# Build the Docker image for Linux/amd64 (x64) architecture
echo "Building Docker image for Linux/amd64 architecture..."
docker buildx create --name vorkybot-builder --use --platform linux/amd64 || true
docker buildx build --platform linux/amd64 --push=false -t ${FULL_IMAGE_NAME} --load .

# Check if user is logged into Docker Hub
echo "Checking Docker login status..."
if ! docker info 2>/dev/null | grep -q "Username"; then
  echo "You're not logged into Docker Hub. Please enter your credentials:"
  docker login
fi

# Push the image to Docker Hub using buildx
echo "Pushing image to Docker Hub..."
docker buildx build --platform linux/amd64 --push -t ${FULL_IMAGE_NAME} .

# Clean up the builder
docker buildx rm vorkybot-builder || true

echo "Successfully built and pushed ${FULL_IMAGE_NAME} to Docker Hub!"
echo "The image is built for Linux/amd64 architecture and can be used on your Ubuntu server."
