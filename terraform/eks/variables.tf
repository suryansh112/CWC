variable "node_group_name"{
    type = string
}
variable "cluster_role" {
  type = string
}
variable "node_role"{
    type = string
}
variable "subnet_id" {
    type = list(string)
}
variable "cluster_name"{
    type = string
}
variable "instance_types"{
    type = string
}
variable "role" {
    type = string
    sensitive = true
}