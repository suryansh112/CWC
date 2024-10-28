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
variable "federated_url"{
    type =  string
    sensitive = true
}
variable "endpoint"{
    type = string 
    sensitive = true
}