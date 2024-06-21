locals {
  labels = {
    owner    = var.owner
    division = var.division
    org      = var.org
    team     = var.team
    project  = var.project
  }
}

terraform {
  backend "gcs" {
    bucket = "my-bucket"
    prefix = "terraform/gcp/workstations/cluster-01"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  default_labels = local.labels
}

# reference to the google provider configuration
data "google_client_config" "default" {}

resource "google_compute_network" "default" {
  name                    = "workstation-cluster-01"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name          = "workstation-cluster-01"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.default.name
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/workstations_workstation_cluster
resource "google_workstations_workstation_cluster" "default" {
  provider                = google-beta
  project = data.google_client_config.default.project
  workstation_cluster_id = "workstation-cluster-01"
  network                = google_compute_network.default.id
  subnetwork             = google_compute_subnetwork.default.id
  location               = var.region
  labels = local.labels
  # https://cloud.google.com/workstations/docs/configure-vpc-service-controls-private-clusters#enable_private_cluster_connectivity
  # private_cluster_config {
  #   enable_private_endpoint = true
  # }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/workstations_workstation_config
resource "google_workstations_workstation_config" "default" {
  provider               = google-beta
  project = data.google_client_config.default.project
  workstation_config_id  = "workstation-config-01"
  workstation_cluster_id = google_workstations_workstation_cluster.default.workstation_cluster_id
  location                    = var.region
  idle_timeout = "7200s"
  running_timeout = "28800s"
  host {
    gce_instance {
      machine_type                = "e2-standard-4"
      boot_disk_size_gb           = 35
      # Only if tou have a Private Google Access or set up a NAT to allow pulling system images on your workstation VMs
      # disable_public_ip_addresses  = true
      # only on a2-*, n1-*, and n2-* machine types
      # enable_nested_virtualization = true
    }
  }
  labels = local.labels
  container {
    image = "docker.io/kuisathaverat/code-oss-git:main"
    # image = "us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest"
    env = {
      CLOUD_WORKSTATIONS_CONFIG_DISABLE_SUDO = "false"
    }
  }

  # persistent_directories {
  #   mount_path = "/home"
  #   gce_pd {
  #     size_gb        = 200
  #     fs_type        = "ext4"
  #     disk_type      = "pd-standard"
  #     reclaim_policy = "DELETE"
  #   }
  # }
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/workstations_workstation
resource "google_workstations_workstation" "default" {
  provider               = google-beta
  project = data.google_client_config.default.project
  workstation_id         = "workstation-01"
  workstation_config_id  = google_workstations_workstation_config.default.workstation_config_id
  workstation_cluster_id = google_workstations_workstation_cluster.default.workstation_cluster_id
  location                    = var.region

  labels = local.labels

  env = {
    name = "test env var"
  }
}
