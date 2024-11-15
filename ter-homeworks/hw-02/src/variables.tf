###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  sensitive = true
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  sensitive = true
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
  description = "VPC network & subnet name"
}


###custom vars

variable "vm_web_family" {
  type        = string
  description = "Using image"
  default     = "ubuntu-2004-lts"
}

variable "vm_web_platform_id" {
  type        = string
  description = "https://yandex.cloud/en/docs/compute/concepts/performance-levels"
  default     = "standard-v3"
}

variable "vm_resources" {
  type        = map(map(string))
  default     = {
    web = {cores = 2, memory = 1, core_fraction = 20},
    db = {cores = 2, memory = 2, core_fraction = 20}
    }
  description = "https://yandex.cloud/ru/docs/compute/concepts/performance-levels"
}

variable "vm_metadata"{
  type = map(object({
    serial-port-enable = number, 
    ssh-keys = string
    }))
  default = {
    metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICQcwD9uWc42cYFGApx4kNUVGyZaGvbipy02takxkXNI usem@MacBook-Pro-usem.local"
    }
  }

}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICQcwD9uWc42cYFGApx4kNUVGyZaGvbipy02takxkXNI usem@MacBook-Pro-usem.local"
  description = "ssh-keygen -t ed25519"
}