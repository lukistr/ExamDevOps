#!/bin/bash

echo "* Add Docker’s official GPG key ..."
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "* Set up the repository ..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
echo "* Change permision for docker.gpg ..."
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "* Install Docker ..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "* Start Docker service"
sudo service docker start
sudo service docker enable
sudo service docker restart

echo "* Add user vagrant to docker ..."
usermod -aG docker vagrant