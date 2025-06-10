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

# Добавляем подсеть private
resource "yandex_vpc_subnet" "private" {
  v4_cidr_blocks = var.private_cidr
  zone           = var.default_zone
  network_id     = yandex_vpc_network.hw-net.id
  name           = "private"
  route_table_id = yandex_vpc_route_table.private_gw.id
}

resource "yandex_vpc_route_table" "private_gw" {
  network_id = yandex_vpc_network.hw-net.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}

# Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
# https://github.com/yandex-cloud-examples/yc-compute-nat-instance
resource "yandex_compute_instance" "nat-instance" {
  name        = var.vm_nat_name
  hostname    = var.vm_nat_name
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }
  scheduling_policy {
    preemptible = true
  }

  # Используем образ fd80mrhj8fl2oe87o4e1
  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  # Присвоим адрес 192.168.10.254
  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    nat        = true
    ip_address = "192.168.10.254"
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${var.ssh_user}:${var.ssh_public_key}"
  }

}

####
# Создать в этой публичной подсети виртуалку с публичным IP
####
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

resource "yandex_compute_instance" "public" {
  name        = "public"
  hostname    = "public"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }
  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
  }
}

data "yandex_vpc_route_table" "private_gw" {
  route_table_id = yandex_vpc_route_table.private_gw.id
}



resource "yandex_compute_instance" "private" {
  name        = "private"
  hostname    = "private"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }
  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
  }
}
