# This is the main terraform file. In here we describe provider data (keys, project ID, region, zone), create a network, firewall rules, nodes and virtual machines
# Provider description
provider "google" {
  credentials = file(var.gcp_credentials_file)
  project     = var.gcp_project_id
  region      = var.gcp_region
  zone        = var.gcp_zone
}

# Creating network
resource "google_compute_network" "k8s-network" {
  name                    = "k8s-network"
  auto_create_subnetworks = false
}

# Sub-network
resource "google_compute_subnetwork" "k8s-subnet" {
  name          = "k8s-subnet"
  ip_cidr_range = "192.168.10.0/24"
  region        = var.gcp_region
  network       = google_compute_network.k8s-network.id
}

# Creating firewall rules for Kubernetes
resource "google_compute_firewall" "k8s-firewall" {
  name    = "k8s-firewall"
  network = google_compute_network.k8s-network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "6443", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Virtual machine for Kubernetes master-node
resource "google_compute_instance" "k8s-master" {
  name         = "k8s-master"
  machine_type = "e2-medium"
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 20
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.name
    access_config {
      # Публичный IP-адрес
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

# Virtual machine for Kubernetes worker-node
resource "google_compute_instance" "k8s-worker" {
  name         = "k8s-worker"
  machine_type = "e2-medium"
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 20
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.k8s-subnet.name
    access_config {
      # Публичный IP-адрес
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

# IP-address output
output "k8s_master_public_ip" {
  value = google_compute_instance.k8s-master.network_interface.0.access_config.0.nat_ip
}

output "k8s_worker_public_ip" {
  value = google_compute_instance.k8s-worker.network_interface.0.access_config.0.nat_ip
}
