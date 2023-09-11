#!/bin/bash

sudo iptables -t nat -A POSTROUTING ! -d 192.168.0.0/16 -o eth0 -j MASQUERADE
sudo ip r add 192.168.0.0/16 via 10.10.10.2
sudo echo "net.ipv4.conf.all.forwarding=1" >> /etc/sysctl.conf
sudo sysctl -p