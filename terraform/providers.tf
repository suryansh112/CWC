terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.61.0"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

provider "aws" {
    region = var.region
}
provider "helm" {
  kubernetes {
    host                   = module.eks.endpoint
    cluster_ca_certificate = base64decode(module.eks.kubeconfig-certificate-authority-data)
    token                  = module.eks.token
  }
}