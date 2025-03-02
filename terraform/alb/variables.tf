variable "github_workspace"{
    type =  string
    sensitive = false
}
variable "region"{
    type =  string
    sensitive = false
}
variable "cluster_name"{
    type =  string
    sensitive = false
}
variable "federated_arn"{
    type =  string
    sensitive = false
}
variable "endpoint"{
    type = string 
    sensitive = true
}

variable "node" {
    type = string
    sensitive = false
}

variable "vpc_id" {
    type = string
    sensitive = false
}

output "alb_name" {
  value = helm_release.alb_ingress_controller.name
}