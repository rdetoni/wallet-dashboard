#!/bin/bash
set -x
# Set your remote server's SSH details
SSH_USER="admin"
SSH_HOST="192.168.0.43"

#delete folders that are not going to be used
rm -r dashboard/build
rm -r dashboard/node_modules

#Put the whole project on a tar file
tar -zcvf dashboard.tar.gz dashboard

#Send project to PI
scp dashboard.tar.gz $SSH_USER@$SSH_HOST:/home/admin/docker-images

# SSH into the remote server
ssh $SSH_USER@$SSH_HOST << EOF
	set -x
	
	# Extract project contents
	tar -xvzf /home/admin/docker-images/dashboard.tar.gz -C /home/admin/docker-images/
	
    # Build the Docker image
	cd /home/admin/docker-images/dashboard
	docker build -t wallet_dashboard:latest -f Dockerfile .
		
    # Optionally, push the image to a Docker registry
    # docker push your-registry-url/$IMAGE_NAME

    # Run your Docker container
    docker run -d -p 3000:3000 wallet_dashboard:latest
EOF