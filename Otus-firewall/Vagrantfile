# -*- mode: ruby -*-
# vim: set ft=ruby :
home = ENV['HOME']
ENV["LC_ALL"] = "en_US.UTF-8"

  # ========================================= InetRouter ========================================

Vagrant.configure(2) do |config|
    config.vm.define "inetRouter" do |server|
    # имя виртуальной машины
    server.vm.box = 'centos/7'
    server.vm.box_version = '1804.02'
    server.vm.provider "virtualbox" do |vb|
      vb.name = "inetRouter"
    end
    # hostname виртуальной машины
    server.vm.hostname = "inetRouter"
    # настройки сети
    server.vm.network "private_network", ip: "10.10.10.1", adapter: 2, netmask: "255.255.255.240", virtualbox__intnet: "router-net"
    server.vm.network "private_network", ip: "192.168.56.254",adapter: 3, netmask: "255.255.255.0"
    server.vm.synced_folder ".", "/vagrant",  
          type: "rsync",
          rsync_auto: "true",
          rsync_exclude: [".git/",".vagrant/",".gitignore","Vagrantfile"]
          server.vm.provision "shell", path: "provision/prepare-iroute.sh"
    end

  # ========================================= CentralRouter =====================================
    config.vm.define "centralRouter" do |client|
    # имя виртуальной машины
    client.vm.box = 'centos/7'
    client.vm.box_version = '1804.02' 
    client.vm.provider "virtualbox" do |vbc|
      vbc.name = "centralRouter"
    end
    # hostname виртуальной машины
    client.vm.hostname = "centralRouter"
    # настройки сети
    client.vm.network "private_network", ip: "10.10.10.2", adapter: 2, netmask: "255.255.255.240", virtualbox__intnet: "router-net"
    client.vm.network "private_network", ip: "192.168.70.2", adapter: 3, netmask: "255.255.255.0", virtualbox__intnet: "office"
    client.vm.network "private_network", ip: "192.168.56.200",adapter: 4, netmask: "255.255.255.0"
    client.vm.synced_folder ".", "/vagrant",  
          type: "rsync",
          rsync_auto: "true",
          rsync_exclude: [".git/",".vagrant/",".gitignore","Vagrantfile"]
          client.vm.provision "shell", path: "provision/prepare-croute.sh"
# ssh-pub add in server
  config.vm.provision "shell", inline: <<-SHELL
  cat /vagrant/provision/vagrant-key.pub >> /home/vagrant/.ssh/authorized_keys
  SHELL

    end
end

  # ========================================= InetRouter2 ===================================================

Vagrant.configure(2) do |iroute|
    iroute.vm.define "inetRouter2" do |iroute|
    # имя виртуальной машины
    iroute.vm.box = 'centos/7'
    iroute.vm.box_version = '1804.02'
    iroute.vm.provider "virtualbox" do |vb|
      vb.name = "inetRouter2"
    end
    # hostname виртуальной машины
    iroute.vm.hostname = "inetRouter2"
    # настройки сети
    iroute.vm.network "private_network", ip: "10.10.10.3", adapter: 2, netmask: "255.255.255.240", virtualbox__intnet: "router-net"
    iroute.vm.network "private_network", ip: "192.168.56.253",adapter: 3, netmask: "255.255.255.0"
    iroute.vm.synced_folder ".", "/vagrant",  
          type: "rsync",
          rsync_auto: "true",
          rsync_exclude: [".git/",".vagrant/",".gitignore","Vagrantfile"]
          iroute.vm.provision "shell", path: "provision/prepare-irouter2.sh"
          iroute.vm.provision "shell", path: "provision/add-forward.sh"
  # ssh-pub add in server
    iroute.vm.provision "shell", inline: <<-SHELL
    cat /vagrant/provision/vagrant-key.pub >> /home/vagrant/.ssh/authorized_keys
    SHELL

    end
end

# =========================================== Office ===================================================

Vagrant.configure(2) do |office|
    office.vm.define "office" do |office|
    # имя виртуальной машины
    office.vm.box = 'centos/7'
    office.vm.box_version = '1804.02'
    office.vm.provider "virtualbox" do |vb|
      vb.name = "office"
    end
    # hostname виртуальной машины
    office.vm.hostname = "office"
    # настройки сети
    office.vm.network "private_network", ip: "192.168.56.50",adapter: 3, netmask: "255.255.255.0"
    office.vm.network "private_network", ip: "192.168.70.10", adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "office"
    office.vm.synced_folder ".", "/vagrant",  
          type: "rsync",
          rsync_auto: "true",
          rsync_exclude: [".git/",".vagrant/",".gitignore","Vagrantfile"]
          office.vm.provision "shell", path: "provision/prepare-office.sh"
  # ssh-pub add in server
    office.vm.provision "shell", inline: <<-SHELL
    cat /vagrant/provision/vagrant-key.pub >> /home/vagrant/.ssh/authorized_keys
    SHELL

    end
end