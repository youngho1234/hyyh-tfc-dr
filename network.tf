resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet
  ip_cidr_range = "10.0.1.0/24"
  network       = "vpc-hyyh"

  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = "0.5"
  }
}

#resource "google_service_networking_connection" "db_connection" {
#  network                 = "vpc-hyyh"
#  service                 = "servicenetworking.googleapis.com"
#  reserved_peering_ranges = [google_compute_global_address.ip_db_address.name]

#  depends_on = [google_compute_global_address.ip_db_address]
#}
