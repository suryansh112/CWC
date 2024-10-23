resource "helm_release" "alb_ingress_controller" {
  name       = "alb-ingress-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "default"

  values = [
    <<EOF
    clusterName: ${var.cluster_name}
    serviceAccount:
      create: false
      name: alb-ingress-controller-sa
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
resource "aws_security_group" "alb_ingress_sg" {
  name        = "alb-ingress-sg"
  description = "Security group for ALB ingress controller"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}