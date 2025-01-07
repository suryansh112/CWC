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
    annotations:
      arn: ${resource.aws_iam_role.cluster_autoscale_role.arn}
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
                "${var.federated_arn}:sub" = "system:serviceaccount:kube-system:cluster-autoscaler"
                "${var.federated_arn}:aud" = "sts.amazonaws.com"
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