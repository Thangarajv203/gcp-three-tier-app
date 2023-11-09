terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.4.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "5.4.0"
    }
  }

  # backend "gcs" {
  #   bucket = "tf-state-sandbox"
  #   prefix = "terraform/state"
  # }
}

provider "google" {
  # Configuration options
  project     = var.project_id
  region      = var.region
  credentials = file("C:\\tf-works_space\\GCP\\local-files\\Keys.json")
}

provider "google-beta" {
  # Configuration options
  project     = var.project_id
  region      = var.region
  credentials = file("C:\\tf-works_space\\GCP\\local-files\\Keys.json")
}
