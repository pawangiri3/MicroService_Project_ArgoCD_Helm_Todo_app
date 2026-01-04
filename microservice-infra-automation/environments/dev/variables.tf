variable "environment" {
  description = "Deployment environment name"
  type        = string
}

variable "location" {
  description = "Azure location for resources"
  type        = string
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "acr_name" {
  description = "Azure Container Registry name"
  type        = string
}

variable "sql_server_name" {
  description = "SQL server name"
  type        = string
}

variable "admin_username" {
  description = "SQL admin username"
  type        = string
}

variable "admin_password" {
  description = "SQL admin password"
  type        = string
  sensitive   = true
}

variable "sql_db_name" {
  description = "SQL database name"
  type        = string
}

variable "max_size_gb" {
  description = "Max size for SQL DB in GB"
  type        = string
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for AKS cluster"
  type        = string
}
