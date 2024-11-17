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

variable "family" {
  type        = string
  description = "OS image family"
  default     = "ubuntu-2004-lts"
}

variable "platform_id" {
  type        = string
  description = "https://yandex.cloud/en/docs/compute/concepts/performance-levels"
  default     = "standard-v3"
}

variable "vm_name" {
  type        = string
  description = "Name template of VMs"
  default     = "web"
}

variable "vm_resources" {
  type = map(number)
  default = {
    cores = 2, memory = 1, core_fraction = 20
  }
  description = "https://yandex.cloud/ru/docs/compute/concepts/performance-levels"
}

variable "login" {
  type        = string
  description = "username for login to VMs"
  default     = "ubuntu"
  sensitive   = true
}

variable "serial-port-enable" {
  type = bool
  default = true
}

variable "count_vms" {
  type = number
  default = 2
  description = "count of wms"
}