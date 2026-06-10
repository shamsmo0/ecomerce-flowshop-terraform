#!/bin/bash
set -e

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

yum update -y
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user

aws ecr get-login-password --region ${aws_region} | \
  docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com

docker pull ${ecr_repository_url}:backend-latest
docker run -d \
  --name shopflow-backend \
  --restart always \
  -p 5000:5000 \
  ${ecr_repository_url}:backend-latest

docker pull ${ecr_repository_url}:frontend-latest
docker run -d \
  --name shopflow-frontend \
  --restart always \
  -p 80:3000 \
  ${ecr_repository_url}:frontend-latest

sleep 5
docker ps
