#!/bin/bash

sudo iptables-restore < /etc/iptables/knock-iptables.rules
sudo service iptables save