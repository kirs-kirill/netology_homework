# Создаем пустую VPC
resource "yandex_vpc_network" "hw-net" {
  name = "hw-15"
}

# Добавляем подсеть public
resource "yandex_vpc_subnet" "public" {
  v4_cidr_blocks = var.default_cidr
  zone           = var.default_zone
  network_id     = yandex_vpc_network.hw-net.id
  name = "public"
}

# Создаем NAT-инстанс
resource "yandex_compute_instance" "nat-instance" {
  name        = var.vm_nat_name
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

# Используем образ fd80mrhj8fl2oe87o4e1
  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

# Присвоим адрес 192.168.10.254
  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    #security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat                = true
    ip_address = "192.168.10.254"
  }

}

# Сделаем группу безопасности для NAT-инстанса
resource "yandex_vpc_security_group" "nat-instance-sg" {
  name       = "nat-instance-sg"
  network_id = yandex_vpc_network.hw-net.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

}
