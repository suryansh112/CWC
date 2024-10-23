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
    host                   = aws_eks_cluster.my_cluster.endpoint
    cluster_ca_certificate = base64decode(var.cluster_name.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.my_cluster.token
  }
}