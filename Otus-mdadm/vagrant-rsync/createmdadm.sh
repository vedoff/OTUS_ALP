#!/bin/bash
sudo yum install mdadm -y
#sudo wipefs --all --force /dev/sd{b,c,d,e}
sudo mdadm --create --verbose /dev/md0 --level=10 --raid-devices=4 /dev/sd{b,c,d,e}
sudo mdadm --detail --scan >> /etc/mdadm/mdadm.conf
sudo systemctl restart mdmonitor
sudo mdadm -D /dev/md0
sudo chmod o+w /etc/fstab
sudo mkdir /data-0{1,2,3,4,5}
sudo parted -a opt /dev/md0 mktable gpt
sudo parted -a opt /dev/md0 mkpart data01 ext4 0% 20% && sudo mkfs.ext4 -L data01 /dev/md0p1
sudo echo "LABEL=data01 /data-01 ext4 defaults 0 0" >> /etc/fstab
sudo parted -a opt /dev/md0 mkpart data02 ext4 20% 40% && sudo mkfs.ext4 -L data02 /dev/md0p2
sudo echo "LABEL=data02 /data-02 ext4 defaults 0 0" >> /etc/fstab
sudo parted -a opt /dev/md0 mkpart data03 ext4 40% 60% && sudo mkfs.ext4 -L data03 /dev/md0p3
sudo echo "LABEL=data03 /data-03 ext4 defaults 0 0" >> /etc/fstab
sudo parted -a opt /dev/md0 mkpart date04 ext4 60% 80% && sudo mkfs.ext4 -L data04 /dev/md0p4
sudo echo "LABEL=data04 /data-04 ext4 defaults 0 0" >> /etc/fstab
sudo parted -a opt /dev/md0 mkpart data05 ext4 80% 100% && sudo mkfs.ext4 -L data05 /dev/md0p5
sudo echo "LABEL=data05 /data-05 ext4 defaults 0 0" >> /etc/fstab
sudo mount -a
sudo chmod o-w /etc/fstab
sudo mdadm -D /dev/md0
df -h
