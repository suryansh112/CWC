resource "aws_eks_cluster" "mycluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role
  enabled_cluster_log_types = ["api","audit","authenticator","controllerManager","scheduler"]
  depends_on = [aws_cloudwatch_log_group.eks-cluster]
  
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
    desired_size = 2
    max_size     = 3
    min_size     = 2

  }

  update_config {
    max_unavailable = 1
  }

}
resource "aws_cloudwatch_log_group" "eks-cluster" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7

}
/*resource "aws_eks_addon" "cwc-addon" {
  cluster_name = aws_eks_cluster.mycluster.name
  addon_name   = "amazon-cloudwatch-observability"
}*/