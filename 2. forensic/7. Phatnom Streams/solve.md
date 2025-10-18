# Phantom Streams [medium]
550
forensic medium

### Автор: gr8str8some1
### Решил: gr8str8some1

> Описание: Отделом реагирования на инциденты было зафиксировано аномально большой объем смешанного сетевого трафика между двумя узлами. Проанализируйте TCP-streams: может, в одном из них есть что-то важное

### Решение:
Запускаем в wireshark<br>
![img.png](images/img.png)

Заходим в Statistics > Conversations<br>
Переключаемся на tcp и смотрим все соединения<br>
![img_1.png](images/img_1.png)

И вот один из потоков с портом 4444 прям выделяется по bytes на фоне остальных.<br>
![img_2.png](images/img_2.png)

Нажимаем на follow слева<br>
И получаем вот такую ерунду.<br>
![img_3.png](images/img_3.png)

Сохраняем как Raw, жмём save и указываем имя файла. Я указал test<br>
Смотрим, что сохранилось:<br>
![img_4.png](images/img_4.png)