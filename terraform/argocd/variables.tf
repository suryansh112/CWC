variable "endpoint"{
    type = string 
    sensitive = true
}
variable "node" {
    type = string
    sensitive = false
}
variable "alb_name" {
    type = string
    sensitive = false
}