 // Provisioning resources required for wekan
provider "google" {
  #credentials = "${file("./account.json")}"
  project     = var.project-id
  region      = var.region
  zone        = var.zone
}