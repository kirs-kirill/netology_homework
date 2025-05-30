# Домашнее задание к занятию 5. «Практическое применение Docker»

## Задача 0

1. Убедитесь что у вас НЕ(!) установлен ```docker-compose```, для этого получите следующую ошибку от команды ```docker-compose --version```
2. Убедитесь что у вас УСТАНОВЛЕН ```docker compose```(без тире) версии не менее v2.24.X, для это выполните команду ```docker compose version```  

![docker_compose_version](./images/0.png)

## Задача 1

1. <https://github.com/kirs-kirill/shvirtd-example-python>


2. Содержимое `Dockerfile.python`:
```dockerfile
  FROM python:3.9-slim
    
  WORKDIR /app
  COPY . .
  RUN pip install --no-cache-dir -r requirements.txt && rm requirements.txt

  ENV DB_HOST=$(DB_HOST)

  ARG MYSQL_USER
  ARG MYSQL_PASSWORD
  ARG MYSQL_DATABASE

  ENV DB_USER=$MYSQL_USER
  ENV DB_PASSWORD=$MYSQL_PASSWORD
  ENV DB_NAME=$MYSQL_DATABASE

  CMD ["sh", "-c", "sleep 5 && python main.py"]
  ###### слип нужен т.к. почему-то скрипт не ждет пока бд полностью откроется
```

Содержимое `.dockerignore`

![dockerignore](./images/1.png)

Образ нормально собирается:

![docker build](./images/2.png)

![docker images](./images/3.png)

3. Запуск `python ./main.py` в venv

![python ./main.py](./images/4.png)

## Задача 2

![yc registry](./images/5.png)

Отчет об уязвимостях.

[Ссылка на CSV-таблицу](https://github.com/kirs-kirill/netology_homework/blob/49f5ec56267e28ba5f42ae62c1fed1401cdacf3c/05-virt-04-docker-in-practice/vulnerabilities.csv)

<details>
  <summary>Отчет об уязвимостях</summary>
  
  ### Дата сканирования: 15.10.2024, в 15:49 МСК
  | name                | link                                                            | severity | package            | version               | fixedBy |
  |---------------------|-----------------------------------------------------------------|----------|--------------------|-----------------------|---------|
  | CVE-2023-45853      | https://avd.aquasec.com/nvd/cve-2023-45853                      | CRITICAL | zlib1g             | 1:1.2.13.dfsg-1       |         |
  | CVE-2023-52425      | https://avd.aquasec.com/nvd/cve-2023-52425                      | HIGH     | libexpat1          | 2.5.0-1+deb12u1       |         |
  | CVE-2024-26462      | https://avd.aquasec.com/nvd/cve-2024-26462                      | HIGH     | libgssapi-krb5-2   | 1.20.1-2+deb12u2      |         |
  | CVE-2024-26462      | https://avd.aquasec.com/nvd/cve-2024-26462                      | HIGH     | libk5crypto3       | 1.20.1-2+deb12u2      |         |
  | CVE-2024-26462      | https://avd.aquasec.com/nvd/cve-2024-26462                      | HIGH     | libkrb5-3          | 1.20.1-2+deb12u2      |         |
  | CVE-2024-26462      | https://avd.aquasec.com/nvd/cve-2024-26462                      | HIGH     | libkrb5support0    | 1.20.1-2+deb12u2      |         |
  | CVE-2023-7104       | https://avd.aquasec.com/nvd/cve-2023-7104                       | HIGH     | libsqlite3-0       | 3.40.1-2              |         |
  | CVE-2023-31484      | https://avd.aquasec.com/nvd/cve-2023-31484                      | HIGH     | perl-base          | 5.36.0-7+deb12u1      |         |
  | CVE-2023-4039       | https://avd.aquasec.com/nvd/cve-2023-4039                       | MEDIUM   | gcc-12-base        | 12.2.0-14             |         |
  | CVE-2023-4039       | https://avd.aquasec.com/nvd/cve-2023-4039                       | MEDIUM   | libgcc-s1          | 12.2.0-14             |         |
  | CVE-2024-2236       | https://avd.aquasec.com/nvd/cve-2024-2236                       | MEDIUM   | libgcrypt20        | 1.10.1-3              |         |
  | CVE-2024-26458      | https://avd.aquasec.com/nvd/cve-2024-26458                      | MEDIUM   | libgssapi-krb5-2   | 1.20.1-2+deb12u2      |         |
  | CVE-2024-26461      | https://avd.aquasec.com/nvd/cve-2024-26461                      | MEDIUM   | libgssapi-krb5-2   | 1.20.1-2+deb12u2      |         |
  | CVE-2024-26458      | https://avd.aquasec.com/nvd/cve-2024-26458                      | MEDIUM   | libk5crypto3       | 1.20.1-2+deb12u2      |         |
  | CVE-2024-26461      | https://avd.aquasec.com/nvd/cve-2024-26461                      | MEDIUM   | libk5crypto3       | 1.20.1-2+deb12u2      |         |
  | CVE-2024-26458      | https://avd.aquasec.com/nvd/cve-2024-26458                      | MEDIUM   | libkrb5-3          | 1.20.1-2+deb12u2      |         |
  | CVE-2024-26461      | https://avd.aquasec.com/nvd/cve-2024-26461                      | MEDIUM   | libkrb5-3          | 1.20.1-2+deb12u2      |         |
  | CVE-2024-26458      | https://avd.aquasec.com/nvd/cve-2024-26458                      | MEDIUM   | libkrb5support0    | 1.20.1-2+deb12u2      |         |
  | CVE-2024-26461      | https://avd.aquasec.com/nvd/cve-2024-26461                      | MEDIUM   | libkrb5support0    | 1.20.1-2+deb12u2      |         |
  | CVE-2023-50495      | https://avd.aquasec.com/nvd/cve-2023-50495                      | MEDIUM   | libncursesw6       | 6.4-4                 |         |
  | CVE-2024-22365      | https://avd.aquasec.com/nvd/cve-2024-22365                      | MEDIUM   | libpam-modules     | 1.5.2-6+deb12u1       |         |
  | CVE-2024-22365      | https://avd.aquasec.com/nvd/cve-2024-22365                      | MEDIUM   | libpam-modules-bin | 1.5.2-6+deb12u1       |         |
  | CVE-2024-22365      | https://avd.aquasec.com/nvd/cve-2024-22365                      | MEDIUM   | libpam-runtime     | 1.5.2-6+deb12u1       |         |
  | CVE-2024-22365      | https://avd.aquasec.com/nvd/cve-2024-22365                      | MEDIUM   | libpam0g           | 1.5.2-6+deb12u1       |         |
  | CVE-2024-5535       | https://avd.aquasec.com/nvd/cve-2024-5535                       | MEDIUM   | libssl3            | 3.0.14-1~deb12u2      |         |
  | CVE-2023-4039       | https://avd.aquasec.com/nvd/cve-2023-4039                       | MEDIUM   | libstdc++6         | 12.2.0-14             |         |
  | CVE-2023-50495      | https://avd.aquasec.com/nvd/cve-2023-50495                      | MEDIUM   | libtinfo6          | 6.4-4                 |         |
  | CVE-2023-4641       | https://avd.aquasec.com/nvd/cve-2023-4641                       | MEDIUM   | login              | 1:4.13+dfsg1-1+b1     |         |
  | CVE-2023-50495      | https://avd.aquasec.com/nvd/cve-2023-50495                      | MEDIUM   | ncurses-base       | 6.4-4                 |         |
  | CVE-2023-50495      | https://avd.aquasec.com/nvd/cve-2023-50495                      | MEDIUM   | ncurses-bin        | 6.4-4                 |         |
  | CVE-2024-5535       | https://avd.aquasec.com/nvd/cve-2024-5535                       | MEDIUM   | openssl            | 3.0.14-1~deb12u2      |         |
  | CVE-2023-4641       | https://avd.aquasec.com/nvd/cve-2023-4641                       | MEDIUM   | passwd             | 1:4.13+dfsg1-1+b1     |         |
  | CVE-2011-3374       | https://avd.aquasec.com/nvd/cve-2011-3374                       | LOW      | apt                | 2.6.1                 |         |
  | TEMP-0841856-B18BAF | https://security-tracker.debian.org/tracker/TEMP-0841856-B18BAF | LOW      | bash               | 5.2.15-2+b7           |         |
  | CVE-2022-0563       | https://avd.aquasec.com/nvd/cve-2022-0563                       | LOW      | bsdutils           | 1:2.38.1-5+deb12u1    |         |
  | CVE-2016-2781       | https://avd.aquasec.com/nvd/cve-2016-2781                       | LOW      | coreutils          | 9.1-1                 |         |
  | CVE-2017-18018      | https://avd.aquasec.com/nvd/cve-2017-18018                      | LOW      | coreutils          | 9.1-1                 |         |
  | CVE-2022-27943      | https://avd.aquasec.com/nvd/cve-2022-27943                      | LOW      | gcc-12-base        | 12.2.0-14             |         |
  | CVE-2022-3219       | https://avd.aquasec.com/nvd/cve-2022-3219                       | LOW      | gpgv               | 2.2.40-1.1            |         |
  | CVE-2011-3374       | https://avd.aquasec.com/nvd/cve-2011-3374                       | LOW      | libapt-pkg6.0      | 2.6.1                 |         |
  | CVE-2022-0563       | https://avd.aquasec.com/nvd/cve-2022-0563                       | LOW      | libblkid1          | 2.38.1-5+deb12u1      |         |
  | CVE-2010-4756       | https://avd.aquasec.com/nvd/cve-2010-4756                       | LOW      | libc-bin           | 2.36-9+deb12u8        |         |
  | CVE-2018-20796      | https://avd.aquasec.com/nvd/cve-2018-20796                      | LOW      | libc-bin           | 2.36-9+deb12u8        |         |
  | CVE-2019-1010022    | https://avd.aquasec.com/nvd/cve-2019-1010022                    | LOW      | libc-bin           | 2.36-9+deb12u8        |         |
  | CVE-2019-1010023    | https://avd.aquasec.com/nvd/cve-2019-1010023                    | LOW      | libc-bin           | 2.36-9+deb12u8        |         |
  | CVE-2019-1010024    | https://avd.aquasec.com/nvd/cve-2019-1010024                    | LOW      | libc-bin           | 2.36-9+deb12u8        |         |
  | CVE-2019-1010025    | https://avd.aquasec.com/nvd/cve-2019-1010025                    | LOW      | libc-bin           | 2.36-9+deb12u8        |         |
  | CVE-2019-9192       | https://avd.aquasec.com/nvd/cve-2019-9192                       | LOW      | libc-bin           | 2.36-9+deb12u8        |         |
  | CVE-2010-4756       | https://avd.aquasec.com/nvd/cve-2010-4756                       | LOW      | libc6              | 2.36-9+deb12u8        |         |
  | CVE-2018-20796      | https://avd.aquasec.com/nvd/cve-2018-20796                      | LOW      | libc6              | 2.36-9+deb12u8        |         |
  | CVE-2019-1010022    | https://avd.aquasec.com/nvd/cve-2019-1010022                    | LOW      | libc6              | 2.36-9+deb12u8        |         |
  | CVE-2019-1010023    | https://avd.aquasec.com/nvd/cve-2019-1010023                    | LOW      | libc6              | 2.36-9+deb12u8        |         |
  | CVE-2019-1010024    | https://avd.aquasec.com/nvd/cve-2019-1010024                    | LOW      | libc6              | 2.36-9+deb12u8        |         |
  | CVE-2019-1010025    | https://avd.aquasec.com/nvd/cve-2019-1010025                    | LOW      | libc6              | 2.36-9+deb12u8        |         |
  | CVE-2019-9192       | https://avd.aquasec.com/nvd/cve-2019-9192                       | LOW      | libc6              | 2.36-9+deb12u8        |         |
  | CVE-2023-52426      | https://avd.aquasec.com/nvd/cve-2023-52426                      | LOW      | libexpat1          | 2.5.0-1+deb12u1       |         |
  | CVE-2024-28757      | https://avd.aquasec.com/nvd/cve-2024-28757                      | LOW      | libexpat1          | 2.5.0-1+deb12u1       |         |
  | CVE-2022-27943      | https://avd.aquasec.com/nvd/cve-2022-27943                      | LOW      | libgcc-s1          | 12.2.0-14             |         |
  | CVE-2018-6829       | https://avd.aquasec.com/nvd/cve-2018-6829                       | LOW      | libgcrypt20        | 1.10.1-3              |         |
  | CVE-2011-3389       | https://avd.aquasec.com/nvd/cve-2011-3389                       | LOW      | libgnutls30        | 3.7.9-2+deb12u3       |         |
  | CVE-2018-5709       | https://avd.aquasec.com/nvd/cve-2018-5709                       | LOW      | libgssapi-krb5-2   | 1.20.1-2+deb12u2      |         |
  | CVE-2018-5709       | https://avd.aquasec.com/nvd/cve-2018-5709                       | LOW      | libk5crypto3       | 1.20.1-2+deb12u2      |         |
  | CVE-2018-5709       | https://avd.aquasec.com/nvd/cve-2018-5709                       | LOW      | libkrb5-3          | 1.20.1-2+deb12u2      |         |
  | CVE-2018-5709       | https://avd.aquasec.com/nvd/cve-2018-5709                       | LOW      | libkrb5support0    | 1.20.1-2+deb12u2      |         |
  | CVE-2022-0563       | https://avd.aquasec.com/nvd/cve-2022-0563                       | LOW      | libmount1          | 2.38.1-5+deb12u1      |         |
  | CVE-2023-45918      | https://avd.aquasec.com/nvd/cve-2023-45918                      | LOW      | libncursesw6       | 6.4-4                 |         |
  | CVE-2022-0563       | https://avd.aquasec.com/nvd/cve-2022-0563                       | LOW      | libsmartcols1      | 2.38.1-5+deb12u1      |         |
  | CVE-2021-45346      | https://avd.aquasec.com/nvd/cve-2021-45346                      | LOW      | libsqlite3-0       | 3.40.1-2              |         |
  | CVE-2022-27943      | https://avd.aquasec.com/nvd/cve-2022-27943                      | LOW      | libstdc++6         | 12.2.0-14             |         |
  | CVE-2013-4392       | https://avd.aquasec.com/nvd/cve-2013-4392                       | LOW      | libsystemd0        | 252.30-1~deb12u2      |         |
  | CVE-2023-31437      | https://avd.aquasec.com/nvd/cve-2023-31437                      | LOW      | libsystemd0        | 252.30-1~deb12u2      |         |
  | CVE-2023-31438      | https://avd.aquasec.com/nvd/cve-2023-31438                      | LOW      | libsystemd0        | 252.30-1~deb12u2      |         |
  | CVE-2023-31439      | https://avd.aquasec.com/nvd/cve-2023-31439                      | LOW      | libsystemd0        | 252.30-1~deb12u2      |         |
  | CVE-2023-45918      | https://avd.aquasec.com/nvd/cve-2023-45918                      | LOW      | libtinfo6          | 6.4-4                 |         |
  | CVE-2013-4392       | https://avd.aquasec.com/nvd/cve-2013-4392                       | LOW      | libudev1           | 252.30-1~deb12u2      |         |
  | CVE-2023-31437      | https://avd.aquasec.com/nvd/cve-2023-31437                      | LOW      | libudev1           | 252.30-1~deb12u2      |         |
  | CVE-2023-31438      | https://avd.aquasec.com/nvd/cve-2023-31438                      | LOW      | libudev1           | 252.30-1~deb12u2      |         |
  | CVE-2023-31439      | https://avd.aquasec.com/nvd/cve-2023-31439                      | LOW      | libudev1           | 252.30-1~deb12u2      |         |
  | CVE-2022-0563       | https://avd.aquasec.com/nvd/cve-2022-0563                       | LOW      | libuuid1           | 2.38.1-5+deb12u1      |         |
  | CVE-2007-5686       | https://avd.aquasec.com/nvd/cve-2007-5686                       | LOW      | login              | 1:4.13+dfsg1-1+b1     |         |
  | CVE-2019-19882      | https://avd.aquasec.com/nvd/cve-2019-19882                      | LOW      | login              | 1:4.13+dfsg1-1+b1     |         |
  | CVE-2023-29383      | https://avd.aquasec.com/nvd/cve-2023-29383                      | LOW      | login              | 1:4.13+dfsg1-1+b1     |         |
  | TEMP-0628843-DBAD28 | https://security-tracker.debian.org/tracker/TEMP-0628843-DBAD28 | LOW      | login              | 1:4.13+dfsg1-1+b1     |         |
  | CVE-2022-0563       | https://avd.aquasec.com/nvd/cve-2022-0563                       | LOW      | mount              | 2.38.1-5+deb12u1      |         |
  | CVE-2023-45918      | https://avd.aquasec.com/nvd/cve-2023-45918                      | LOW      | ncurses-base       | 6.4-4                 |         |
  | CVE-2023-45918      | https://avd.aquasec.com/nvd/cve-2023-45918                      | LOW      | ncurses-bin        | 6.4-4                 |         |
  | CVE-2007-5686       | https://avd.aquasec.com/nvd/cve-2007-5686                       | LOW      | passwd             | 1:4.13+dfsg1-1+b1     |         |
  | CVE-2019-19882      | https://avd.aquasec.com/nvd/cve-2019-19882                      | LOW      | passwd             | 1:4.13+dfsg1-1+b1     |         |
  | CVE-2023-29383      | https://avd.aquasec.com/nvd/cve-2023-29383                      | LOW      | passwd             | 1:4.13+dfsg1-1+b1     |         |
  | TEMP-0628843-DBAD28 | https://security-tracker.debian.org/tracker/TEMP-0628843-DBAD28 | LOW      | passwd             | 1:4.13+dfsg1-1+b1     |         |
  | CVE-2011-4116       | https://avd.aquasec.com/nvd/cve-2011-4116                       | LOW      | perl-base          | 5.36.0-7+deb12u1      |         |
  | CVE-2023-31486      | https://avd.aquasec.com/nvd/cve-2023-31486                      | LOW      | perl-base          | 5.36.0-7+deb12u1      |         |
  | TEMP-0517018-A83CE6 | https://security-tracker.debian.org/tracker/TEMP-0517018-A83CE6 | LOW      | sysvinit-utils     | 3.06-4                |         |
  | CVE-2005-2541       | https://avd.aquasec.com/nvd/cve-2005-2541                       | LOW      | tar                | 1.34+dfsg-1.2+deb12u1 |         |
  | TEMP-0290435-0B57B5 | https://security-tracker.debian.org/tracker/TEMP-0290435-0B57B5 | LOW      | tar                | 1.34+dfsg-1.2+deb12u1 |         |
  | CVE-2022-0563       | https://avd.aquasec.com/nvd/cve-2022-0563                       | LOW      | util-linux         | 2.38.1-5+deb12u1      |         |
  | CVE-2022-0563       | https://avd.aquasec.com/nvd/cve-2022-0563                       | LOW      | util-linux-extra   | 2.38.1-5+deb12u1      |         |

</details>

## Задача 3

![sql requests](./images/6.png)

<details>
  <summary>Содержимое <code>compose.yaml</code></summary>

```compose

  #version: "3" #будет удалено в новых весиях docker

  name: task3

  include:
    - proxy.yaml
  
  services:

    http_back:
      build:
        context: .
        dockerfile: Dockerfile.python
        args:
            - MYSQL_USER=$MYSQL_USER
            - MYSQL_PASSWORD=$MYSQL_PASSWORD
            - MYSQL_DATABASE=$MYSQL_DATABASE
      networks:
        backend:
          ipv4_address: 172.20.0.5
      ports:
        - "5000:5000"
      environment:
        - DB_HOST=db
      env_file:
        - path: ./.env
      depends_on:
        - db
      restart: on-failure

    db:
      image: mysql:8
      networks:
        backend:
          ipv4_address: 172.20.0.10
      restart: always
      environment:
        - DB_HOST=db
      env_file:
        - path: ./.env
    
  ```
</details>

## Задача 4

Содержимое `script.sh`

```shell
#!/bin/bash

cd /opt
git clone https://github.com/kirs-kirill/shvirtd-example-python.git
cd /opt/shvirtd-example-python
docker compose up -d
```

Запросы к БД проекта на VM

![yc vm](./images/7.png)

Ссылка на форк репозитория

  <https://github.com/kirs-kirill/shvirtd-example-python>

## Задача 6

Сначала с помощью `dive` узнаем ID нужного нам слоя образа.

![dive](./images/9.png)

![dive](./images/10.png)

Затем сохраняем образ в tar-архив, распаковываем его и по ID слоя находим нужные нам данные

![tar](./images/11.png)

### Задача 6.1

![docker cp](./images/12.png)
