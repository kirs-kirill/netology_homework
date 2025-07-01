resource "yandex_ydb_database_serverless" "diplom-ydb" {
  name                = "diplom-ydb"
  location_id         = var.location  // https://github.com/yandex-cloud/terraform-provider-yandex/issues/524
  deletion_protection = false

  serverless_database {
    enable_throttling_rcu_limit = false
    storage_size_limit          = 1
  }
}

# https://yandex.cloud/ru/docs/ydb/terraform/dynamodb-tables

resource "aws_dynamodb_table" "diplomTable" {
  name         = "diplomTable"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }


}