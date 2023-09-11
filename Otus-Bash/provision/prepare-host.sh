#!/bin/bash

# устанавливаем консольный почтовый клиент 
sudo yum install mailx -y
# Правим права на конфиг файл postfix
sudo chmod o+w /etc/postfix/main.cf
# Устанавливаем использования протокола для сети ipv4
sed -i 's/inet_protocols = all/inet_protocols = ipv4/' /etc/postfix/main.cf
sudo chmod o-w /etc/postfix/main.cf
# Перезапускаем службу postfix
sudo systemctl restart postfix
# Устанавливаем расписание проверки лога для root
sudo crontab /vagrant/provision/cron-file.txt
# Даем права на исполнения скрипта
sudo chmod +x /vagrant/provision/readlog.sh
# Первичная обработка лога
bash /vagrant/provision/readlog.sh
