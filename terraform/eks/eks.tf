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
    desired_size = 1
    max_size     = 5
    min_size     = 1

  }

  update_config {
    max_unavailable = 1
  }

}

resource "aws_cloudwatch_log_group" "eks-cluster" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7

}

resource "aws_iam_openid_connect_provider" "eksprovider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.mycert.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.mycluster.identity[0].oidc[0].issuer
}

resource "aws_eks_access_policy_association" "access" {
  cluster_name  = aws_eks_cluster.mycluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = var.role

  access_scope {
    type       = "cluster"
  }
}

resource "aws_eks_access_entry" "entry" {
  cluster_name      = aws_eks_cluster.mycluster.name
  principal_arn     = var.role
  type              = "STANDARD"
}

data "tls_certificate" "mycert" {
  url = aws_eks_cluster.mycluster.identity[0].oidc[0].issuer
}

data "aws_eks_cluster" "mycluster"{
  name = aws_eks_cluster.mycluster.name
}

data "aws_eks_cluster_auth" "mycluster" {
  name = var.cluster_name
}