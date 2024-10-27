resource "helm_release" "alb_ingress_controller" {
  name       = "alb-ingress-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"


  values = [
    <<EOF
    clusterName: ${var.cluster_name}
    serviceAccount:
      create: false
      name: aws-load-balancer-controller
    region: ${var.region}
    vpcId: ${data.aws_vpc.default.id}
    EOF
  ]
}

data "aws_vpc" "default"{
    default = true
}
resource "aws_iam_role" "alb_ingress_role" {
  name = "alb-ingress-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_policy" "alb_ingress_policy" {
  name   = "alb-ingress-controller-policy"
  policy = file("${var.github_workspace}/terraform/alb/alb-ingress-policy.json")
}

resource "aws_iam_role_policy_attachment" "alb_ingress_policy_attachment" {
  role       = aws_iam_role.alb_ingress_role.name
  policy_arn = aws_iam_policy.alb_ingress_policy.arn
}
