#!/bin/bash
# Install Docker on CentOS

# Uninstall old versions
yum remove docker \
docker-client \
docker-client-latest \
docker-common \
docker-latest \
docker-latest-logrotate \
docker-logrotate \
docker-engine

# SET UP THE REPOSITORY
yum install -y yum-utils
yum-config-manager \
--add-repo \
https://download.docker.com/linux/centos/docker-ce.repo

# INSTALL DOCKER ENGINE
yum install -y docker-ce docker-ce-cli containerd.io

# Configure Docker to start on boot
systemctl enable docker.service
systemctl enable containerd.service

# Start Docker
systemctl start docker

# Verify
docker run --rm hello-world
