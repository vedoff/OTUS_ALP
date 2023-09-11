# ansible
Изучение технологии ansible на примере развертывания nginx

## Задание
Подготовить стенд на Vagrant как минимум с одним сервером. На этом сервере используя Ansible необходимо развернуть nginx со следующими условиями:

   - необходимо использовать модуль yum/apt;
   - конфигурационные файлы должны быть взяты из шаблона jinja2 с перемененными;
   - после установки nginx должен быть в режиме enabled в systemd;
   - должен быть использован notify для старта nginx после установки;
   - сайт должен слушать на нестандартном порту - 8080, для этого использовать переменные в Ansible.
 
   ## Как это работает
   - Если не требуется проверка ssh-key то в ansible.cfg выставляем переменую "host_key_checking  = False"
   - Если тербуется проверка ssh-key то:
     > - Добавить ssh-key.pub в папку provision в корне проекта.
     > - Изменить значение пременной "host_key_checking  = true" в ansible.cfg
   - Стенд развернет две Linux системы Centos и Debian.
   - Установит на них nginx, в зависимости от системы будут применены соответствующие параметры установки.
   - При установке используются роли и шаблоны J2.
   - Tasks разделен на файлы и импортирован дерективой import_tasks
   - При конфигурировании nginx используется шаблон. Сайт по умолчанию поднимается на пору 8080
   - Добавлен виртуальный домен и шаблон сайта в соответствующую папку. Шаблон сайта добавлен при помощи модуля copy. \
      Виртуальный домен отвечает на порту 8088.
   - Добавлены перемнные в default/main.yml 
   - Переменные vars/Debian.yml vars/RedHat.yml - вызываются и переопределяются согласно шаблону переменной ansible_os_family
   - Используется переопределение переменной для порта сайта виртуального домена в vars/main.yml
   - Добавлены мета данные. В метаданных используется зависимость от роли, а также на каких системах протестировано.
   - Использование роли доступно отдельно от стенда:
      > - для этого требуется добавить ключ ssh-key.pub удаленного сервера на который требуется установка.
      > - использовать пользователя сервера.
      > - добавить адрес сервера в hosts
   
   ### Запуск стенда
   
   vagrant up && ansible-playbook play.yaml
   
   ### Проверка
   vagrant ssh server-01-centos \
   vagrant ssh server-02-debian
   - Проверка портов и enabled nginx\
   sudo ss -tunlp \
   sudo systemctl is-enabled nginx
   - Проверка доступа сайта \
   http://192.168.56.211:8088 \
   http://192.168.56.214:8088
### Полезно:
https://docs.ansible.com/ansible/latest/user_guide/index.html \
https://ansible-for-network-engineers.readthedocs.io/ru/latest/book/01_basics/index.html \
https://docs.ansible.com/ansible/latest/collections/ansible/builtin/systemd_module.html \
https://d2c.io/ru/article/how-to/rasshiryaem-funkcional-ansible-s-pomoshhyu-plaginov-chast-1 \
http://onreader.mdl.ru/MasteringAnsible2nd/content/Ch01.html#03 \
https://galaxy.ansible.com/home
