#!/bin/bash

sudo echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
sudo echo "GATEWAY=192.168.70.2" >> /etc/sysconfig/network-scripts/ifcfg-eth1
sudo sysctl -p
sudo systemctl restart network
sudo ip route delete default
sudo ip route add default via 192.168.70.2
