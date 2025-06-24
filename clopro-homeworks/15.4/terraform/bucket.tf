
# //
# // Create KMS Symmetric Key.
# //
# resource "yandex_kms_symmetric_key" "key-a" {
#   name              = "hw-kms"
#   description       = "hw-kms"
#   default_algorithm = "AES_128"
#   rotation_period   = "8760h" // equal to 1 year
# }
# resource "yandex_storage_bucket" "hw_bucket" {
#   bucket                = "kirsanov-hw-bucket"
#   folder_id             = var.folder_id
#   max_size              = 1024000
#   default_storage_class = "COLD"
#   anonymous_access_flags {
#     read        = true
#     list        = true
#     config_read = true
#   }
#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         kms_master_key_id = yandex_kms_symmetric_key.key-a.id
#         sse_algorithm     = "aws:kms"
#       }
#     }
#   }
# }
# resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
#   service_account_id = var.service_account_id
#   description        = "static access key for object storage"
# }
# resource "yandex_storage_object" "test-object" {
#   access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#   secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#   bucket     = yandex_storage_bucket.hw_bucket.bucket
#   key        = "1.jpg"
#   source     = "1.jpg"
# }
