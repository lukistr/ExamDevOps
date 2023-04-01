#!/bin/bash

echo "* Add hosts ..."
echo "192.168.100.201 pipeline.do1.exam pipeline" >> /etc/hosts
echo "192.168.100.202 containers.do1.exam containers" >> /etc/hosts
echo "192.168.100.203 monitoring.do1.exam monitoring" >> /etc/hosts

echo "* Install Software ..."
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y ca-certificates curl gnupg lsb-release tar bzip2 wget openjdk-17-jre groovy git tree

echo "* Firewall - open ports ..."
# Grafana container and Gitea
sudo ufw allow 3000
# Docker metrics
sudo ufw allow 9323
# http
sudo ufw allow 80
sudo ufw allow 8080
# Prometheus
sudo ufw allow 9090
# Node Exporter
sudo ufw allow 9100
# OpenSSH port 22
sudo ufw allow 22
sudo ufw disable && sudo ufw --force enable