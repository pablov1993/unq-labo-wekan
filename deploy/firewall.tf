resource "google_compute_firewall" "allow-internal" {
    
    name    = "allow-internal"
    network = "${google_compute_network.default.name}"

    allow { 
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
        ports    = ["0-65535"]
    }

    allow {
        protocol = "udp"
        ports    = ["0-65535"]
    }

    source_ranges = [
        "${google_compute_subnetwork.default.ip_cidr_range}"
    ]
}


resource "google_compute_firewall" "allow-http" {
    
    name    = "allow-http"
    network = "${google_compute_network.default.name}"

    allow {
        protocol = "tcp"
        ports    = ["8080"]
    }

    source_ranges = [
        "0.0.0.0/0"
    ]

    
}


resource "google_compute_firewall" "allow-iap-ssh-ingress" {
    
    name    = "allow-iap-ssh-ingress"
    network = "${google_compute_network.default.name}"

    allow {
        protocol = "tcp"
        ports    = ["22"]
    }

    source_ranges = [
        "35.235.240.0/20"
    ]
}
