variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
  sensitive   = true
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  sensitive   = true
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "networks_zone" {
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope, https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
  type = list(object(
    {
      zone = string,
      cidr = tuple([string]),
      name = string
    }
  ))
  default = [{
    zone = "ru-central1-a"
    cidr = ["192.168.10.0/24"]
    name = "subnet_a"
    },
    {
      zone = "ru-central1-b"
      cidr = ["192.168.20.0/24"]
      name = "subnet_b"
    },
    {
      zone = "ru-central1-d"
      cidr = ["192.168.30.0/24"]
      name = "subnet_d"
  }]
}