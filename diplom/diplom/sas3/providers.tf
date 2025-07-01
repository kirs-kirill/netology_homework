terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.5"
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  # service_account_key_file = file("~/.key.json")
  token                    = var.token
}

# https://yandex.cloud/ru/docs/ydb/terraform/dynamodb-tables
provider "aws" {
  region = var.location
  endpoints {
    dynamodb = yandex_ydb_database_serverless.diplom-ydb.document_api_endpoint
  }
  # profile = "default"
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  skip_credentials_validation = true
  skip_metadata_api_check = true
  skip_region_validation = true
  skip_requesting_account_id = true
}