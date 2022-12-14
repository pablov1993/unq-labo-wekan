variable "project-id" {
    description = "The GCP project to use for integration tests"
    type        = string
    default     = "unq-labo"
}

variable "region" {
    description = "The GCP region to create and test resources in"
    type        = string
    default     = "southamerica-west1"
}

variable "zone" {
    description = "The GCP zone to create and test resources in"
    type        = string
    default     = "southamerica-west1-b"
}

variable "disk-type" {
    description = "The GCP disk type. Example: pd-standard"
    type        = string
    default     = "pd-ssd"
}

variable "disk-size" {
    description = "The GCP disk size specified in GB"
    type        = string
    default     = "30"
}

variable "image" {
    description = "Source disk image."
    type        = string
    default     = "ubuntu-1804-bionic-v20221018" 
}

variable "wekan-machine-type" {
    description = "Instance machine type"
    type        = string
    default     = "n2-standard-2"
}


variable "network-name" {
    description = "VPC network name"
    type        = string
    default     = "labo-network"
}

variable "network-ip-cidr-range" {
    description = "VPC subnetwork IP range"
    type        = string
    default     = "10.138.0.0/20"
}

variable "wekan-hostname"{
    description = "Wekan VM hostname"
    type        = string
    default     = "wekan"

}

variable "wekan-web-port"{
    description = "Default web port for wekan"
    type        = string
    default     = "8080"

}




