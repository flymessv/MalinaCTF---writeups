## BaZa (дважды) [easy]
200
crypto easy

# Автор: gr8str8some1
# Решил: gr8str8some1
> Описание: Задача так же прекрасна, как Саратов с регионом 64. (Только задом наперёд)
==QPwgkT2IlaZZmTY1kZSpmTm5kejBTSyUmVOFTV

# Решение
По описанию понимаем, что это что-то 64<br>
=> base64<br>

Только задом наперед<br>
=> reverse<br>

Но если мы реверснем и потом decode base64 -> ничего не будет<br>
Обращаемся к описанию таска и понимаем, что у нас base64 дважды<br>
Так что ход решения reverse-> decode base64 -> decode base64<br>

1) Реверсим исходную строку и получаем VTFOVmUySTBjek5mTmpSZk1YTmZZalI2TkgwPQ==<br>
2) Например юзаем любой декодер (https://www.base64decode.org/)<br>
Получаем U1NVe2I0czNfNjRfMXNfYjR6NH0=><br>
3) И это опять пихаем в декодер<br>
   =>  SSU{b4s3_64_1s_b4z4}<br>