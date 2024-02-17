region         = "eu-frankfurt-1"       # TODO: update here
compartment_id = "ocid1.tenancy.oc1..." # TODO: update here
prefix         = "evcode"               # TODO: update here

networks = {
  web_server = {
    name = "web"
    cidr = "10.0.1.0/24"
    subnets = {
      public = {
        name = "public_web"
        cidr = "10.0.1.0/28"
      }
    }
  }
}