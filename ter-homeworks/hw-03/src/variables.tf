###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}


### Custom variables

variable "task2_1" {
  type        = map(string)
  description = "VM config variables"
  default = {
    family             = "ubuntu-2004-lts"
    platform_id        = "standard-v3"
    vm_name            = "web"
    cores              = 2
    memory             = 1
    core_fraction      = 20
    login              = "ubuntu"
    serial-port-enable = true
    preemptible        = true
    hostname           = "hw-03"
    count_vms          = 2
  }
}

variable "family" {
  type    = string
  default = "ubuntu-2004-lts"
}
variable "task2_2" {
  type = list(object({
    name          = string,
    cpu           = number,
    ram           = number,
    disk_volume   = number, # из описания задания не совсем понятно что имеется в виду под disk_volume, поэтому переменная указыват размер диска
    core_fraction = number,
    platform_id   = string,
    description   = string
  }))
  default = [{
    name          = "main"
    cpu           = 2
    ram           = 1
    disk_volume   = 8
    core_fraction = 20
    platform_id   = "standard-v3"
    description = "task2_2"
    }, {
    name          = "replica"
    cpu           = 2
    ram           = 1
    disk_volume   = 9
    core_fraction = 20
    platform_id   = "standard-v3"
    description = "task2_2"
    }
  ]
}
