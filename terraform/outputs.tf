# output.tf is used to output IP-addresses for virtual machines. This will be used to connect to them
# Public IP-address for master-node
output "k8s_master_public_ip" {
  description = "Public IP address of the Kubernetes master node"
  value       = google_compute_instance.k8s-master.network_interface.0.access_config.0.nat_ip
}

# Public IP-address for worker-node
output "k8s_worker_public_ip" {
  description = "Public IP address of the Kubernetes worker node"
  value       = google_compute_instance.k8s-worker.network_interface.0.access_config.0.nat_ip
}

# Internal IP-address for master-node
output "k8s_master_private_ip" {
  description = "Private IP address of the Kubernetes master node"
  value       = google_compute_instance.k8s-master.network_interface.0.network_ip
}

# Internal IP-address for worker-node
output "k8s_worker_private_ip" {
  description = "Private IP address of the Kubernetes worker node"
  value       = google_compute_instance.k8s-worker.network_interface.0.network_ip
}

# Network name output
output "k8s_network_name" {
  description = "Name of the created network"
  value       = google_compute_network.k8s-network.name
}

# Sub-network name output
output "k8s_subnet_name" {
  description = "Name of the created subnet"
  value       = google_compute_subnetwork.k8s-subnet.name
}

