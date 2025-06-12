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

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

data "yandex_compute_image" "lamp" {
  family = var.vm_lamp_family
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


resource "yandex_storage_bucket" "hw_bucket" {
  bucket                = "kirsanov-hw-bucket"
  folder_id             = var.folder_id
  max_size              = 1024000
  default_storage_class = "COLD"
  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }
}

resource "yandex_compute_instance_group" "hw-group" {
  folder_id           = var.folder_id
  service_account_id  = var.service_account_id
  deletion_protection = false
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = data.yandex_compute_image.lamp.id
        size     = 20
      }
    }
    network_interface {
      nat        = true
      network_id = yandex_vpc_network.hw-net.id
      subnet_ids = ["${yandex_vpc_subnet.public.id}"]
    }
    labels = {
      label1 = "label1-value"
      label2 = "label2-value"
    }
    metadata = {
      user-data = "${file("./data.txt")}"
      ssh-keys  = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }
  health_check {
    healthy_threshold = 3
    http_options {
      path = "/"
      port = 80
    }
    interval = 10
    timeout = 5
    unhealthy_threshold = 2
  }
  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "Целевая группа Network Load Balancer"
  }
}


resource "yandex_lb_network_load_balancer" "hw-loadbalancer" {
  name = "hw-loadbalancer"

  listener {
    name = "hw-loadbalancer-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.hw-group.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/index.html"
      }
    }
  }
}