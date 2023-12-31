# Пользователи и группы. Авторизация и аутентификация.

## Задание
1. Запретить всем пользователям, кроме группы admin логин в выходные (суббота и воскресенье), без учета праздников.
2. Дать конкретному пользователю права работать с докером и возможность рестартить докер сервис.
    > [будем использовать PolKit rules](https://github.com/vedoff/auth_user_group/blob/main/README.md#%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-2)

# Задание №1
## Как это работает
### Развернуть стенд запустив команду. Исполюзуется Ansible role и шаблоны J2.
    vagrant up
Будет развернут vagrant стенд с двумя машинами. Centos 7.9 server-auth и client с которго будет осуществлятся вход пользователей. \
В `vars` заданы переменные которые будут использоваться в шаблонах.

Переменные для доступа /etc/security/time.conf \
`service: '*' ` \
`ctty: '*' `\
`username: 'user1' `\
`dtime: '!Al0800-2000' ` - Логин пользователя запрещен с 8 утра до 8 вечера. \
[Продолжить](https://github.com/vedoff/auth_user_group/blob/main/README.md#%D0%BF%D1%80%D0%BE%D0%B4%D0%BE%D0%BB%D0%B6%D0%B0%D0%B5%D0%BC)
### Теория и примеры записи параметров в time.conf

Настроим PAM, так как по-умолчанию данный модуль не подключен. \
Для этого приведем файл /etc/pam.d/sshd к виду: \
`...` \
`account  required  pam_nologin.so` \
`account  required  pam_time.so` \
`...`

### Настройка времени доступа.

Теперь, когда служба PAM включена, нам остаётся только настроить время доступа к системе. Откройте каталог /etc/security. Здесь находятся несколько конфигурационных файлов:

`$ ls /etc/security/ access.conf namespace.conf pam_env.conf group.conf namespace.init time.conf limits.conf opasswd time.conf.bak`

Отредактируете файл `time.conf`. Чтобы настроить доступ, скопируйте и вставьте следующий код в конец файла:

`*;*;user;scheduler`

Вместо `user` введите логин того пользователя, которого нужно ограничить в доступе

Если вы хотите заблокировать несколько пользователей, введите их логины строку, разделеляя их этим символом `|`. Например, если я хочу заблокировать доступы у `Patrick, John and Emily`, то синтаксис будет такой:

`*;*;Patrick|jean|emilie;scheduler` 

Если вы хотите, чтобы заблокировать доступ к системе для всех пользователей, кроме определенных, используете символ `!`. Например, если я хочу запретить доступ к компьютеру для всех пользователей, кроме `Nicolas` и `Xavie`, синтаксис такой:

`Nicolas *;*;!|xavier;scheduler `

Обратимся теперь к полю временных зон. В этой области находится выбор дней и часов, когда будет разрешен доступ. Прежде всего, необходимо указать день недели, используя следующие сокращения:

`Mo : Monday Fr : Friday Wd : Sa/Su Tu : Tuesday Sa : Saturday wk : Mo/Tu/We/Th/Fr We : Wenesday Su : Sunday Th : Thursday Al : All Days `

Будьте внимательны и не путайте сокращений `Wk` и `Wd`!

Затем мы указываем сроки. Они должны быть отображены в 24 часовом формате, состоящим из 4 цифр. Например, чтобы ограничить 3:17 pm до 6:34 pm, мы пишем: 1517-1834. Чтобы разрешить Marie доступ только во вторник, с 3:17 pm до 6:34 pm, мы получим результат:

`*;*;marie;Tu1517-1834 `

Доступ вне этих часов будет запрещен. Что касается пользователей, то можно использовать операторы `|` и `!` чтобы указать несколько временных зон (индикатор `! `указывает, что все время входа допускается, за исключением того, которое будет показано).

Две звезды (символы) в начале строки кода. Так как вы хотите заблокировать доступ к системе, нет необходимости указывать, какие сервисы или терминалы вы хотите заблокировать. Однако, если вы хотите, чтобы предотвратить использование конкретного сервиса, просто укажите его в качестве следующего примера:

`login;tty1|tty4|tty5;marie;!Wd0000-2400`

Таким образом, пользователь Marry не может подключиться к терминалу, 4 и 5 в выходные дни.


Матильда может подключаться каждый день с 1:20 pm до 3:20 pm и с 4:00 pm до 8:30 pm:

`*;*;mathilde;Al1320-1520|Al1600-2030` 

Stone, Frank и Florian разрешено подключаться до 2:00 pm до 6:45 pm в будние дни и 2:00 pm до 10:15 pm на выходные:

`*;*;Stone|franck|florian;Wk1400-1845|Wd1400-2215` 

Olive никогда не позволено в доступе. jessica может войти в среду с 1:00 pm до 4:00 pm:

`*;*;olivier;!Al0000-2400 *;*;jessica;We1300-1600` 

### Продолжаем:
Добавим пользователя на сервер куда будем пытаться залогинется \
(пароль пользователя user1 в не зашифрованном виде `123456`) : 

`ansible-playbook add_users.yml`

Зайдем на клиента и попробуем залогинется на сервер.

`vagrant ssh client`

![](https://github.com/vedoff/auth_user_group/blob/main/pict/Screenshot%20from%202022-01-14%2018-05-50.png)

Доступ разрешен. \
Выйдем с сервера

Теперь выполним 

`ansible-playbook play-pam-time.yaml`

зайдем на клиента \
`vagrant ssh client` \
И повторно пробуем залогинется на сервер

![](https://github.com/vedoff/auth_user_group/blob/main/pict/Screenshot%20from%202022-01-14%2020-50-25.png)

Теперь доступ запрещен.

На стенде достаточно сменить параметры в `vars` и выполнить `ansible-playbook play-pam-time.yaml`, что бы поменять время доступа на сервер.
## Задание №1 для группы
Для реализации PAM для группы запустим: \
`ansible-playbook play-pam-script.yml`
### Как это работает
Шаблон `templ_sshd.j2` из `template` сконфигурирует правила `PAM` А именно, будет добавленно `pam_script.so` в файл `/etc/pam.d/sshd` \
На сервер `server-auth` будет скопирован скпирт `pam_script` в директорию `/etc/` , для реализации следующей логики: \
Все кто находится в группе admin смогут подключаться по ssh в любой день, остальные в любой день кроме выходных. \
В скрипт можно добавить несколько групп. \
Будут добавлены пользователи `user1` и `user2` если их нет на сервре, так же бедет заведена группа `admin` в которую поместим пользователя `user1`.

# Проверяем:
Логинимся на клиента \
`vagrant ssh client` \
Пытаемся залогинится на сервер `server-auth` \
`ssh user1@192.168.56.218` \
`ssh user2@192.168.56.218` 
### Логин проходит 
![](https://github.com/vedoff/auth_user_group/blob/main/pict/Screenshot%20from%202022-01-26%2020-11-46.png)

## Изменим скрипт:
### Было
![](https://github.com/vedoff/auth_user_group/blob/main/pict/Screenshot%20from%202022-01-26%2020-20-03.png)
### Стало
![](https://github.com/vedoff/auth_user_group/blob/main/pict/Screenshot%20from%202022-01-26%2020-20-22.png)

Эта конструкция говорит о том до какого дня можно логинится - это понедельник,вторник => `if [[ date +%u > 2 ]]` 

Эта с понедельника по пятницу => `if [[ date +%u > 5 ]]`

Выполним повторно \
`ansible-playbook play-pam-script.yml `

Логинимся на клиента \
`vagrant ssh client` \
Пытаемся залогинится на сервер `server-auth` 
### Логин проходит, так как пользователь состоит в группе `admin`
`ssh user1@192.168.56.218` 
### Логин заблокирован так как пользователь отсутствует в группе `admin` и не попадает под требуемый скоп дней недели.
`ssh user2@192.168.56.218` 

![](https://github.com/vedoff/auth_user_group/blob/main/pict/Screenshot%20from%202022-01-26%2020-28-23.png)

### Возвращаем скрипт в исходное состояние.

# Задание №2
Будем использовать PolKit rules 

### Демонстрация что это работает
Залогинимся под пользователем `user1` \
`vagrant ssh server-auth` \
`suso su - user1` \
Пробуем рестартануть сервис `docker` \
![](https://github.com/vedoff/auth_user_group/blob/main/pict/Screenshot%20from%202022-01-26%2021-01-21.png)

Разрешение на перезапуск сервиса `docker` отсутствует. 

Логинимся под пользователем `user2` \
`suso su - user2` \
Пробуем рестартануть сервис `docker` \
Так же рестарт сервиса запрещен \
Смотрим лог \
`cat /var/log/secure`

![](https://github.com/vedoff/auth_user_group/blob/main/pict/Screenshot%20from%202022-01-26%2014-41-40.png) \
Видим, что доступ на перезапуск сервиса `docker` запрещен для `user2`

## Выполним 
`ansible-playbook play-pam-service.yml` 
### Как это работает
На сервер `server-auth` будет скопировано правило `01-systemd.rules` в директорию `/etc/polkit-1/rules.d`

Данное правило дает право на запуск сервисов systemd для пользователя `user2`

`polkit.addRule(function(action, subject) { ` \
`if (action.id.match("org.freedesktop.systemd1.manage-units") &&` \
`subject.user === "user2") {` \
`return polkit.Result.YES;` \
`}` \
`});`

Повтрим перезапуск сервиса `docker` \
![](https://github.com/vedoff/auth_user_group/blob/main/pict/Screenshot%20from%202022-01-26%2021-02-49.png) 

Теперь все работает. Перезапуск сервиса `docker` для пользователя `user2` - Разрешено. Так же видно, что пользователь не состоит в группе `docker`

