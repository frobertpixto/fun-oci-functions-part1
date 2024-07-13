## Create a Docker Container Repository

resource "oci_artifacts_container_configuration" "container_configuration" {
  compartment_id                      = var.compartment_ocid
  is_repository_created_on_first_push = true
}

resource "oci_artifacts_container_repository" "fun_oci_functions_repo" {
  compartment_id  = var.compartment_ocid
  display_name    = "fun_oci_functions_repo"
  is_immutable    = false
  is_public       = false
}

