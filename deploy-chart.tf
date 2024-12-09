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
  name             = "lanchonetedobairro"
  namespace        = "dev"
  create_namespace = true
  chart            = "./helm/lanchonetedobairro_chart"

  values = [
    file("./helm/lanchonetedobairro_chart/values.yaml"),
    file("./helm/lanchonetedobairro_chart/values-dev.yaml")
  ]

  set {
    name  = "configmap.data.DB_HOST"
    value = var.rdsHost
  }

  depends_on = [aws_eks_node_group.tc_eks_node_group]
}