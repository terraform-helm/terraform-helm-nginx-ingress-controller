variable "name" {
  description = "Name of helm release"
  type        = string
  default     = "ingress-nginx"
}

variable "repository" {
  description = "Url of repository"
  type        = string
  default     = "https://kubernetes.github.io/ingress-nginx"
}

variable "chart" {
  description = "Chart of helm release"
  type        = string
  default     = "ingress-nginx"
}

variable "namespace" {
  description = "namespace of helm release"
  type        = string
  default     = "ingress-nginx"
}

variable "create_namespace" {
  description = "Create namespace ?"
  type        = bool
  default     = true
}

variable "version" {
  description = "version of helm release"
  type        = string
  default     = null
}

variable "images" {
  description = "Map of images"
  type        = map(string)
  default     = {}
}

variable "values" {
  description = "Values"
  type        = list(any)
  default     = []
}
