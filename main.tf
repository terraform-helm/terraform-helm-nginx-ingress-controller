locals {
  main_image    = regex("^(?:(?P<url>[^/]+))?(?:(?P<image>[^:]*))??(?::(?P<tag>[^:]*))", var.images.main)
  webhook_image = regex("^(?:(?P<url>[^/]+))?(?:(?P<image>[^:]*))??(?::(?P<tag>[^:]*))", var.images.webhook)
}

resource "helm_release" "this" {
  name             = var.name
  repository       = var.repository
  chart            = var.chart
  namespace        = var.namespace
  create_namespace = var.create_namespace
  version          = "4.1.4"

  values = var.values

  set {
    name  = "controller.image.registry"
    value = local.main_image.url
  }

  set {
    name  = "controller.image.image"
    value = local.main_image.image
  }

  set {
    name  = "controller.image.tag"
    value = local.main_image.tag
  }

  set {
    name  = "controller.image.digest"
    value = "false"
  }

  set {
    name  = "controller.admissionWebhooks.patch.image.registry"
    value = local.webhook_image.url
  }

  set {
    name  = "controller.admissionWebhooks.patch.image.image"
    value = local.webhook_image.image
  }

  set {
    name  = "controller.admissionWebhooks.patch.image.tag"
    value = local.webhook_image.tag
  }
  set {
    name  = "controller.admissionWebhooks.patch.image.digest"
    value = "false"
  }
}
