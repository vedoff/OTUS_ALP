# -*- mode: ruby -*-
# vim: set ft=ruby :
home = ENV['HOME']
ENV["LC_ALL"] = "en_US.UTF-8"


Vagrant.configure(2) do |config|
  # ПЕРВАЯ ВИРТУАЛЬНАЯ МАШИНА
    config.vm.define "server-auth" do |server|
    # имя виртуальной машины
    server.vm.box = 'vedoff/centos-7-5' 
    server.vm.provider "virtualbox" do |vb|
      vb.name = "server-auth"
    end
    # hostname виртуальной машины
    server.vm.hostname = "server-auth"
    # настройки сети
    server.vm.network "private_network", ip: "192.168.56.218"
    server.vm.synced_folder ".", "/vagrant",  
          type: "rsync",
          rsync_auto: "true",
          rsync_exclude: [".git/",".vagrant/",".gitignore","Vagrantfile"]
          server.vm.provision "shell", path: "provision/prepare-host.sh"
  # ssh-pub add in server
#  config.vm.provision "shell", inline: <<-SHELL
#  cat /vagrant/ssh/vagrant-key.pub >> /home/vagrant/.ssh/authorized_keys
#  SHELL
      end
  end

  # ВТОРАЯ ВИРТУАЛЬНАЯ МАШИНА
  Vagrant.configure(2) do |config|
    config.vm.define "client" do |client|
    # имя виртуальной машины
    client.vm.box = 'vedoff/centos-7-5' 
    client.vm.provider "virtualbox" do |vbc|
      vbc.name = "client"
    end
    # hostname виртуальной машины
    client.vm.hostname = "client"
    # настройки сети
    client.vm.network "private_network", ip: "192.168.56.214"
  client.vm.synced_folder ".", "/vagrant",  
          type: "rsync",
         rsync_auto: "true",
         rsync_exclude: [".git/",".vagrant/",".gitignore","Vagrantfile"]
          #client.vm.provision "shell", path: "provision/prepare-host.sh"
# ssh-pub add in server
#  config.vm.provision "shell", inline: <<-SHELL
#  cat /vagrant/provision/vagrant-key.pub >> /home/vagrant/.ssh/authorized_keys
#  SHELL
    end
end