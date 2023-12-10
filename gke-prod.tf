resource "google_container_cluster" "cluster_prod" {
  name               = var.cluster_prod
  location           = var.region
  initial_node_count = 1
  network            = "vpc-hyyh"
  subnetwork         = google_compute_subnetwork.subnet.name
  logging_service    = "logging.googleapis.com/kubernetes"
  enable_autopilot   = true

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
  }

  vertical_pod_autoscaling {
    enabled = true
  }

  ip_allocation_policy {
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"

    master_global_access_config {
      enabled = false
    }
  }

  master_authorized_networks_config {
    cidr_blocks {
      display_name = "allowed-network"
      cidr_block   = "10.0.1.0/24"
    }
  }

  node_config {
    oauth_scopes = ["cloud-platform"]
    machine_type = var.prod_type
    disk_type    = "pd-balanced"
    disk_size_gb = "10"
  }

  deletion_protection = false

  lifecycle {
    ignore_changes = all
  }

  depends_on = [google_compute_subnetwork.subnet]
}
