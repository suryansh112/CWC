module "eks"{
    source = "./eks"
    cluster_role = var.cluster_role
    node_role = var.node_role
    cluster_name = var.cluster_name
    instance_types = var.instance_types
    node_group_name = var.node_group_name
    role = var.role
    subnet_id = var.subnet_id

}
module "alb"{
    source = "./alb"
    github_workspace = var.github_workspace
    region = var.region
    cluster_name = var.cluster_name
    federated_arn = module.eks.federated_arn
    node = module.eks.node_group_name
    endpoint = module.eks.endpoint
    vpc_id = var.vpc_id
}

module "asg"{
    source = "./asg"
    github_workspace = var.github_workspace
    region = var.region
    cluster_name = var.cluster_name
    federated_arn = module.eks.federated_arn
    node = module.eks.node_group_name
    endpoint = module.eks.endpoint
    oidc_provider = module.eks.oidc_url
    
}

module "argocd" {
    source = "./argocd"
    endpoint = module.eks.endpoint
    node = module.eks.node_group_name
}