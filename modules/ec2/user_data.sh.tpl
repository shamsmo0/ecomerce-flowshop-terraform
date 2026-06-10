#!/bin/bash
set -e

yum update -y
yum install -y docker aws-cli

systemctl start docker
systemctl enable docker

aws ecr get-login-password --region ${aws_region} | \
  docker login --username AWS --password-stdin ${ecr_repository_url}

docker pull ${ecr_repository_url}:latest

docker run -d \
  --name shopflow-app \
  --restart always \
  -p 8080:80 \
  ${ecr_repository_url}:latest
