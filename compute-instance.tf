module "vm_instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "10.1.1"
  
  #network       = module.vpc.network_name
  subnetwork = module.vpc.subnets_self_links[0]
  machine_type = "e2-medium"
  disk_size_gb = "10"
  source_image_family = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20231101"

  service_account = {
    email= "176569526072-compute@developer.gserviceaccount.com",
    scopes = [
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring.write",
        "https://www.googleapis.com/auth/devstorage.read_write"
    ]
  }

  tags = ["react-app"]
  labels = {
    name = "${var.app_name}-it"
  }
}

module "vm_compute_instance" {
  source  = "terraform-google-modules/vm/google//modules/compute_instance"
  version = "10.1.1"

  
  num_instances = 1
  region        = var.region

  instance_template = module.vm_instance_template.self_link

  labels = {
    name = "${var.app_name}-vm"
  }
}