terraform {
  required_providers {
    xrcm = {
      source = "infinera.com/poc/xrcm"
    }
  }
}


provider "xrcm" {
  username = var.user
  password = var.password
  host     = var.host
}