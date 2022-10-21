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

variable "release_version" {
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

variable "set_values" {
  description = "Forced set values"
  type        = any
  default     = []
}

variable "set_sensitive_values" {
  description = "Forced set_sensitive values"
  type        = any
  default     = []
}
