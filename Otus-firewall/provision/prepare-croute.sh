#!/bin/bash

sudo echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
sudo echo "GATEWAY=10.10.10.1" >> /etc/sysconfig/network-scripts/ifcfg-eth1
sudo echo "net.ipv4.conf.all.forwarding=1" >> /etc/sysctl.conf
sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sudo sysctl -p
sudo systemctl restart network
sudo ip route delete default
sudo ip route add default via 10.10.10.1
