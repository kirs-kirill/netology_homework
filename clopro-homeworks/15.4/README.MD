# Домашнее задание к занятию «Кластеры. Ресурсы под управлением облачных провайдеров»

### Цели задания 

1. Организация кластера Kubernetes и кластера баз данных MySQL в отказоустойчивой архитектуре.
2. Размещение в private подсетях кластера БД, а в public — кластера Kubernetes.

---
## Задание 1. Yandex Cloud

1. Настроить с помощью Terraform кластер баз данных MySQL.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно подсеть private в разных зонах, чтобы обеспечить отказоустойчивость. 
 - Разместить ноды кластера MySQL в разных подсетях.
 - Необходимо предусмотреть репликацию с произвольным временем технического обслуживания.
 - Использовать окружение Prestable, платформу Intel Broadwell с производительностью 50% CPU и размером диска 20 Гб.
 - Задать время начала резервного копирования — 23:59.
 - Включить защиту кластера от непреднамеренного удаления.
 - Создать БД с именем `netology_db`, логином и паролем.

2. Настроить с помощью Terraform кластер Kubernetes.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно две подсети public в разных зонах, чтобы обеспечить отказоустойчивость.
 - Создать отдельный сервис-аккаунт с необходимыми правами. 
 - Создать региональный мастер Kubernetes с размещением нод в трёх разных подсетях.
 - Добавить возможность шифрования ключом из KMS, созданным в предыдущем домашнем задании.
 - Создать группу узлов, состояющую из трёх машин с автомасштабированием до шести.
 - Подключиться к кластеру с помощью `kubectl`.
 - *Запустить микросервис phpmyadmin и подключиться к ранее созданной БД.
 - *Создать сервис-типы Load Balancer и подключиться к phpmyadmin. Предоставить скриншот с публичным адресом и подключением к БД.

Полезные документы:

- [MySQL cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_cluster).
- [Создание кластера Kubernetes](https://cloud.yandex.ru/docs/managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create)
- [K8S Cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster).
- [K8S node group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group).

--- 

#### Решение

1. Настроить с помощью Terraform кластер баз данных MySQL.

  Подсети `private-d` нет, в зоне D нельзя создать кластер с необходимой конфигурацией.

  ``` tf
  resource "yandex_vpc_subnet" "private-a" {
    v4_cidr_blocks = var.private_cidr_a
    zone           = var.default_zone
    network_id     = yandex_vpc_network.hw-net.id
    name           = "private-a"
    route_table_id = yandex_vpc_route_table.private_gw.id
  }
  resource "yandex_vpc_subnet" "private-b" {
    v4_cidr_blocks = var.private_cidr_b
    zone           = var.backup_zone_b
    network_id     = yandex_vpc_network.hw-net.id
    name           = "private-b"
    route_table_id = yandex_vpc_route_table.private_gw.id
  }

  data "yandex_vpc_route_table" "private_gw" {
    route_table_id = yandex_vpc_route_table.private_gw.id
  }
    
  resource "yandex_vpc_route_table" "private_gw" {
    network_id = yandex_vpc_network.hw-net.id

    static_route {
      destination_prefix = "0.0.0.0/0"
      next_hop_address   = "192.168.10.254"
    }
  }

  resource "yandex_mdb_mysql_cluster" "hw_cluster" {
    name        = "test"
    environment = "PRESTABLE"
    network_id  = yandex_vpc_network.hw-net.id
    version     = "8.0"

    resources {
      resource_preset_id = "b1.medium"
      disk_type_id       = "network-ssd"
      disk_size          = 20
    }

    maintenance_window {
      type = "ANYTIME"
    }
    backup_window_start{
      hours = 23
      minutes = 59
    }
    host {
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.private-a.id
    }
    host {
      zone      = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.private-b.id
    }
  }

  resource "yandex_mdb_mysql_database" "my_db" {
    cluster_id = yandex_mdb_mysql_cluster.hw_cluster.id
    name       = "netology_db"
  }

  resource "yandex_mdb_mysql_user" "hw_user" {
    cluster_id = yandex_mdb_mysql_cluster.my_cluster.id
    name       = "netology"
    password   = "netology"

    permission {
      database_name = yandex_mdb_mysql_database.hw_db.name
      roles         = ["ALL"]
    }

    connection_limits {
      max_questions_per_hour   = 10
      max_updates_per_hour     = 20
      max_connections_per_hour = 30
      max_user_connections     = 40
    }

    global_permissions = ["PROCESS"]

    authentication_plugin = "SHA256_PASSWORD"
  }
  ```
