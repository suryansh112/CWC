variable "region" {
    default = "us-east-1"
  
}
variable "role" {
    type = string
    sensitive = true
}
/*variable "subnet_id" {
    type = list(string)
    default = ["subnet-02061f395d0505b4f","subnet-09e00b2fbe4cf8db0"]
}*/
variable "subnet_id" {
    type = list(string)
    default = ["subnet-02cd9e697ce947584","subnet-08695bfa27c62732b"]
}

variable "vpc_id" {
    type = string
    default = "vpc-0b893daaed374320c"
}

variable "instance_types"{
    default = "t2.medium"
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
variable "github_workspace"{
    type = string
}