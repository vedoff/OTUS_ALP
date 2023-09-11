#!/bin/bash

sudo yum update -y

#=== Устанавливаем nfs-server

sudo yum install nfs-utils -y

#=== Запускаем службы. rpcbind only for nfs v3

sudo systemctl enable rpcbind
sudo systemctl enable nfs-server
sudo systemctl start rpcbind
sudo systemctl start nfs-server

#=== Конфигурируем firewalld
sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo systemctl is-enabled firewalld
sudo firewall-cmd --permanent --add-port=111/tcp
sudo firewall-cmd --permanent --add-port=20048/tcp
sudo firewall-cmd --permanent --zone=public --add-service=nfs
sudo firewall-cmd --permanent --zone=public --add-service=mountd
sudo firewall-cmd --permanent --zone=public --add-service=rpc-bind
sudo firewall-cmd --reload

#=== проверяем доступные версии протоколов nfs

sudo cat /proc/fs/nfsd/versions

#=== Создаем каталог для доступа

sudo mkdir -p /share-data/upload

#sudo pvcreate /dev/sdb
#sudo vgcreate vg-nfs /dev/sdb
#sudo lvcreate -l100%FREE -n lv-nfs vg-nfs
#sudo mkfs.ext4 -L nfsdata /dev/vg-nfs/lv-nfs
#sudo chmod o+w /etc/fstab
#sudo echo "LABEL=nfsdata /share-data/ ext4 defaults 0 0" >> /etc/fstab
#sudo chmod o-w /etc/fstab
#sudo mount -a
#sudo mkdir -p /share-data/upload

#=== Создаем пользователя для nfs
 
sudo groupadd nfs -g 1100
sudo useradd -u 1100 -g 1100 -m -s /bin/bash nfsuser
sudo chown :nfs /share-data/upload && sudo chmod g+w /share-data/upload
sudo echo ""/share-data/upload" 192.168.56.101(rw,sync,no_root_squash,no_all_squash,anonuid=1100,anongid=1100)" >> /etc/exports
sudo exportfs -ra
sudo systemctl restart nfs-server
sudo showmount -e


