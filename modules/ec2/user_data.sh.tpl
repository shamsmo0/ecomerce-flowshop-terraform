#!/bin/bash
set -e

yum update -y
yum install -y docker unzip

systemctl start docker
systemctl enable docker

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

aws ecr get-login-password --region ${aws_region} | \
  docker login --username AWS --password-stdin ${ecr_repository_url}

docker pull ${ecr_repository_url}:latest

docker run -d \
  --name shopflow-app \
  --restart always \
  -p 8080:80 \
  ${ecr_repository_url}:latest
