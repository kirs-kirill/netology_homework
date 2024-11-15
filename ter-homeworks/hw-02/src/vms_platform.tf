###custom vars

variable "vm_db_family" {
  type        = string
  description = "Using image"
  default     = "ubuntu-2004-lts"
}

variable "vm_db_name" {
  type        = string
  description = "Name of VM"
  default     = "netology-develop-platform-db"
}

variable "vm_db_platform_id" {
  type        = string
  description = "https://yandex.cloud/en/docs/compute/concepts/performance-levels"
  default     = "standard-v3"
}

variable "vm_db_resources" {
  type        = map(number)
  default     = {cores = 2, memory = 2, core_fraction = 20}
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

### For task 3
resource "yandex_compute_instance" "netology-develop-platform-db" {
  name        = var.vm_db_name
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vm_db_resources.cores
    memory        = var.vm_db_resources.memory
    core_fraction = var.vm_db_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}