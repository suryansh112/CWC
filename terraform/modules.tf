module "eks"{
    source = "./eks"
    cluster_role = var.cluster_role
    node_role = var.node_role
    cluster_name = var.cluster_name
    instance_types = var.instance_types
    node_group_name = var.node_group_name
    subnet_id = var.subnet_id

}