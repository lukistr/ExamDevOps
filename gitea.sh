#!/bin/bash

echo "* Start Gitea server ..."
docker compose -f /vagrant/docker-compose.yml up -d

# Wait for Gitea server to start
until curl --silent --fail http://192.168.100.202:3000/ >/dev/null; do
    echo "Waiting for Gitea server to start..."
    sleep 10
done

# Gitea server is ready
echo "Gitea server is now running!"

echo "* Create admin user ..."
docker container exec -u 1000 gitea gitea admin user create --username vagrant --password docker --email vagrant@do1.lab

echo "* Clone github repo ..."
git clone https://github.com/shekeriev/fun-facts.git /home/vagrant/gitea

echo "* Add repo to gitea ..."
cd /home/vagrant/gitea && git add .

echo "* Commiting ..."
git commit -m "Build repo"

echo "* Push repo ..."
git push -o repo.private=false http://vagrant:docker@192.168.100.202:3000/vagrant/exam