provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
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
    name = "DB_HOST"
    # value = data.aws_db_instance.tc_pg_db.address
    value = "toreplace"
  }

  depends_on = [aws_eks_node_group.tc_eks_node_group]
}
