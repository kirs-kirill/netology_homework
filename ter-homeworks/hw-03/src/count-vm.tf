data "yandex_compute_image" "ubuntu" {
  family = var.task2_1.family #образ системы
}

resource "yandex_compute_instance" "count_vms" {
  depends_on = [ yandex_compute_instance.foreach ]
  count       = var.task2_1.count_vms
  name        = "${var.task2_1.vm_name}-${count.index + 1}" #имя ВМ
  platform_id = var.task2_1.platform_id                     # используемый процессор
  description = "${var.task2_1.hostname}-${count.index + 1}"
  hostname    = "${var.task2_1.hostname}-${count.index + 1}"
  resources {
    cores         = var.task2_1.cores         # кол-во ядер
    memory        = var.task2_1.memory        # кол-во памяти
    core_fraction = var.task2_1.core_fraction # использование процессора в %
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
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
