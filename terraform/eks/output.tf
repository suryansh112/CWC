output "endpoint" {
  value = aws_eks_cluster.mycluster.endpoint
}

output "token"{
  value = data.aws_eks_cluster_auth.mycluster.token
  sensitive = true
}

output "federated_arn"{
  value = aws_iam_openid_connect_provider.eksprovider.arn
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.mycluster.certificate_authority[0].data
}