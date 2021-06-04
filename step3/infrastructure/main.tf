provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "home-k8s"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "home-k8s"
  }
}
