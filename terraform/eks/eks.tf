resource "aws_eks_cluster" "mycluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role


  vpc_config {
    subnet_ids = [var.subnet_id]
  }

}

resource "aws_eks_node_group" "mynodegroup" {

  cluster_name    = aws_eks_cluster.mycluster.name
  node_group_name = var.node-group-name
  node_role_arn   = var.node_role
  subnet_ids      = [var.subnet_id]

  instance_types = [var.instance_types]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2

  }

  update_config {
    max_unavailable = 1
  }

}