# provider "oci" {
#   region = var.region
# }

provider "oci" {
  auth = "SecurityToken"
  config_file_profile = "GC35302"
  region = var.region
}