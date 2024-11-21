resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",

    {
      webservers = yandex_compute_instance.web,
      databases  = yandex_compute_instance.foreach_vms,
      storage = [yandex_compute_instance.storage]
  })

  filename = "${abspath(path.module)}/hosts.ini"
}