# OSPF
## Создать домашнюю сетевую лабораторию. Научится настраивать протокол OSPF в Linux-based системах.
1. Поднять три виртуалки.
2. Объединить поднять OSPF между машинами на базе FRR.
3. Изобразить ассиметричный роутинг.
4. Сделать один из линков "дорогим", но что бы при этом роутинг был симметричным.

# Схема
![](https://github.com/vedoff/ospf/blob/main/pict/Screenshot%20from%202022-03-19%2019-32-16.png)

# Выполнение:
### Разворачиваем стенд и настраиваем настраиваем OSPF на маршрутизаторх.
`vagrant up && ansible-play play.yml`

Получим следующее после развертывания:

![](https://github.com/vedoff/ospf/blob/main/pict/Screenshot%20from%202022-03-19%2011-57-57.png)

![](https://github.com/vedoff/ospf/blob/main/pict/Screenshot%20from%202022-03-19%2012-02-23.png)

## Ассиметричный роутинг
Так как при развертывнии было сразу прописана на все роутеры проверка маршрута источника\
`/etc/sysctl.conf` \
`net.ipv4.conf.all.rp_filter=0` 

Параметры:
- `net.ipv4.conf.all.rp_filter=0` - отключение проверки маршрута источника (интерфейс будет пропускать обратный ответ от интерфейса из другой сети)
- `net.ipv4.conf.all.rp_filter=1` - строгая проверка маршрута источника (интерфейс не будет пропускать обратный ответ от интерфейса из другой сети)
- `net.ipv4.conf.all.rp_filter=2` - не строгая проверка маршрута источника 

 -  Изменяем вес интерфейса на ройутере: \
    `Router1:`
     - `vtysh`
     - `con t`
     - `int eth3`
     - `ip ospf cost 1000`
     - `sh ip route ospf`

### Проверяем:
Запускаем пинг `Router1 -> Router2`\
`ping I 192.168.10.1 192.168.20.1 \
Видим, что маршрут до сети 192.168.20.0/30 теперь пойдёт через router2, но обратный трафик от router2 пойдёт по другому пути.
### Конфигурация роутеров:
![](https://github.com/vedoff/ospf/blob/main/pict/Screenshot%20from%202022-03-21%2014-38-14.png)

![](https://github.com/vedoff/ospf/blob/main/pict/Screenshot%20from%202022-03-21%2015-01-38.png)

![](https://github.com/vedoff/ospf/blob/main/pict/Screenshot%20from%202022-03-21%2015-02-24.png)

Видим что eth2 порт только получает ICMP-трафик с адреса 192.168.10.1 \
А так же eth3 порт только отправляет ICMP-трафик на адрес 192.168.10.1

![](https://github.com/vedoff/ospf/blob/main/pict/Screenshot%20from%202022-03-21%2015-30-24.png)

## Симетричный роутинг
Так как при развертывнии было сразу прописана на все роутеры проверка маршрута источника\
`/etc/sysctl.conf` \
`net.ipv4.conf.all.rp_filter=0` \
Заходим на `Router1` и `Router2` изменяем: 
 - `net.ipv4.conf.all.rp_filter=0` на `net.ipv4.conf.all.rp_filter=1`
 -  Изменяем вес интерфейса на ройутерах: \
    `Router1 / Router2:`
     - `vtysh`
     - `con t`
     - `int eth3`
     - `ip ospf cost 1000`
     - `sh ip route ospf`
  
  ## Было:
  ![](https://github.com/vedoff/ospf/blob/main/pict/Screenshot%20from%202022-03-19%2019-56-48.png)
  
  ## Стало:
  ![](https://github.com/vedoff/ospf/blob/main/pict/Screenshot%20from%202022-03-19%2019-57-49.png)
  
  ## Трассировка при включеных параметрах
  ![](https://github.com/vedoff/ospf/blob/main/pict/Screenshot%20from%202022-03-19%2019-50-52.png)
  
  ![](https://github.com/vedoff/ospf/blob/main/pict/Screenshot%20from%202022-03-19%2019-52-11.png)
  
  
