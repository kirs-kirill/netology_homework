# Ansible playbook for install Vector

## Требования

  - Server:
    - Ansible 2.9+
  - Host:
    - Centos (tested on Centos 9)
    - Python 3.7+

## Версии

  - Vector 0.41.1 (default)

## Параметры

В файле [/group_vars/vector/vars.yml](/mnt-homeworks/08-ansible-02-playbook/playbook/group_vars/vector/vars.yml) указывается версия Vector для установки.

Файл [/templates/vector.yaml](/mnt-homeworks/08-ansible-02-playbook/playbook/templates/vector.yaml) используется в качестве шаблона конфигурации для запуска на хостах.

## Что делает

  - Скачивает установочный файл `.rpm` нужной версии.
  - Устанавливает его на хост.
  - Копирует файл конфигурации Vector на хост у каталог `/etc/vector`
  - Перезапускает сервис `vector` при изменении шаблона конфигурации.