output "out" {
  description = "Public VM's IP address"
  value = ["instance_name: ${yandex_compute_instance.public.name}",[
    "external_ip:  ${yandex_compute_instance.public.network_interface[0].nat_ip_address}",
    "internal_ip:  ${yandex_compute_instance.public.network_interface[0].ip_address}",
  "zone: ${yandex_compute_instance.public.zone}",
  "fqdn: ${yandex_compute_instance.public.fqdn}"],
  "instance_name: ${yandex_compute_instance.private.name}",[
    "external_ip:  ${yandex_compute_instance.private.network_interface[0].nat_ip_address}",
    "internal_ip:  ${yandex_compute_instance.private.network_interface[0].ip_address}",
  "zone: ${yandex_compute_instance.private.zone}",
  "fqdn: ${yandex_compute_instance.private.fqdn}"],
  "instance_name:    ${yandex_compute_instance.nat-instance.name}",[
    "external_ip:  ${yandex_compute_instance.nat-instance.network_interface[0].nat_ip_address}",
    "internal_ip:  ${yandex_compute_instance.nat-instance.network_interface[0].ip_address}",
    "zone: ${yandex_compute_instance.nat-instance.zone}",
    "fqdn: ${yandex_compute_instance.nat-instance.fqdn}"]
  ]
}