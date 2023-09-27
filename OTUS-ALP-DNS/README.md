# DNS
настраиваем свой кеширующий днс (мастер/слейв) со своей локальной зоной.
## Дано:
- взять стенд https://github.com/erlong15/vagrant-bind
- добавить еще один сервер client2
- завести в зоне dns.lab
    >имена \
    >web1 - смотрит на клиент1 \
    >web2 смотрит на клиент2
- завести еще одну зону newdns.lab
    >завести в ней запись \
    >www - смотрит на обоих клиентов
- настроить split-dns
    >клиент1 - видит обе зоны, но в зоне dns.lab только web1 \
    >клиент2 видит только dns.lab

## Проверка:
### Вывел все в скринах так нагляднее.
#### На первом клиенте
![](https://github.com/vedoff/DNS/blob/main/pict/Screenshot%20from%202022-04-12%2017-40-35.png)
![](https://github.com/vedoff/DNS/blob/main/pict/Screenshot%20from%202022-04-12%2017-41-08.png)
![](https://github.com/vedoff/DNS/blob/main/pict/Screenshot%20from%202022-04-12%2017-41-28.png)
![](https://github.com/vedoff/DNS/blob/main/pict/Screenshot%20from%202022-04-12%2017-47-03.png)
#### На втором клиенте
![](https://github.com/vedoff/DNS/blob/main/pict/Screenshot%20from%202022-04-12%2017-52-07.png)
![](https://github.com/vedoff/DNS/blob/main/pict/Screenshot%20from%202022-04-12%2017-52-22.png)
![](https://github.com/vedoff/DNS/blob/main/pict/Screenshot%20from%202022-04-12%2017-52-53.png)
![](https://github.com/vedoff/DNS/blob/main/pict/Screenshot%20from%202022-04-12%2017-54-03.png)
