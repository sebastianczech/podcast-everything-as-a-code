region         = "eu-frankfurt-1"       # TODO: update here
compartment_id = "ocid1.tenancy.oc1..." # TODO: update here
prefix         = "evcode"               # TODO: update here

networks = {
  web_server = {
    name   = "web"
    cidr   = "10.0.1.0/24"
    public = true
    peer   = "database"
    routes = {
      to_db = {
        name        = "to_db"
        destination = "10.0.2.0/24"
        type        = "local_peering_gateway_local"
      }
    }
    subnets = {
      public = {
        name = "public_web"
        cidr = "10.0.1.0/28"
      }
    }
    security = {
      egress = {
        default = {
          destination      = "0.0.0.0/0"
          protocol         = "all"
          destination_type = "CIDR_BLOCK"
          description      = "Allow all outgoing traffic"
        }
      }
      ingress = {
        ssh = {
          protocol     = 6
          source       = "0.0.0.0/0"
          source_type  = "CIDR_BLOCK"
          description  = "Allow all for SSH"
          tcp_port_min = 22
          tcp_port_max = 22
        }
        http = {
          protocol     = 6
          source       = "0.0.0.0/0"
          source_type  = "CIDR_BLOCK"
          description  = "Allow all for HTTP"
          tcp_port_min = 80
          tcp_port_max = 80
        }
        https = {
          protocol     = 6
          source       = "0.0.0.0/0"
          source_type  = "CIDR_BLOCK"
          description  = "Allow all for HTTPS"
          tcp_port_min = 443
          tcp_port_max = 443
        }
        icmp = {
          protocol    = 1
          source      = "0.0.0.0/0"
          source_type = "CIDR_BLOCK"
          description = "Allow some types of packets for ICMP"
          icmp_type   = 3
          icmp_code   = 4
        }
      }
    }
  }
  database = {
    name = "db"
    cidr = "10.0.2.0/24"
    routes = {
      to_web = {
        name        = "to_web"
        destination = "10.0.1.0/24"
        type        = "local_peering_gateway_remote"
      }
    }
    subnets = {
      private = {
        name = "private_db"
        cidr = "10.0.2.0/28"
      }
    }
    security = {
      egress  = {}
      ingress = {}
    }
  }
}

vms = {
  web_server = {
    name    = "web-server"
    az      = 1
    network = "web_server"
    subnet  = "public"
    public  = true
  }
  database = {
    name    = "database"
    az      = 1
    network = "database"
    subnet  = "private"
  }
}