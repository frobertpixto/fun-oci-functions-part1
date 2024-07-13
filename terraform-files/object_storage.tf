# Document Generator Pre-Built Function uses a Bucket to read its inputs and write its output
# Define a new Bucket to use

data "oci_objectstorage_namespace" "the_namespace" {
  compartment_id = var.compartment_ocid
}

resource "oci_objectstorage_bucket" "fun_oci_functions_bucket" {
  access_type           = "NoPublicAccess"
  auto_tiering          = "Disabled"
  compartment_id        = var.compartment_ocid

  name                  = "fun_oci_functions_bucket"
  namespace             = data.oci_objectstorage_namespace.the_namespace.namespace
  object_events_enabled = true
  storage_tier          = "Standard"
  versioning            = "Disabled"
}

