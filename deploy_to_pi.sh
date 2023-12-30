#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Set your remote server's SSH details
SSH_USER="your-ssh-username"
SSH_HOST="your-remote-server-ip"
SSH_PASSWORD="your-ssh-password"

# Set your Docker image details
IMAGE_NAME="your-docker-image-name"
DOCKERFILE_PATH="$SCRIPT_DIR/Dockerfile"

# Convert Windows path to WSL-compatible path if running on Windows
if [[ $(uname -s) == MINGW* || $(uname -s) == CYGWIN* ]]; then
  DOCKERFILE_PATH=$(wslpath -u "$DOCKERFILE_PATH")
fi

# Build the Docker image
docker build -t $IMAGE_NAME -f $DOCKERFILE_PATH .

# Save the Docker image as a tar file
docker save -o image.tar $IMAGE_NAME

# Copy the image to the remote server
sshpass -p "$SSH_PASSWORD" scp image.tar $SSH_USER@$SSH_HOST:/path/to/remote/location

# SSH into the remote server
ssh $SSH_USER@$SSH_HOST << EOF
    # Load the Docker image
    docker load -i /path/to/remote/location/image.tar

    # Optionally, push the image to a Docker registry
    # docker push your-registry-url/$IMAGE_NAME

    # Run your Docker container
    docker run -d -p 3000:3000 $IMAGE_NAME
EOF
