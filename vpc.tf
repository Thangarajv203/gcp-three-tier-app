module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 8.0"

  project_id                             = var.project_id
  network_name                           = "${var.app_name}-vpc"
  routing_mode                           = "GLOBAL"
  delete_default_internet_gateway_routes = true

  subnets = [
    {
      subnet_name           = "private-01"
      subnet_ip             = "10.0.0.0/24"
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
      description           = ""
    },
    {
      subnet_name           = "private-02"
      subnet_ip             = "10.0.1.0/24"
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
      description           = ""
    },
    {
      subnet_name      = "private-03"
      subnet_ip        = "10.0.2.0/24"
      subnet_region    = var.region
      subnet_region    = "us-west1"
      subnet_flow_logs = "false"
      description      = ""
    }
  ]

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]

  ingress_rules = [
    {
      name          = "allow-8080"
      description   = ""
      source_ranges = ["0.0.0.0/0"]
      target_tags   = ["react-app"]
      allow = [{
        protocol = "tcp"
        ports    = ["8080"]
      }]
    },
    {
      name          = "cloud-iap-allow"
      description   = ""
      source_ranges = ["35.235.240.0/20"]
      target_tags   = ["react-app"]
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
    }
  ]
}