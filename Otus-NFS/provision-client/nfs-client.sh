#!/bin/bash

sudo yum update -y

#=== Устанавливаем nfs-server

sudo yum install nfs-utils -y

#=== Запускаем службы. rpcbind only for nfs v3

sudo systemctl enable rpcbind
sudo systemctl enable nfs-server
sudo systemctl start rpcbind
sudo systemctl start nfs-server

#=== проверяем доступные версии протоколов nfs

sudo cat /proc/fs/nfsd/versions

#=== Создаем каталог для доступа

sudo mkdir -p /share-data/

#=== Создаем пользователя для nfs
 
sudo groupadd nfs -g 1100
sudo useradd -u 1100 -g 1100 -m -s /bin/bash nfsuser
sudo chown :nfs /share-data/ && sudo chmod g+w /share-data/
sudo mount -t nfs -o vers=3 192.168.56.100:/share-data/upload/ /share-data
sudo echo "192.168.56.100:/share-data/upload/ /share-data/ nfs vers=3,rw,sync,hard,intr 0 0" >> /etc/fstab 
df -h

