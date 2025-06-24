# resource "yandex_compute_instance_group" "hw-group" {
#   folder_id           = var.folder_id
#   service_account_id  = var.service_account_id
#   deletion_protection = false
#   instance_template {
#     platform_id = "standard-v1"
#     resources {
#       memory = 2
#       cores  = 2
#     }
#     boot_disk {
#       mode = "READ_WRITE"
#       initialize_params {
#         image_id = data.yandex_compute_image.lamp.id
#         size     = 20
#       }
#     }
#     network_interface {
#       nat        = true
#       network_id = yandex_vpc_network.hw-net.id
#       subnet_ids = ["${yandex_vpc_subnet.public.id}"]
#     }
#     labels = {
#       label1 = "label1-value"
#       label2 = "label2-value"
#     }
#     metadata = {
#       user-data = "${file("./data.txt")}"
#       ssh-keys  = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
#     }
#     network_settings {
#       type = "STANDARD"
#     }
#   }

#   scale_policy {
#     fixed_scale {
#       size = 3
#     }
#   }

#   allocation_policy {
#     zones = ["ru-central1-a"]
#   }

#   deploy_policy {
#     max_unavailable = 2
#     max_creating    = 2
#     max_expansion   = 2
#     max_deleting    = 2
#   }
#   health_check {
#     healthy_threshold = 3
#     http_options {
#       path = "/"
#       port = 80
#     }
#     interval = 10
#     timeout = 5
#     unhealthy_threshold = 2
#   }
#   load_balancer {
#     target_group_name        = "target-group"
#     target_group_description = "Целевая группа Network Load Balancer"
#   }
# }
