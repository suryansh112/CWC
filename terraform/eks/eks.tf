resource "aws_eks_cluster" "mycluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role
  
  vpc_config {
    subnet_ids = var.subnet_id
  }
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

}

resource "aws_eks_node_group" "mynodegroup" {

  cluster_name    = aws_eks_cluster.mycluster.name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role
  subnet_ids      = var.subnet_id

  instance_types = [var.instance_types]
  scaling_config {
    desired_size = 4
    max_size     = 5
    min_size     = 2

  }

  update_config {
    max_unavailable = 1
  }

}