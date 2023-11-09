resource "google_compute_router" "router" {
  name    = "${var.app_name}-router"
  region  = var.region
  network = module.vpc.network_name
}