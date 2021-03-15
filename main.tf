variable "gcp_credentials" {}

variable "gcp_project_id" {
  default = "sup-eng-eu"
}

provider "google" {

  credentials = var.gcp_credentials

  # Should be able to parse project from credentials file but cannot.
  # Cannot convert string to map and cannot interpolate within variables.
  project = var.gcp_project_id

}

resource "google_cloud_run_service" "resource_tfc" {
  name     = "cloudrun-srv2"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
