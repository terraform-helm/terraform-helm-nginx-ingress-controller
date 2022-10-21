locals {
  repo_regex    = "^(?:(?P<url>[^/]+))?(?:/(?P<image>[^:]*))??(?::(?P<tag>[^:]*))"
  main_image    = contains(keys(var.images), "main") ? regex(local.repo_regex, var.images.main) : {}
  webhook_image = contains(keys(var.images), "webhook") ? regex(local.repo_regex, var.images.webhook) : {}

  main_pre_value    = "controller.image"
  webhook_pre_value = "controller.admissionWebhooks.patch.image"

  main_set_values    = local.main_image != {} ? [{ name = "${local.main_pre_value}.registry", value = local.main_image.url }, { name = "${local.main_pre_value}.image", value = local.main_image.image }, { name = "${local.main_pre_value}.tag", value = local.main_image.tag }, { name = "${local.main_pre_value}.digest", value = "false" }] : []
  webhook_set_values = local.webhook_image != {} ? [{ name = "${local.webhook_pre_value}.registry", value = local.webhook_image.url }, { name = "${local.webhook_pre_value}.image", value = local.webhook_image.image }, { name = "${local.webhook_pre_value}.tag", value = local.webhook_image.tag }, { name = "${local.webhook_pre_value}.digest", value = "false" }] : []

  set_values = concat(var.set_values, local.main_set_values, local.webhook_set_values)
}

resource "helm_release" "this" {
  name             = var.name
  repository       = var.repository
  chart            = var.chart
  namespace        = var.namespace
  create_namespace = var.create_namespace
  version          = var.release_version

  values = var.values

  dynamic "set" {
    iterator = each_item
    for_each = local.set_values

    content {
      name  = each_item.value.name
      value = each_item.value.value
      type  = try(each_item.value.type, null)
    }
  }

  dynamic "set_sensitive" {
    iterator = each_item
    for_each = var.set_sensitive_values

    content {
      name  = each_item.value.name
      value = each_item.value.value
      type  = try(each_item.value.type, null)
    }
  }
}
