#!/bin/bash

# Чистим таблицы
sudo iptables -t nat -F
# Добавляем логирование для првала
sudo iptables -t nat -A PREROUTING -p tcp -d 10.10.10.3 --dport 8080 -j LOG --log-prefix "IPTABLES LOG: "
# Добавляем правило проброса порта с 10.10.10.3 port 8080 на 10.10.10.2 port 80
sudo iptables -t nat -A PREROUTING -p tcp -d 10.10.10.3 --dport 8080 -j DNAT --to-destination 10.10.10.2:80

# Добавляем логирование для првала
sudo iptables -t nat -A POSTROUTING -p tcp -d 10.10.10.2 --dport 80 -j LOG --log-prefix "IPTABLES LOG: "
# Добавляем правило SNAT которое подменяет адрес отправителя на адрес маршрутизатора.
sudo iptables -t nat -A POSTROUTING -p tcp -d 10.10.10.2 --dport 80 -j SNAT --to-source 10.10.10.3:8080
