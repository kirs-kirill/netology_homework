# //
# // Create a new Managed Kubernetes regional Cluster.
# //
# data "yandex_iam_service_account" "diplom" {
#   name = "diplom"
# }

# resource "yandex_kubernetes_cluster" "diplom_cluster" {
#   name        = "diplom"
#   description = "diplom_cluster"
#   service_account_id = data.yandex_iam_service_account.diplom.id
#   node_service_account_id = data.yandex_iam_service_account.diplom.id

#   network_id = yandex_vpc_network.diplom_network.id
#   master {
#     regional {
#       region = "ru-central1"
#       dynamic "location" {
#         for_each = yandex_vpc_subnet.subnet
#         content {
#           zone      = location.value.zone
#           subnet_id = location.value.id
#         }
#       }
#     }

#     version   = "1.30"
#     public_ip = true

#     # maintenance_policy {
#     #   auto_upgrade = true

#     #   maintenance_window {
#     #     day        = "monday"
#     #     start_time = "15:00"
#     #     duration   = "3h"
#     #   }

#     #   maintenance_window {
#     #     day        = "friday"
#     #     start_time = "10:00"
#     #     duration   = "4h30m"
#     #   }
#     # }

# #     master_logging {
# #       enabled                    = true
# #       folder_id                  = var.folder_id
# #       kube_apiserver_enabled     = true
# #       cluster_autoscaler_enabled = true
# #       events_enabled             = true
# #       audit_enabled              = true
# #     }
#   }



# #   labels = {
# #     my_key       = "my_value"
# #   }

#   release_channel = "STABLE"
# }
