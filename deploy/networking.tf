// Creating VPC network
resource "google_compute_network" "default" {
  name                    = var.network-name
  auto_create_subnetworks = "false"
}

// Creating VPC subnetwork
resource "google_compute_subnetwork" "default" {
  name                     = "${var.network-name}-subnet"
  ip_cidr_range            = var.network-ip-cidr-range
  network                  = google_compute_network.default.self_link

  region                   = var.region
  private_ip_google_access = true
}
