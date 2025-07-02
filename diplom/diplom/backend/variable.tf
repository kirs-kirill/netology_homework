variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  sensitive   = true
  default     = "b1gtntehc8q3dldpb1ka"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  sensitive   = true
  default     = "b1g65ggbv0fmdj4bp782"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}


variable "networks_zone" {
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope, https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
  type = map(object({
    name = string
    zone = string
    cidr = list(string)
  }))
}

variable "family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "vms" {
  type = map(object({
    zone          = string
    name          = string
    description   = string
    cpu           = number
    ram           = number
    core_fraction = number
    disk_volume   = number
    platform_id   = string
    subnet_key    = string
    preemptible   = bool
  }))
}