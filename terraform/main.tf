provider "yandex" {
  token     = "AQAAAAAPL2RiAATuwf2p8j3So01TmCkmP7GV7XQ"
  cloud_id  = "b1gjcabcuu2iqig18fnh"
  folder_id = "b1gaitl24uq20bhcooso"
  zone      = "ru-central1-a"
}
resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = "fd8bgk6i049mnjr4add1"
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = "e9bvhqah8bk7r97l9gag"
    nat       = true
  }
  metadata = {
  ssh-keys = "ubuntu:${file("~/.ssh/ubuntu.pub")}"
  }
}