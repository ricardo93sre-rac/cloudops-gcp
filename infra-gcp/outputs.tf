output "gke_cluster_name" {
  value = module.gke.cluster_name
}

output "gke_cluster_region" {
  value = module.gke.region
}

output "artifact_repo_repo" {
  value = module.artifact_registry.repository_url
}

