# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.insert_key = false
  config.vm.box = 'centos/7'

  config.vm.provider :virtualbox do |v|
    v.name = 'JavaVulns'
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.synced_folder ".", "/vagrant"
  config.vm.network "private_network", ip: "192.168.10.10"
  config.vm.network "forwarded_port", guest: 8080, host: 8000

  config.vm.provision "init", privileged: true, type: "shell", inline: <<-SHELL
    # sudo yum update -y
    sudo yum -y install docker
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  SHELL

  config.vm.provision "run", type: "shell", inline: <<-SHELL
    cd /vagrant
    /usr/local/bin/docker-compose down
    /usr/local/bin/docker-compose build
    /usr/local/bin/docker-compose up -d javavulnlab mysql
  SHELL

 end
