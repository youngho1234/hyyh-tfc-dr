resource "google_compute_global_address" "ip_ingress_address" {
  name = var.ip_ingress_address
}

resource "google_compute_global_address" "ip_db_address" {
 name = var.ip_db_address

 purpose       = "VPC_PEERING"
 address_type  = "INTERNAL"
 prefix_length = 20
 network       = "vpc-hyyh"
}
