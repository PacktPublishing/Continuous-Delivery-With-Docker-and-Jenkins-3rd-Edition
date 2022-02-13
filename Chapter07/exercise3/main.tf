provider "google" {
  project = "<your-gcp-project>"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

resource "google_compute_instance" "my_instance" {
  name         = "my_instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20220204"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}