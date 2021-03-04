terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
      version = "3.1.0"
    }
  }
}

provider "nsxt" {
  host                  = "192.168.110.15"
  username              = "admin"
  password              = "VMware1!VMware1!"
  allow_unverified_ssl  = true
  max_retries           = 10
  retry_min_delay       = 500
  retry_max_delay       = 5000
  retry_on_status_codes = [429]
}

resource "nsxt_policy_group" "VDI" {
  nsx_id       = "VDI"
  display_name = "VDI"
  criteria {
    condition {
      member_type = "Segment"
      key         = "Tag"
      operator    = "EQUALS"
      value       = "zone|vdi"
    }
  }
  conjunction {
    operator = "OR"
  }
  criteria {
    condition {
      key         = "Name"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "win10-01a"
    }
  }
}
