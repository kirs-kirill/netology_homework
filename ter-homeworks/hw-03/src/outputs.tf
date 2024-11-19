output "info" {
  value = ["instance_name: ${yandex_compute_instance.count_vms[0].name}",[
    "external_ip:  ${yandex_compute_instance.count_vms[0].network_interface[0].nat_ip_address}",
  "fqdn: ${yandex_compute_instance.count_vms[0].fqdn}"],
  "ssh ubuntu@${yandex_compute_instance.count_vms[0].network_interface[0].nat_ip_address}"
  ]
}