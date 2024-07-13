variable region { 
    default = "us-ashburn-1" 
}

variable compartment_ocid {
    description  = "OCID of the compartment to use"
}

data "oci_identity_compartment" "fn_compartment" {
  id = var.compartment_ocid
}

# Output the compartment name
output "compartment_name" {
  value = data.oci_identity_compartment.fn_compartment.name
}

variable vcn_subnet_ocid {
    description  = "OCID of the Network subnet that will be used by the Application"
}


