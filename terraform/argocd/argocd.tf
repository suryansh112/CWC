resource "helm_release" "argocd" {
    name = "argocd"
    repository = "https://argoproj.github.io/argo-helm"  
    chart      = "argo-cd"  
    namespace = "argocd"
    create_namespace = true
    version = "2.14.3"
    depends_on = [var.endpoint,var.node,var.alb_name]


     values = [
    <<EOF
    server:
      service:
        type: ClusterIP
    EOF
  ]
    
}