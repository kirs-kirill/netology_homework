
# data "yandex_compute_image" "ubuntu" {
#   family = var.vm_web_family
# }

# data "yandex_compute_image" "lamp" {
#   family = var.vm_lamp_family
# }
# # Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
# # https://github.com/yandex-cloud-examples/yc-compute-nat-instance
# resource "yandex_compute_instance" "nat-instance" {
#   name        = var.vm_nat_name
#   hostname    = var.vm_nat_name
#   platform_id = "standard-v3"
#   zone        = var.default_zone

#   resources {
#     core_fraction = 20
#     cores         = 2
#     memory        = 2
#   }
#   scheduling_policy {
#     preemptible = true
#   }

#   # Используем образ fd80mrhj8fl2oe87o4e1
#   boot_disk {
#     initialize_params {
#       image_id = "fd80mrhj8fl2oe87o4e1"
#     }
#   }

#   # Присвоим адрес 192.168.10.254
#   network_interface {
#     subnet_id  = yandex_vpc_subnet.public.id
#     nat        = true
#     ip_address = "192.168.10.254"
#   }

#   metadata = {
#     serial-port-enable = 1
#     ssh-keys           = "${var.ssh_user}:${var.ssh_public_key}"
#   }

# }

# ####
# # Создать в этой публичной подсети виртуалку с публичным IP
# ####

# resource "yandex_compute_instance" "public" {
#   name        = "public"
#   hostname    = "public"
#   platform_id = "standard-v3"
#   zone        = var.default_zone

#   resources {
#     core_fraction = 20
#     cores         = 2
#     memory        = 2
#   }
#   scheduling_policy {
#     preemptible = true
#   }

#   boot_disk {
#     initialize_params {
#       image_id = data.yandex_compute_image.ubuntu.image_id
#     }
#   }

#   network_interface {
#     subnet_id = yandex_vpc_subnet.public.id
#     nat       = true
#   }

#   metadata = {
#     ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
#   }
# }


# resource "yandex_compute_instance" "private" {
#   name        = "private"
#   hostname    = "private"
#   platform_id = "standard-v3"
#   zone        = var.default_zone

#   resources {
#     core_fraction = 20
#     cores         = 2
#     memory        = 2
#   }
#   scheduling_policy {
#     preemptible = true
#   }

#   boot_disk {
#     initialize_params {
#       image_id = data.yandex_compute_image.ubuntu.image_id
#     }
#   }

#   network_interface {
#     subnet_id = yandex_vpc_subnet.private-a.id
#     nat       = false
#   }

#   metadata = {
#     ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
#   }
# }
