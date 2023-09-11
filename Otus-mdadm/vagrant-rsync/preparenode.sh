#!/bin/bash
mkdir -p $HOME/VirtualBoxHDD/VHDD
#sudo yum install qemu-img
#sudo apt install qemu-img
phdd=$HOME/VirtualBoxHDD/VHDD
qemu-img create -f vdi $phdd/vhdd-01.vdi 1G
qemu-img create -f vdi $phdd/vhdd-02.vdi 1G
qemu-img create -f vdi $phdd/vhdd-03.vdi 1G
qemu-img create -f vdi $phdd/vhdd-04.vdi 1G
