# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }

# resource "null_resource" "update_kubeconfig" {
#     provisioner "local-exec" {
#       command = "aws eks update-kubeconfig --region us-east-1 --name eks_lanchonete-do-bairro"
#     }
#     depends_on = [ aws_eks_cluster.tc_eks_cluster ]
# }

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.tc_eks_cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.tc_eks_cluster.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", "eks_lanchonete-do-bairro"]
      command     = "aws"
    }
  }
}

resource "helm_release" "lanchonetedobairro" {
  name      = "lanchonetedobairro"
  namespace = "dev"
  chart     = "./helm/lanchonetedobairro_chart"

  values = [
    file("./helm/lanchonetedobairro_chart/values.yaml"),
    file("./helm/lanchonetedobairro_chart/values-dev.yaml")
  ]

  set {
    name  = "DB_HOST"
    value = var.RDS_HOST
  }

  depends_on = [aws_eks_node_group.tc_eks_node_group]
}

resource "kubernetes_namespace" "dev" {
  metadata {
    annotations = {
      name = "dev-annotation"
    }

    name = "dev"
  }
}
