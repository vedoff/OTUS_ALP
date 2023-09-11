# -*- mode: ruby -*-
# vim: set ft=ruby :
home = ENV['HOME']
ENV["LC_ALL"] = "en_US.UTF-8"


Vagrant.configure(2) do |config|
  # ПЕРВАЯ ВИРТУАЛЬНАЯ МАШИНА
    config.vm.define "docker-server" do |server|
    # имя виртуальной машины
    server.vm.box = 'centos/7' 
    server.vm.provider "virtualbox" do |vb|
      vb.name = "docker-server"
    end
    # hostname виртуальной машины
    server.vm.hostname = "docker-server"
    # настройки сети
    server.vm.network "private_network", ip: "192.168.56.150"
    server.vm.synced_folder ".", "/vagrant",  
          type: "rsync",
          rsync_auto: "true",
          rsync_exclude: [".git/",".vagrant/",".gitignore","Vagrantfile"]
          server.vm.provision "shell", path: "provision/docker-build.sh"
          server.vm.provision "shell", inline: <<-SHELL
          cat /vagrant/provision/vagrant-key.pub >> /home/vagrant/.ssh/authorized_keys
          SHELL
    end
end
