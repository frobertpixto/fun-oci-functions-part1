# Document Generator Pre-Built Function uses a Bucket to read its inputs and write its output
# By default, a Function has no privileges.
# Allow our created Function to read and write any bucket of our dedicated compartment.

resource "oci_identity_policy" "fn_policy" {
    compartment_id = var.compartment_ocid
    description = "Allow a specific Document Generator Function to use Buckets"
    name = "fun_oci_functions_policy"
    statements = [
      "allow any-user to manage objects in compartment ${data.oci_identity_compartment.fn_compartment.name} where any { request.principal.id = '${oci_functions_function.fun_oci_function_document_generator.id}'}"
    ]
}