## Hahahttp [easy]
200
forensic easy

# Автор: gr8str8some1
# Решил: gr8str8some1

> Описание: Слышали что-нибудь про 80 порт? А он о вас?<br>
Формат флага: Host_SSU{...}<br>
*Host можно увидеть в нужном пакете с флагом<br>

# Решение:
Запускаем этот pcap в wireshark<br>
![img.png](images/img.png)

![img_1.png](images/img_1.png)

Фильтруем пакеты по 80 порту:<br>
> [!TIP] 
> Самые базовые и полезные:
> 21 ftp
> 22 ssh
> 23 telnet
> 25 smtp
> 80 http
> 443 https
> 3389 rdp
![img_2.png](images/img_2.png)

В одном из них есть и флаг, и хост (Host: VOVOVOSHKA).<br>
Формируем ответ<br>
![img_3.png](images/img_3.png)