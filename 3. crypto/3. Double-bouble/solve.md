# YSHI GLAZA i ROT(!) [easy]
200
crypto easy

### Автор: gr8str8some1
### Решил: gr8str8some1

> Alice отправляет вам два зашифрованных сообщения, используя AES‑128 в режиме счётчика (CTR) с полностью нулевым nonce (IV = 0). Первый шифротекст сопровождается известным плейнтекстом — «What a CyberChef? :)». А что за собой скрывает второй?)<br>
PT1 = What a CyberChef? :)<br>
CT1 = 37583a396111079b48328cbb422d6f4eb61631a0<br>
CT2 = 33630e36334352ab020f8abd731a6418e75538f4<br>
Алгоритм: AES-128-CTR, NONCE = 0000000000000000<br>

### Решение:
from hex -> xor CT1 with PT1 -> to hex = 60 30 5b 4d 41 70 27 d8 31 50 e9 c9 01 45 0a 28 89 36 0b 89<br>
(и CT1 даст PT1)<br>
from hex -> xor CT2 with _new_ -> SSU{r3us3_ctr_n0nc3}<br>
Можно или через скрипты посчитать или воспользоваться CyberChef (https://cyberchef.org)
