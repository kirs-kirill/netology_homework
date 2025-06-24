

# resource "yandex_mdb_mysql_cluster" "hw_cluster" {
#   name        = "netology-cluster"
#   environment = "PRESTABLE"
#   network_id  = yandex_vpc_network.hw-net.id
#   version     = "8.0"

#   resources {
#     resource_preset_id = "b1.medium"
#     disk_type_id       = "network-ssd"
#     disk_size          = 20
#   }

#   maintenance_window {
#     type = "ANYTIME"
#   }
#   backup_window_start{
#     hours = 23
#     minutes = 59
#   }
#   host {
#     zone      = "ru-central1-a"
#     subnet_id = yandex_vpc_subnet.private-a.id
#   }
#   host {
#     zone      = "ru-central1-b"
#     subnet_id = yandex_vpc_subnet.private-b.id
#   }
# }

# resource "yandex_mdb_mysql_database" "hw_db" {
#   cluster_id = yandex_mdb_mysql_cluster.hw_cluster.id
#   name       = "netology_db"
# }

# resource "yandex_mdb_mysql_user" "hw_user" {
#   cluster_id = yandex_mdb_mysql_cluster.hw_cluster.id
#   name       = "netology"
#   password   = "netology"

#   permission {
#     database_name = yandex_mdb_mysql_database.hw_db.name
#     roles         = ["ALL"]
#   }

#   connection_limits {
#     max_questions_per_hour   = 10
#     max_updates_per_hour     = 20
#     max_connections_per_hour = 30
#     max_user_connections     = 40
#   }

#   global_permissions = ["PROCESS"]

#   authentication_plugin = "SHA256_PASSWORD"
# }