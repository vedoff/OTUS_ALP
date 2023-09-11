#!/bin/bash
# Устанавливаем docker
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker
sudo systemctl enable docker

# Устанавливаем docker-compose
mkdir -p /home/vagrant/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -o /home/vagrant/.docker/cli-plugins/docker-compose
chmod +x /home/vagrant/.docker/cli-plugins/docker-compose
ln -s /home/vagrant/.docker/cli-plugins/docker-compose /usr/local/bin/docker-compose
docker compose version
# Добавляем пользователя в группу docker что бы под ним запускать контейнеры.

