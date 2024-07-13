# Functions are in Applications 
# Create the application 
resource "oci_functions_application" "fun_oci_functions_app" {
  compartment_id = var.compartment_ocid
  config = {
  }
  display_name = "fun_oci_functions_app"
  shape = "GENERIC_X86"
  subnet_ids = [
    var.vcn_subnet_ocid,
  ]
  syslog_url = ""
  trace_config {
    domain_id  = ""
    is_enabled = "false"
  }
}

# Activate OCI Logging. All Functions of this App will use the same Log.
# Create an OCI Log Group 
resource "oci_logging_log_group" "app_log_group" {
  compartment_id = var.compartment_ocid
  display_name   = "app_log_group"
}

# Create an OCI Log
resource "oci_logging_log" "app_log" {
  log_group_id    = oci_logging_log_group.app_log_group.id
  log_type        = "SERVICE"
  is_enabled      = true
  display_name    = "app_log"
  configuration {
    compartment_id = var.compartment_ocid
    source {
      resource    = oci_functions_application.fun_oci_functions_app.id
      category    = "invoke"
      service     = "functions"
      source_type = "OCISERVICE"
    }
  }
}


# Get the Pre-Built Function Listing of Document Generator
# This is equivalent to the statement: List all Pre-Built Function Listings where the name = "Document Generator"
data "oci_functions_pbf_listings" "pbf_listing_api" {
  name = "Document Generator"
}

locals {
  # There should be 1 collection with 1 list of PBF Listings
  document_generator_pbf_listing_id = data.oci_functions_pbf_listings.pbf_listing_api.pbf_listings_collection[0].items[0].id
}

output "document_generator_listing_id" {
  value = local.document_generator_pbf_listing_id
}

# Create a Document Generator Pre-Built Function 
resource "oci_functions_function" "fun_oci_function_document_generator" {
  application_id = oci_functions_application.fun_oci_functions_app.id
  config = {
  }
  display_name = "fun_oci_function_document_generator"
  memory_in_mbs = "1024"
  provisioned_concurrency_config {
    strategy = "NONE"
  }
  source_details {
    pbf_listing_id = local.document_generator_pbf_listing_id
    source_type    = "PRE_BUILT_FUNCTIONS"
  }
  timeout_in_seconds = "300"
  trace_config {
    is_enabled = false
  }
}

output "document_generator_fn_ocid" {
  value = oci_functions_function.fun_oci_function_document_generator.id
}
