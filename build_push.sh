#!/bin/bash

# Set your AWS ECR repository name and region
ECR_REPO_NAME="ethis_interview_ecs"
AWS_REGION="US-EAST-1"
AWS_ACCOUNT_ID="381492145015"
IMAGE_TAG="latest"

# Build Docker image
docker build -t $ECR_REPO_NAME .

# Get the AWS ECR login command and execute it
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Tag the Docker image with ECR repository URI
IMAGE_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME:latest"
docker tag $ECR_REPO_NAME:latest $IMAGE_URI

# Push the Docker image to ECR
docker push $IMAGE_URI

echo "Docker image pushed to ECR: $IMAGE_URI"
