# 1. Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
# Создаем пустую VPC
resource "yandex_vpc_network" "hw-net" {
  name      = "hw-15"
  folder_id = var.folder_id
}

# Добавляем подсеть public
resource "yandex_vpc_subnet" "public" {
  v4_cidr_blocks = var.public_cidr
  zone           = var.default_zone
  network_id     = yandex_vpc_network.hw-net.id
  name           = "public"
}
resource "yandex_vpc_subnet" "public_d" {
  v4_cidr_blocks = var.public_cidr_d
  zone           = var.backup_zone_d
  network_id     = yandex_vpc_network.hw-net.id
  name           = "public-d"
}


# Добавляем подсеть private
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
