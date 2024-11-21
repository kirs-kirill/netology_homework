output "instances" {
  value = concat([
      for vm in yandex_compute_instance.web : {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ],
    [
      for vm in yandex_compute_instance.foreach_vms :{
        name = vm["name"],
        id   = vm["id"],
        fqdn = vm["fqdn"]
      }
    ]
  )
}