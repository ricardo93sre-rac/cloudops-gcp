variable "project_id" {
  type = string

}

variable "region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "artifact_repo_name" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "impersonate_service_account" {
  type    = string
  default = ""

}