# Домашнее задание к занятию 16 «Платформа мониторинга Sentry»

### Задание 1

Развернул self-hosted Sentry

Панель Projects

<img src="./images/1.png" alt="Projects" width="600" height="400">

### Задание 2

`Stack trace`

<img src="./images/2.png" alt="Stack trace" width="600" height="400">

`Resolved`

<img src="./images/3.png" alt="Resolved" width="600" height="300">

### Задание 3

Т.к. у меня self-hosted версия Sentry, и почта не настроена, я добавил плагин оповещений [через Телеграм](https://github.com/butorov/sentry-telegram) и настроил алерты через телеграм бота.

Почему-то оповещения через тестовое событие не уходят при повторном открытии события, поэтому спровоцировал новое событие с помощью python-скрипта из урока.

<img src="./images/4.png" alt="Resolved" width="350" height="300">
