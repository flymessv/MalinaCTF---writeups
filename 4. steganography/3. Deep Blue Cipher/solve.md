## Deep Blue Cipher [easy]
350
steganography easy

# Автор: gr8str8some1
# Решил: gr8str8some1

> Описание: Sift<br>
Through<br>
Every<br>
Glimmer.<br>
<br>
Hidden<br>
Information<br>
Demands<br>
Extraction.<br>

# Решение:
Во-1, ХВАЛИМ АВТОРА за описание таски.<br>
Во-2, если там ещё и собрать заглавные, то получим один из инструменов решения, а точнее steghide.<br>

Смотрим, что в архиве:<br>
![img.png](images/img.png)

![img_1.png](images/img_1.png)

Запускаем Steghide<br>
![img_2.png](images/img_2.png)

Просит пароль :( <br>
Качаем из опенсорса stegsolve<br>
![img_3.png](images/img_3.png)

Открываем одну из картинок, проверяем её:<br>
![img_4.png](images/img_4.png)

Сдедлаем зум меньше:<br>
![img_5.png](images/img_5.png)

Везде неразбериха, по типу такой:<br>
![img_6.png](images/img_6.png)

Эта неразбериха выявляется путём "листания по стрелочкам", тем самым мы прошлись по всем каналам.<br>
Но у нас есть и вторая картинка. Пробуем и её.<br>
В blue plane 0<br>
![img_7.png](images/img_7.png)

Что-то есть, приближаем<br>
![img_8.png](images/img_8.png)

И вставляем пароль в passphrase<br>
![img_9.png](images/img_9.png)
![img_10.png](images/img_10.png)
