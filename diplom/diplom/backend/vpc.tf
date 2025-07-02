resource "yandex_vpc_network" "diplom_network" {
  name      = "diplom-network"
  folder_id = var.folder_id
}

resource "yandex_vpc_subnet" "subnet" {
  for_each       = { for k, v in var.networks_zone : k => v }
  v4_cidr_blocks = each.value.cidr
  zone           = each.value.zone
  name           = each.value.name
  network_id     = yandex_vpc_network.diplom_network.id
}
