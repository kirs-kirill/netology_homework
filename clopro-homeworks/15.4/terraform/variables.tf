###cloud vars
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  default = "b1gtntehc8q3dldpb1ka"
  sensitive = true
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  sensitive = true
  default = "b1g65ggbv0fmdj4bp782"
}

variable "service_account_id" {
  type = string
  sensitive = true
  default = "ajev6fmmk9cib5ve79vo"
  description = ">yc iam service-account list -folder-id {folder_id}"
}


variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "backup_zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "backup_zone_d" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}


variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "public_cidr_b" {
  type        = list(string)
  default     = ["192.168.40.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "public_cidr_d" {
  type        = list(string)
  default     = ["192.168.50.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "private_cidr_a" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "private_cidr_b" {
  type        = list(string)
  default     = ["192.168.30.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###custom vars

variable "vm_nat_name" {
  type        = string
  description = "Using image"
  default     = "nat-vm"
}


variable "vm_nat_image_id" {
  type        = string
  description = "Using image"
  default     = "fd80mrhj8fl2oe87o4e1"
}

variable "vm_web_family" {
  type        = string
  description = "Using image"
  default     = "ubuntu-2004-lts"
}

variable "vm_lamp_family" {
  type        = string
  description = "Using image"
  default     = "lamp"
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
    ssh-keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINauVL3ZATWD0cBj/Ky+ht+rTqAFf5X/9vyOExq9/Uj4 kirs-kirill@yandex.ru"
    }
  }

}


###ssh vars

variable "ssh_public_key" {
  type = string
  description = "ssh-keygen -t ed25519"
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGwnTo6m+UX7nAgIfVqd/J2mYUAz0FfLe4JyicRZq7Uo usem@k8s"
}

variable "ssh_user" {
  type = string
  default = "usem"
}