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
        if [[ ! -f /opt/startup-script-finished.txt ]]
        then 
          
          apt-get update
          mkdir -p /mnt/disks/wekan-repo
          disk_name="/dev/$(basename $(readlink /dev/disk/by-id/google-${google_compute_disk.wekan-disk.name}))"
          mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard $disk_name
          mount -o discard,defaults $disk_name /mnt/disks/wekan-repo
          sleep 2
          echo UUID=$(sudo blkid -s UUID -o value $disk_name) /mnt/disks/wekan-repo ext4 discard,defaults,nofail 0 2 | sudo tee -a /etc/fstab

          sudo apt-get install nginx -y
          sudo systemctl start nginx
          sudo snap install wekan
          sudo snap set wekan root-url="http://${var.wekan-hostname}"
          sudo snap set wekan port=${var.wekan-web-port}
          sudo systemctl restart snap.wekan.mongodb
          sudo systemctl restart snap.wekan.wekan

        touch /opt/startup-script-finished.txt && echo "the startup script run once" > /opt/startup-script-finished.txt
        fi
        touch /tmp/test.txt
        EOF
}
