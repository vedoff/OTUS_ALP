# -*- mode: ruby -*-
# vim: set ft=ruby :
home = ENV['HOME']
ENV["LC_ALL"] = "en_US.UTF-8"


Vagrant.configure(2) do |config|
  #=================================== ВИРТУАЛЬНАЯ МАШИНА №1 ===============================

    config.vm.define "Router1" do |router1|
    # имя виртуальной машины
    router1.vm.box = 'debian11/v1230.1'
    router1.vm.provider "virtualbox" do |vb|
      vb.name = "Router1"
    end
    # hostname виртуальной машины
    router1.vm.hostname = "Router1"
    # настройки сети
    router1.vm.network "private_network", ip: "192.168.56.100"
    router1.vm.network "private_network", ip: "10.0.12.1", netmask: "255.255.255.252", virtualbox__intnet: "r1-r3"
    router1.vm.network "private_network", ip: "10.0.10.1", netmask: "255.255.255.252", virtualbox__intnet: "r1-r2"
    router1.vm.network "private_network", ip: "192.168.10.1", virtualbox__intnet: "net1"
    router1.vm.synced_folder ".", "/vagrant",  
          type: "rsync",
          rsync_auto: "true",
          rsync_exclude: [".git/",".vagrant/",".gitignore","Vagrantfile"]
          #router1.vm.provision "shell", path: "provision/prepare-iroute.sh"
    end

  # ================================== ВИРТУАЛЬНАЯ МАШИНА №2 =================================
  
    config.vm.define "Router2" do |router2|
    # имя виртуальной машины
    router2.vm.box = 'debian11/v1230.1' 
    router2.vm.provider "virtualbox" do |vbc|
      vbc.name = "Router2"
    end
    # hostname виртуальной машины
    router2.vm.hostname = "Router2"
    # настройки сети
    router2.vm.network "private_network", ip: "192.168.56.101"
    router2.vm.network "private_network", ip: "10.0.11.2", netmask: "255.255.255.252", virtualbox__intnet: "r2-r3"
    router2.vm.network "private_network", ip: "10.0.10.2", netmask: "255.255.255.252", virtualbox__intnet: "r1-r2"
    router2.vm.network "private_network", ip: "192.168.20.1", virtualbox__intnet: "net2"
    router2.vm.synced_folder ".", "/vagrant",  
          type: "rsync",
          rsync_auto: "true",
          rsync_exclude: [".git/",".vagrant/",".gitignore","Vagrantfile"]
          #router2.vm.provision "shell", path: "provision/prepare-croute.sh"
    end

    # ================================= ВИРТУАЛЬНАЯ МАШИНА №3 ==================================

    config.vm.define "Router3" do |router3|
    # имя виртуальной машины
    router3.vm.box = 'debian11/v1230.1'
    router3.vm.provider "virtualbox" do |vbc|
      vbc.name = "Router3"
    end
    # hostname виртуальной машины
    router3.vm.hostname = "Router3"
    # настройки сети
    router3.vm.network "private_network", ip: "192.168.56.102"
    router3.vm.network "private_network", ip: "10.0.11.1", netmask: "255.255.255.252", virtualbox__intnet: "r2-r3"
    router3.vm.network "private_network", ip: "10.0.12.2", netmask: "255.255.255.252", virtualbox__intnet: "r1-r3"
    router3.vm.network "private_network", ip: "192.168.30.1", virtualbox__intnet: "net3"
    router3.vm.synced_folder ".", "/vagrant",  
          type: "rsync",
          rsync_auto: "true",
          rsync_exclude: [".git/",".vagrant/",".gitignore","Vagrantfile"]
          #router3.vm.provision "shell", path: "provision/prepare-croute.sh"
    end
# ssh-pub add in server
  config.vm.provision "shell", inline: <<-SHELL
  cat /vagrant/provision/vagrant-key.pub >> /home/vagrant/.ssh/authorized_keys
  SHELL

end

