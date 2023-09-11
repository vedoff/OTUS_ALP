#=== Устанавливаем необходимые пакеты 

sudo yum install -y wget rpm-build rpmdevtools gcc make openssl-devel zlib-devel pcre-devel tree yum-utils createrepo redhat-lsb-core

#=== Создаем пользователя для сборки

sudo useradd builder -m

sudo su - builder

#=== Создаем дерево каталогов для сборки

rpmdev-setuptree

#=== Качаем нужные пакеты для сборки

wget https://nginx.org/packages/mainline/centos/7/SRPMS/nginx-1.19.3-1.el7.ngx.src.rpm

wget https://www.openssl.org/source/old/1.1.1/openssl-1.1.1a.tar.gz

tar -xvf openssl-1.1.1a.tar.gz

#=== получаем исходники nginx все исходники распакуются в требуемые каталоги каталоги подготовленные ранее.

rpm -Uvh nginx-1.19.3-1.el7.ngx.src.rpm

cd rpmbuild/SPECS/

# Правим nginx.spec
#vi rpmbuild/SPECS/nginx.spec

sed -i 's!--with-openssl=/home/builder/openssl-1.1.1a!--with-debug!g' nginx.spec

#добавляем после %build
# ./configure
#--with-openssl=/root/openssl-1.1.1a

# -------------------------------------

#=== Собираем пакет nginx

rpmbuild -bb nginx.spec

exit

sudo -i
#=== Каталог куда собирется пакет

cd /home/builder/rpmbuild/RPMS/x86_64

ls -l

#=== Устанавливаем пакет nginx

rpm -Uvh nginx-1.19.3-1.el7.ngx.x86_64.rpm

systemctl status nginx
systemctl start nginx
systemctl status nginx

#=== Проверяем под каким именем пакет встал в систему =============

rpm -qa | grep nginx


#===================== Создание репозитория =========================
#---действия производим под root

mkdir /usr/share/nginx/html/repo

cp /home/builder/rpmbuild/RPMS/x86_64/nginx-1.19.3-1.el7.ngx.x86_64.rpm /usr/share/nginx/html/repo/

ls -l

#=== Создадим репозиторий

createrepo /usr/share/nginx/html/repo/










