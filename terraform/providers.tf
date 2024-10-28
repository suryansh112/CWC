terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.61.0"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes ={
      source = "hashicorp/kubernetes"
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
provider "kubernetes" {
  host                   = module.eks.endpoint
  token                  = module.eks.token
  cluster_ca_certificate = base64decode(module.eks.kubeconfig-certificate-authority-data)
}