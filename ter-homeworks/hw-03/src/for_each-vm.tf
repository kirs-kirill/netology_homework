data "yandex_compute_image" "foreach" {
  family = var.family #образ системы
}

resource "yandex_compute_instance" "foreach" {
  for_each    = {for k, v in var.task2_2_vms : k => v}
  name        = each.value.name   #имя ВМ
  platform_id = each.value.platform_id # используемый процессор
  description = each.value.description
  hostname    = each.value.name
  resources {
    cores         = each.value.cpu           # кол-во ядер
    memory        = each.value.ram           # кол-во памяти
    core_fraction = each.value.core_fraction # использование процессора в %
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
    }
  }
  scheduling_policy {
    preemptible = var.task2_1.preemptible # Прерываемая машина
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id # используемая сеть, определяется в main.tf
    nat       = true
  }

  metadata = {
    serial-port-enable = var.task2_1.serial-port-enable
    ssh-keys           = "${var.task2_1.login}:${local.ssh-key}"
  }

}
