resource "helm_release" "clusterautoscale" {
    name       = "cluster-autoscaler"
    repository = "https://kubernetes.github.io/autoscaler"
    chart      = "cluster-autoscaler"
    namespace  = "kube-system"
    depends_on = [var.endpoint,var.node,aws_iam_role.cluster_autoscale_role]

values = [
    <<EOF
    autoDiscovery:
      clusterName: ${var.cluster_name}
    awsRegion: ${var.region}
    rbac:
      serviceAccount:
        annotations:
          eks.amazonaws.com/role-arn: ${resource.aws_iam_role.cluster_autoscale_role.arn}
    EOF
  ]
  
}

resource "aws_iam_role" "cluster_autoscale_role" {
  name = "cluster-autoscaler-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      {
        Effect = "Allow"
        Principal = {
          Federated = var.federated_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
            StringEquals = {
                "${var.oidc_provider}:sub" = "system:serviceaccount:kube-system:cluster-autoscaler-aws-cluster-autoscaler"
                "${var.oidc_provider}:aud" = "sts.amazonaws.com"
            }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "asg_policy" {
  name   = "asg-policy"
  policy = file("${var.github_workspace}/terraform/asg/asg-policy.json")
}

resource "aws_iam_role_policy_attachment" "asg_policy_attachment" {
  role       = aws_iam_role.cluster_autoscale_role.name
  policy_arn = aws_iam_policy.asg_policy.arn
}