#!/bin/bash
apt update -y
apt install -y docker.io 

# CRITICAL: Increase Virtual Memory for Elasticsearch (Required for SonarQube)
sysctl -w vm.max_map_count=262144
echo "vm.max_map_count=262144" >> /etc/sysctl.conf

# Create volume for persistence
docker volume create sonar-data

# Run SonarQube (Port 9000)
docker run -d -p 9000:9000 -v sonar-data:/opt/sonarqube/data --name sonar-server sonarqube:lts-community
