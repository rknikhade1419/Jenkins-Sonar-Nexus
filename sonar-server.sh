/*#!/bin/bash  

###############################################################################################################
#                   Docker Installation
###############################################################################################################

# Add Docker's official GPG key:
# sudo apt-get update -y
# sudo apt-get install -y ca-certificates curl gnupg
# sudo install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# sudo chmod a+r /etc/apt/keyrings/docker.gpg

# # Add the repository to Apt sources:
# echo \
#   "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#   "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get update -y

# sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

apt update -y
apt install -y docker.io 

docker run -d -p 9000:9000 --name sonar-server sonarqube:latest*/
#!/bin/bash
# ... (Your Docker install steps) ...
apt update -y
apt install -y docker.io 
# CRITICAL: Increase Virtual Memory for Elasticsearch
sysctl -w vm.max_map_count=262144
echo "vm.max_map_count=262144" >> /etc/sysctl.conf

# Run SonarQube
docker run -d -p 9000:9000 --name sonar-server sonarqube:lts-community
