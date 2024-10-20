variable "region" {
    default = "us-east-1"
  
}
variable "role" {
    type = string
    sensitive = true
}
variable "subnet_id" {
    default = "subnet-02061f395d0505b4f"
}
variable "instance_types"{
    default = "t2.micro"
}
variable "cluster_name"{
    default = "my-cluster"
}
variable "cluster_role"{
    type = string
    sensitive = true
}
variable "node_role"{
    type = string
    sensitive = true
}
