provider "google" {
    credentials = file (var.cloud_key)
    project = var.project_id
    region = var.region
}