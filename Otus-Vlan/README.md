# Строим бонды и вланы
## Задание:
Строим бонды и вланы: в Office1 в тестовой подсети появляется сервера с доп интерфесами и адресами в internal сети testLAN

    testClient1 - 10.10.10.254
    testClient2 - 10.10.10.254
    testServer1- 10.10.10.1
    testServer2- 10.10.10.1

[Развести вланами](https://github.com/vedoff/bond-vlans/blob/main/README.md#%D0%B4%D0%BE%D1%8E%D0%B0%D0%B2%D0%B8%D0%BC-vlan-%D1%81%D0%BE%D0%B3%D0%BB%D0%B0%D1%81%D0%BD%D0%BE-%D1%81%D1%85%D0%B5%D0%BC%D0%B5): testClient1 <-> testServer1 testClient2 <-> testServer2

[Между centralRouter и inetRouter](https://github.com/vedoff/bond-vlans/blob/main/README.md#%D0%BA%D0%BE%D0%BD%D1%84%D0%B8%D0%B3%D1%83%D1%80%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-bond-%D0%B8%D0%BD%D1%82%D0%B5%D1%80%D1%84%D0%B5%D0%B9%D1%81%D0%BE%D0%B2): "пробросить" 2 линка (общая inernal сеть) и объединить их в бонд проверить работу c отключением интерфейсов.

# Схема сборки
![](https://github.com/vedoff/bond-vlans/blob/main/pict/Screenshot%20from%202022-04-07%2012-26-02.png)

# Выполнение:
### Развернем стенд
`vagrant up`
### Доюавим vlan согласно схеме
`ansible-play play-vlan.yml`
Вланы будут добавлены при помощи `nmcli` 
### Проверка (привожу конфиг без vlan):
![](https://github.com/vedoff/bond-vlans/blob/main/pict/Screenshot%20from%202022-04-07%2012-36-12.png)
![](https://github.com/vedoff/bond-vlans/blob/main/pict/Screenshot%20from%202022-04-07%2012-37-33.png)
![](https://github.com/vedoff/bond-vlans/blob/main/pict/Screenshot%20from%202022-04-07%2012-38-15.png)
![](https://github.com/vedoff/bond-vlans/blob/main/pict/Screenshot%20from%202022-04-07%2012-39-13.png)
### Проверка (привожу конфиг c vlan):
![](https://github.com/vedoff/bond-vlans/blob/main/pict/Screenshot%20from%202022-04-07%2012-48-27.png)
![](https://github.com/vedoff/bond-vlans/blob/main/pict/Screenshot%20from%202022-04-07%2012-50-11.png)

# Конфигурирование bond интерфейсов:
### Добавим бонд интерфейсы:
`ansible-play play-bond.yml` \
Способ №1 \
Бонд интерфейсы добавлены способом копирования конфига в файл, а также запрет контроля интерфейса NetworkManager. \
Способ №2 \
В конфигах ansible, указан так же способ вдобавления бондинга при помощи `nmcli` (NetworkManager)

![](https://github.com/vedoff/bond-vlans/blob/main/pict/Screenshot%20from%202022-04-07%2013-50-20.png)
![](https://github.com/vedoff/bond-vlans/blob/main/pict/Screenshot%20from%202022-04-07%2013-49-58.png)
![](https://github.com/vedoff/bond-vlans/blob/main/pict/Screenshot%20from%202022-04-09%2019-50-24.png)
![](https://github.com/vedoff/bond-vlans/blob/main/pict/Screenshot%20from%202022-04-09%2019-51-02.png)






