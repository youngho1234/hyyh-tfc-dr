resource "google_compute_instance" "vm_bastion" {
  name         = var.bastion
  machine_type = var.vm_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = "vpc-hyyh"
    subnetwork = google_compute_subnetwork.subnet.name
  }

  tags = [var.firewall_ssh]

  service_account {
    scopes = ["cloud-platform"]
  }

  lifecycle {
    ignore_changes = all
  }

  depends_on = [google_compute_router.nat_router, google_container_cluster.cluster_prod]
}
