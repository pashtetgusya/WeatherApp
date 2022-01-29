# WeatherApp
Данное приложение предназначено для работы с метеостанцией на базе Arduino.
Метеоустройство каждые 5 минут отправляет запрос с параметрами на веб-сервер.
В параметрах передаются полученные измерения по температуре, влажности и давлению.

Веб-сервер разработан с использованием фреймворка Django.

Мобильное приложение позволяет пользователям просматривать последние измерения, статистику за день и неделю. 
А также управлять метеостанциями (добавлять новые, изменять, удалять и выбирать в качестве текущей).

## Скриншоты
<img src="https://user-images.githubusercontent.com/25635870/151649592-d2f3b701-fdbd-43d8-8308-d3b961ada5bd.png" width="500">

![Register](https://user-images.githubusercontent.com/25635870/151649594-66ff1889-7e99-4425-85a3-d65d6dc520a7.png)

![CurrentWeather](https://user-images.githubusercontent.com/25635870/151649602-17321c92-49e2-448c-946b-b1f93f1005c8.png)

![Profile](https://user-images.githubusercontent.com/25635870/151649608-d507f91c-9b4c-458f-aff2-59652c7a1218.png)

![DevicesSettings](https://user-images.githubusercontent.com/25635870/151649812-3d4843fb-44a3-4bda-b748-80550dabe539.png)

![DayWeather](https://user-images.githubusercontent.com/25635870/151649624-a19f17d3-1c42-4b08-8631-50c4ce996ac7.png)

![WeekWeather](https://user-images.githubusercontent.com/25635870/151649625-02752ad0-965a-46e2-a9fe-234bf3f4c1b4.png)
