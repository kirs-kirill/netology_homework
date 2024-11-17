data "yandex_compute_image" "ubuntu" {
  family = var.family   #образ системы
}
resource "yandex_compute_instance" "vms" {
  count = var.count_vms # кол-во создаваемых ВМ
  name        = "${var.vm_name}-${count.index+1}" #имя ВМ
  platform_id = var.platform_id # используемый процессор
  description = "hw-03-${count.index+1}"
  resources {
    cores         = var.vm_resources.cores          # кол-во ядер
    memory        = var.vm_resources.memory         # кол-во памяти
    core_fraction = var.vm_resources.core_fraction  # использование процессора в %
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true  # Прерываемая машина
  }
  network_interface {
    subnet_id = "${yandex_vpc_subnet.develop.id}" # используемая сеть, определяется в main.tf
    nat       = true
  }

  metadata = {
    serial-port-enable = var.serial-port-enable
    ssh-keys           = "${var.login}:${local.ssh-key}" #ssh-keygen -t ed25519
  }

}