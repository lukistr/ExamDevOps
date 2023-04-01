# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    
  config.ssh.insert_key = false
  config.vm.box="luki_strike/Exam"
#	config.vm.box_version = "1.1"
  config.vm.synced_folder ".", "/vagrant"
  config.vm.provision "shell", path: "add_hosts.sh"


  config.vm.define "pipeline" do |pipeline|
    pipeline.vm.box_version = "1.1"
    pipeline.vm.hostname = "pipeline.do1.exam"
    pipeline.vm.provider :virtualbox do |v|
			v.memory = 2048
			v.cpus = 1
		end
    pipeline.vm.network "private_network", ip: "192.168.100.201"
    pipeline.vm.provision "shell", path: "node_exporter.sh"
    pipeline.vm.provision "shell", path: "install_jenkins.sh"
  end

  config.vm.define "containers" do |containers|
    containers.vm.box_version = "1.1"
    containers.vm.hostname = "containers.do1.exam"
    containers.vm.provider :virtualbox do |v|
			v.memory = 2048
			v.cpus = 1
		end
    containers.vm.network "private_network", ip: "192.168.100.202"
    containers.vm.provision "shell", path: "install_docker_debian.sh"
    containers.vm.provision "shell", path: "node_exporter.sh"
    containers.vm.provision "shell", path: "gitea.sh"
    containers.vm.provision "shell", inline: "sudo cp /vagrant/docker.json /etc/docker/daemon.json"
    containers.vm.provision "shell", inline: "sudo systemctl restart docker"
  end

  config.vm.define "monitoring" do |monitoring|
    monitoring.vm.box_version = "1.1"
    monitoring.vm.hostname = "monitoring.do1.exam"
    monitoring.vm.provider :virtualbox do |v|
			v.memory = 2048
			v.cpus = 1
		end
    monitoring.vm.network "private_network", ip: "192.168.100.203"
    monitoring.vm.provision "shell", path: "install_docker_debian.sh"
    monitoring.vm.provision "shell", inline: "docker compose -f /vagrant/docker-compose-monitoring.yml up -d"
  end 
end
