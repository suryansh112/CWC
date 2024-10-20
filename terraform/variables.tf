variable "region" {
    default = "us-east-1"
  
}
variable "role" {
    type = string
    sensitive = true
}
variable "subnet_id" {
    type = set
    default = ["subnet-02061f395d0505b4f","subnet-09e00b2fbe4cf8db0"]
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
variable "node_group_name"{
    default = "my-node-group"
}