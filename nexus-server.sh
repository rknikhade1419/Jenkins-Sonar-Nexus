#!/bin/bash
apt update -y
apt install -y docker.io 

# Create volume for persistence
docker volume create nexus-data

# Run Nexus (Port 8081)
# Mapping internal /nexus-data to the docker volume
docker run -d -p 8081:8081 -v nexus-data:/nexus-data --name nexus-server sonatype/nexus3
