provider "oci" {
  region              = var.region
  auth                = "SecurityToken"
  config_file_profile = "podcast-evcode"
}
