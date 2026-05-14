provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_project_service" "services" {
  for_each = toset([
    "container.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "compute.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "iam.googleapis.com",
  ])
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}


module "artifact_registry" {
  source     = "./artifact-registry"
  project_id = var.project_id
  region     = var.region
  repo_name  = var.artifact_repo_name

  depends_on = [google_project_service.services]
}

module "gke" {
  source       = "./gke"
  project_id   = var.project_id
  region       = var.region
  cluster_name = var.cluster_name

  depends_on = [google_project_service.services]
}





