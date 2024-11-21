resource "yandex_compute_disk" "task3" {
  count = 3
  name     = "${var.task3_disk.name}-${count.index}"
  type     = var.task3_disk.type
  zone     = var.default_zone
  size = var.task3_disk.size

  labels = {
    environment = var.task3_disk.environment
  }
}

resource "yandex_compute_instance" "storage" {
  name        = "${var.task3_vm.vm_name}" #имя ВМ
  platform_id = var.task3_vm.platform_id                     # используемый процессор
  description = "${var.task3_vm.hostname}"
  hostname    = "${var.task3_vm.hostname}"
  resources {
    cores         = var.task3_vm.cores         # кол-во ядер
    memory        = var.task3_vm.memory        # кол-во памяти
    core_fraction = var.task3_vm.core_fraction # использование процессора в %
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  dynamic "secondary_disk" {
    for_each = { for disk_id in yandex_compute_disk.task3[*]: disk_id.name=> disk_id }
    content {
      disk_id = secondary_disk.value.id
    }
  }

  scheduling_policy {
    preemptible = var.task3_vm.preemptible # Прерываемая машина
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id # используемая сеть, определяется в main.tf
    nat       = true
  }
  metadata = {
    serial-port-enable = true
    ssh-keys           = "${var.task3_vm.login}:${local.ssh-key}"
  }

}
