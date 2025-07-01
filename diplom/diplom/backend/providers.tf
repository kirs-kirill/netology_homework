terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.5"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net", # только хардкод
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gtntehc8q3dldpb1ka/etn2ham56gk5jef68o0i" # Меняется при пересоздании БД, # только хардкод
    }
    bucket = "kirsanov-diplom-bucket" # только хардкод
    key = "terraform.tfstate"
    region = "ru-central1" # только хардкод

    access_key = var.access_key
    secret_key = var.secret_key

    dynamodb_table = "diplomTable" #Таблица блокировок # только хардкод
    encrypt = false #Шифрование state сервером Terraform

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

}
}

provider "yandex" {
  # token     = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = file("~/.key.json")
}