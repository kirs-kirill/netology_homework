1. [Создание сервисного аккаунта с правами записи, бакета и YDB](./sas3/)

    <details>
    <summary>terraform plan</summary>
      $ terraform plan
        
      Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
        + create
        
      Terraform will perform the following actions:
        
        # aws_dynamodb_table.diplomTable will be created
        + resource "aws_dynamodb_table" "diplomTable" {
            + arn              = (known after apply)
            + billing_mode     = "PAY_PER_REQUEST"
            + hash_key         = "LockID"
            + id               = (known after apply)
            + name             = "diplomTable"
            + read_capacity    = (known after apply)
            + region           = "ru-central1"
            + stream_arn       = (known after apply)
            + stream_label     = (known after apply)
            + stream_view_type = (known after apply)
            + tags_all         = (known after apply)
            + write_capacity   = (known after apply)
        
            + attribute {
                + name = "LockID"
                + type = "S"
              }
          }
        
        # yandex_iam_service_account.sa will be created
        + resource "yandex_iam_service_account" "sa" {
            + created_at  = (known after apply)
            + description = "diplom-sa"
            + folder_id   = (sensitive value)
            + id          = (known after apply)
            + name        = "diplom"
          }
        
        # yandex_iam_service_account_static_access_key.sa-static-key will be created
        + resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
            + access_key                   = (known after apply)
            + created_at                   = (known after apply)
            + description                  = "static access key for object storage"
            + encrypted_secret_key         = (known after apply)
            + id                           = (known after apply)
            + key_fingerprint              = (known after apply)
            + output_to_lockbox_version_id = (known after apply)
            + secret_key                   = (sensitive value)
            + service_account_id           = (known after apply)
          }
        
        # yandex_resourcemanager_folder_iam_member.sa-editor will be created
        + resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
            + folder_id = (sensitive value)
            + id        = (known after apply)
            + member    = (known after apply)
            + role      = "editor"
          }
        
        # yandex_storage_bucket.diplom_bucket will be created
        + resource "yandex_storage_bucket" "diplom_bucket" {
            + access_key            = (known after apply)
            + bucket                = "kirsanov-diplom_bucket"
            + bucket_domain_name    = (known after apply)
            + default_storage_class = (known after apply)
            + folder_id             = (known after apply)
            + force_destroy         = false
            + id                    = (known after apply)
            + secret_key            = (sensitive value)
            + website_domain        = (known after apply)
            + website_endpoint      = (known after apply)
          }
        
        # yandex_ydb_database_serverless.diplom-ydb will be created
        + resource "yandex_ydb_database_serverless" "diplom-ydb" {
            + created_at            = (known after apply)
            + database_path         = (known after apply)
            + deletion_protection   = false
            + document_api_endpoint = (known after apply)
            + folder_id             = (known after apply)
            + id                    = (known after apply)
            + location_id           = "ru-central1"
            + name                  = "diplom-ydb"
            + sleep_after           = 0
            + status                = (known after apply)
            + tls_enabled           = (known after apply)
            + ydb_api_endpoint      = (known after apply)
            + ydb_full_endpoint     = (known after apply)
        
            + serverless_database {
                + enable_throttling_rcu_limit = false
                + provisioned_rcu_limit       = (known after apply)
                + storage_size_limit          = 1
                + throttling_rcu_limit        = (known after apply)
              }
          }
        
      Plan: 6 to add, 0 to change, 0 to destroy.
        
      Changes to Outputs:
        + access_key = (sensitive value)
        + dynamodb   = (sensitive value)
        + secret_key = (sensitive value)
        
      ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────    ──────────────────────────────────────────────────── 
        
      Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
    </details>
