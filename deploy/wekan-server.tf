resource "google_compute_disk" "wekan-disk" {
  project = var.project-id
  name  = "wekan-disk"
  type  = var.disk-type
  zone  = var.zone
  size = var.disk-size

  labels = {
    environment = "dev"
  }
}


//creating VM instance for Wekan
resource "google_compute_instance" "wekan-server" {
  name         = var.wekan-hostname
  machine_type = var.wekan-machine-type
  zone         = var.zone
  project      = var.project-id
  allow_stopping_for_update = true
  
  depends_on = [google_compute_network.default, google_compute_subnetwork.default,]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  attached_disk {
      source      = google_compute_disk.wekan-disk.self_link
      device_name = google_compute_disk.wekan-disk.name
   }

  service_account {
        scopes = ["cloud-platform"]
    }
  network_interface {  
    network            = google_compute_network.default.name
    subnetwork         = google_compute_subnetwork.default.name
    access_config { 
    } // uncomment to generate ephemeral external IP
  }

  lifecycle {
    ignore_changes = [attached_disk]
  }

   metadata_startup_script =   <<EOF
        touch test.txt

        EOF
}
