# resource "yandex_lb_network_load_balancer" "hw-loadbalancer" {
#   name = "hw-loadbalancer"

#   listener {
#     name = "hw-loadbalancer-listener"
#     port = 80
#     external_address_spec {
#       ip_version = "ipv4"
#     }
#   }

#   attached_target_group {
#     target_group_id = yandex_compute_instance_group.hw-group.load_balancer.0.target_group_id

#     healthcheck {
#       name = "http"
#       http_options {
#         port = 80
#         path = "/index.html"
#       }
#     }
#   }
# }