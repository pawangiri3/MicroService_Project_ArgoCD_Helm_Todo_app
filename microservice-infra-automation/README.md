# MicroService Infrastructure Automation - TodoApp

**Enterprise-Grade Infrastructure as Code (IaC) for Containerized Microservices Deployment on Azure**

![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.0-blueviolet)
![Azure](https://img.shields.io/badge/Azure-Cloud-0078D4)
![Kubernetes](https://img.shields.io/badge/Kubernetes-AKS-316CE6)
![DevSecOps](https://img.shields.io/badge/DevSecOps-Enabled-success)
![FinOps](https://img.shields.io/badge/FinOps-Enabled-success)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Module Structure](#module-structure)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Environment Configuration](#environment-configuration)
- [DevSecOps Implementation](#devsecops-implementation)
- [FinOps & Cost Optimization](#finops--cost-optimization)
- [Module Documentation](#module-documentation)
- [Deployment Guide](#deployment-guide)
- [Security Best Practices](#security-best-practices)
- [Monitoring & Observability](#monitoring--observability)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

---

## 🎯 Overview

This repository contains **enterprise-grade Infrastructure as Code (IaC)** for deploying a microservices-based TodoApp on Microsoft Azure. It follows **modular, reusable patterns** with built-in **DevSecOps** and **FinOps** practices for production-ready deployments.

### Key Features

✅ **Modular Architecture** - Reusable Terraform modules for all Azure resources  
✅ **Multi-Environment Support** - Separate dev, staging, and production configurations  
✅ **DevSecOps Integrated** - Security scanning, secret management, and compliance automation  
✅ **FinOps Ready** - Cost monitoring, budget alerts, and resource optimization  
✅ **High Availability** - AKS with auto-scaling and load balancing  
✅ **Container Registry** - Azure Container Registry for secure image storage  
✅ **Database Support** - Azure SQL Server with database replication  
✅ **GitOps Ready** - Integration with ArgoCD for continuous deployment  
✅ **Disaster Recovery** - Automated backups and failover capabilities  

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                   Azure Cloud Platform                       │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────────────────────────────────────────────┐   │
│  │         Resource Group (dev-todoapp-01)              │   │
│  └──────────────────────────────────────────────────────┘   │
│         │                    │                   │           │
│    ┌────▼────┐      ┌────────▼────────┐  ┌──────▼──────┐   │
│    │   AKS   │      │  Azure SQL DB   │  │     ACR     │   │
│    │ Cluster │      │   (PostgreSQL)  │  │  Container  │   │
│    └────┬────┘      └────────┬────────┘  │  Registry   │   │
│         │                    │           └─────────────┘   │
│    ┌────▼──────────────┐     │                            │
│    │   Microservices   │────┼─ Connection String         │
│    │  - Add Task       │     │                            │
│    │  - Get Tasks      │  ┌──▼───────────┐               │
│    │  - Delete Task    │  │  Key Vault   │               │
│    │  - Todo UI        │  │  (Secrets)   │               │
│    └───────────────────┘  └──────────────┘               │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │  Monitoring  │  │  Networking  │  │   Storage    │    │
│  │  & Logging   │  │   & DNS      │  │   Account    │    │
│  └──────────────┘  └──────────────┘  └──────────────┘    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 📦 Module Structure

Our infrastructure follows a **modular, composable approach**:

```
modules/
├── azurerm_resource_group/          # Resource Group
│   ├── main.tf
│   └── variables.tf
├── azurerm_container_registry/      # ACR for container images
│   ├── main.tf
│   └── variables.tf
├── azurerm_kubernetes_cluster/      # AKS cluster
│   ├── main.tf
│   └── variables.tf
├── azurerm_sql_server/              # SQL Server
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── azurerm_sql_database/            # SQL Database
│   ├── main.tf
│   └── variables.tf
├── azurerm_managed_identity/        # Identity & RBAC
│   ├── main.tf
│   └── variables.tf
├── azurerm_key_vault/               # Secrets management
│   ├── main.tf
│   └── variables.tf
├── azurerm_storage_account/         # Storage for backups
│   ├── main.tf
│   └── variables.tf
└── azurerm_public_ip/               # Public IPs
    ├── main.tf
    └── variables.tf

environments/
├── dev/                             # Development environment
│   ├── main.tf
│   ├── terraform.tfvars
│   └── provider.tf
├── staging/                         # Staging environment
│   ├── main.tf
│   ├── terraform.tfvars
│   └── provider.tf
└── prod/                            # Production environment
    ├── main.tf
    ├── terraform.tfvars
    └── provider.tf
```

### Module Benefits

| Module | Purpose | Reusability |
|--------|---------|------------|
| **Resource Group** | Logical container for resources | Multi-environment |
| **Container Registry** | Docker image storage & scanning | Shared across env |
| **AKS Cluster** | Kubernetes orchestration | Per-environment |
| **SQL Server** | Database server & security | Per-environment |
| **Key Vault** | Secrets & certificate management | Shared |
| **Managed Identity** | Azure AD authentication | Per-environment |
| **Storage Account** | Backup & data storage | Per-environment |
| **Public IP** | External connectivity | As needed |

---

## 📋 Prerequisites

### Required Tools

- **Terraform** >= 1.0.x
  ```bash
  terraform version
  ```

- **Azure CLI** >= 2.40.0
  ```bash
  az --version
  ```

- **kubectl** >= 1.24.0
  ```bash
  kubectl version --client
  ```

### Azure Account Requirements

- Active Azure Subscription with sufficient permissions
- Contributor role at subscription level (for initial setup)
- Service Principal for CI/CD automation (recommended)

### Local Environment Setup

```bash
# Install Azure CLI
# macOS
brew install azure-cli

# Windows (via Chocolatey)
choco install azure-cli

# Initialize Azure CLI
az login
az account set --subscription "YOUR_SUBSCRIPTION_ID"

# Install Terraform
# macOS
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# Verify installation
terraform version
```

---

## 🚀 Quick Start

### 1. Clone Repository

```bash
git clone https://github.com/your-org/microservice-infra-automation.git
cd microservice-infra-automation
```

### 2. Configure Azure Credentials

```bash
# Login to Azure
az login

# Set default subscription
az account set --subscription "YOUR_SUBSCRIPTION_ID"

# Create Service Principal for automation
az ad sp create-for-rbac \
  --name "terraform-sp" \
  --role Contributor \
  --scopes /subscriptions/YOUR_SUBSCRIPTION_ID
```

### 3. Initialize Terraform Backend

```bash
# Create storage account for Terraform state
az storage account create \
  --name "tfstateaccount" \
  --resource-group "rg-terraform" \
  --location "centralindia" \
  --sku "Standard_LRS"

# Create container
az storage container create \
  --name "tfstate" \
  --account-name "tfstateaccount"
```

### 4. Deploy Infrastructure

```bash
# Navigate to environment
cd environments/dev

# Initialize Terraform
terraform init \
  -backend-config="storage_account_name=tfstateaccount" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=dev.tfstate" \
  -backend-config="resource_group_name=rg-terraform"

# Plan deployment
terraform plan -out=tfplan

# Apply configuration
terraform apply tfplan
```

### 5. Configure kubectl

```bash
# Get AKS credentials
az aks get-credentials \
  --resource-group "dev-todoapp-01" \
  --name "aks-dev-todoapp" \
  --admin

# Verify cluster access
kubectl get nodes
kubectl get namespaces
```

---

## 🔧 Environment Configuration

### Development Environment

```hcl
# environments/dev/terraform.tfvars
environment        = "dev"
location          = "centralindia"
aks_node_count    = 2
vm_sku            = "Standard_B2s"
database_size_gb  = 2
enable_monitoring = true
enable_backups    = true
```

### Production Environment

```hcl
# environments/prod/terraform.tfvars
environment        = "prod"
location          = "eastus"              # Primary region
aks_node_count    = 5
vm_sku            = "Standard_D4s_v3"
database_size_gb  = 500
enable_monitoring = true
enable_backups    = true
enable_geo_backup = true
```

---

## 🔒 DevSecOps Implementation

This infrastructure includes comprehensive security controls:

### 1. **Secret Management**

```bash
# Store secrets in Azure Key Vault
az keyvault secret set \
  --vault-name "kv-dev-todoapp" \
  --name "database-password" \
  --value "SecurePassword123!"

# Reference in Terraform
data "azurerm_key_vault_secret" "db_password" {
  name         = "database-password"
  key_vault_id = azurerm_key_vault.main.id
}
```

### 2. **Network Security**

- ✅ Network Security Groups (NSGs) with strict ingress rules
- ✅ Private endpoints for database connections
- ✅ Application Gateway for DDoS protection
- ✅ WAF (Web Application Firewall) enabled

### 3. **Identity & Access Management**

```bash
# Create Managed Identity for workloads
az identity create \
  --name "todoapp-identity" \
  --resource-group "dev-todoapp-01"

# Assign RBAC roles
az role assignment create \
  --assignee "SERVICE_PRINCIPAL_ID" \
  --role "AcrPush" \
  --scope "ACR_RESOURCE_ID"
```

### 4. **Container Image Scanning**

- **Trivy Integration**: Vulnerability scanning in ACR
- **Docker Content Trust**: Image signature verification
- **Image Policies**: Only approved images can be deployed

```bash
# Enable image scanning in ACR
az acr config content-trust update \
  --registry acrdevtodoapp01 \
  --status enabled

# Scan existing images
trivy image acrdevtodoapp01.azurecr.io/addtask:latest
```

### 5. **Infrastructure Security Scanning**

- **Terraform Security**: Using `checkov` and `tfsec`
- **Configuration Compliance**: Policy as Code (Azure Policy)
- **Automated Remediation**: Non-compliant resources auto-corrected

```bash
# Install security scanning tools
pip install checkov
brew install aquasecurity/tfsec/tfsec

# Scan Terraform code
checkov -d . --framework terraform
tfsec . --minimum-severity CRITICAL
```

### 6. **Audit & Compliance**

- ✅ Azure Activity Logs enabled
- ✅ SQL Database Auditing enabled
- ✅ Storage Account logging enabled
- ✅ Diagnostic settings configured

### 7. **Data Protection**

- ✅ Encryption at Rest (TDE for SQL)
- ✅ Encryption in Transit (TLS 1.2+)
- ✅ Column-level Encryption (Sensitive data)
- ✅ Automatic Backups (7 days retention)

### DevSecOps Pipeline Integration

```yaml
# .github/workflows/devsecops.yml
name: DevSecOps Checks
on: [push, pull_request]

jobs:
  security-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Run Terraform Security Check
        run: |
          pip install checkov
          checkov -d . --framework terraform --output cli
      
      - name: SAST - SonarQube Scan
        uses: SonarSource/sonarqube-scan-action@master
      
      - name: Container Vulnerability Scan
        run: |
          docker run -v $(pwd):/root/scan \
            aquasec/trivy:latest image-ref
      
      - name: Azure Policy Compliance
        run: |
          az policy assignment list \
            --resource-group dev-todoapp-01
```

---

## 💰 FinOps & Cost Optimization

### 1. **Cost Monitoring & Budgets**

```bash
# Create budget alert
az consumption budget create \
  --name "todoapp-dev-budget" \
  --category "Service" \
  --limit 5000 \
  --threshold-type "Actual" \
  --threshold 90
```

### 2. **Resource Cost Optimization**

| Component | Dev | Prod | Optimization Strategy |
|-----------|-----|------|----------------------|
| **AKS** | 2 nodes (B2s) | 5 nodes (D4s) | Spot VMs for dev (-60%) |
| **SQL DB** | 2 GB | 500 GB | Auto-pause (dev) |
| **Storage** | Standard | Premium | Archive older data |
| **Data Transfer** | Standard | Optimized | Reserved bandwidth |

### 3. **FinOps Tools Integration**

#### **Infracost - Cost Estimation**

```bash
# Install Infracost
curl https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | bash

# Estimate infrastructure cost
cd environments/dev
infracost breakdown --path .

# Output:
# AKS Cluster:              $500/month
# SQL Server + Database:    $200/month
# Container Registry:       $25/month
# Storage Account:          $50/month
# ────────────────────────────────────
# Total Estimated Cost:     $775/month
```

#### **Azure Cost Management**

```bash
# Query cost data via CLI
az costmanagement query create \
  --definition '{...}' \
  --timeframe MonthToDate \
  --granularity Daily
```

#### **Terraform Cost Analysis**

```hcl
# Tag resources for cost tracking
tags = merge(
  local.common_tags,
  {
    "CostCenter"    = "Engineering"
    "Application"   = "TodoApp"
    "ManagedBy"     = "Terraform"
    "Environment"   = "dev"
  }
)
```

### 4. **Cost Optimization Recommendations**

```
┌─────────────────────────────────────────────────────────┐
│  FinOps Recommendations for TodoApp Infrastructure      │
├─────────────────────────────────────────────────────────┤
│                                                           │
│ 1. Development Environment                               │
│    • Use Spot VMs (-60% cost): $8/month → $3.20/month  │
│    • Enable auto-shutdown: Save 50% outside work hours  │
│    • Reduce storage redundancy to LRS                   │
│    Potential Savings: $150-200/month                    │
│                                                           │
│ 2. Database Optimization                                 │
│    • Use Azure SQL Elastic Pools for multiple DBs       │
│    • Enable auto-pause for non-production: -80%         │
│    • Archive cold data to Blob Storage (-90%)           │
│    Potential Savings: $80-120/month                     │
│                                                           │
│ 3. Networking                                            │
│    • Use NAT Gateway (vs Load Balancer): -30%           │
│    • Implement CDN for static content                   │
│    Potential Savings: $50-100/month                     │
│                                                           │
│ 4. Reserved Instances                                    │
│    • 1-year RI for production: -37%                     │
│    • 3-year RI for stable workloads: -55%               │
│    Potential Savings: $200-300/month                    │
│                                                           │
│ Total Potential Monthly Savings: $480-720               │
│ Annual Savings: $5,760-8,640                            │
│                                                           │
└─────────────────────────────────────────────────────────┘
```

### 5. **FinOps Best Practices**

- ✅ **Right-Sizing**: Monitor and adjust VM sizes quarterly
- ✅ **Scheduling**: Auto-shutdown non-prod resources (6 PM - 6 AM)
- ✅ **Spot VMs**: Use for fault-tolerant workloads
- ✅ **Reserved Capacity**: Pre-purchase stable workloads
- ✅ **Cost Allocation**: Tag everything for chargeback
- ✅ **Anomaly Detection**: Alert on unusual spending

---

## 📚 Module Documentation

### Azure Resource Group Module

```hcl
module "rg" {
  source      = "../../modules/azurerm_resource_group"
  rg_name     = "dev-todoapp-01"
  rg_location = "centralindia"
  rg_tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```

**Variables:**
- `rg_name` - Resource Group name
- `rg_location` - Azure region
- `rg_tags` - Resource tags (metadata)

### Container Registry Module

```hcl
module "acr" {
  source   = "../../modules/azurerm_container_registry"
  acr_name = "acrdevtodoapp01"
  rg_name  = module.rg.resource_group_name
  location = "centralindia"
  tags     = local.common_tags
}
```

**Features:**
- Private endpoint support
- Image scanning enabled
- Geo-replication available
- Webhook notifications

### AKS Cluster Module

```hcl
module "aks" {
  source     = "../../modules/azurerm_kubernetes_cluster"
  aks_name   = "aks-dev-todoapp"
  rg_name    = module.rg.resource_group_name
  location   = "centralindia"
  dns_prefix = "aks-dev-todoapp"
  tags       = local.common_tags
}
```

**Features:**
- Auto-scaling enabled
- RBAC enforced
- Pod Security Policies
- Network policies
- Integration with Container Registry

### SQL Server & Database Module

```hcl
module "sql_server" {
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = "sql-dev-todoapp-01"
  rg_name         = module.rg.resource_group_name
  location        = "centralindia"
  admin_username  = "azureuser"
  admin_password  = data.azurerm_key_vault_secret.db_password.value
  tags            = local.common_tags
}

module "sql_db" {
  source     = "../../modules/azurerm_sql_database"
  sql_db_name = "sqldb-dev-todoapp"
  server_id  = module.sql_server.server_id
  max_size_gb = "2"
  tags       = local.common_tags
}
```

**Features:**
- Transparent Data Encryption (TDE)
- Automatic backups
- Point-in-time restore
- Advanced threat protection
- Elastic pool support

---

## 🚀 Deployment Guide

### Phase 1: Prerequisites Setup

```bash
# 1. Create Terraform state resource group
az group create \
  --name "rg-terraform" \
  --location "centralindia"

# 2. Create storage account for state
az storage account create \
  --name "tfstate$(date +%s)" \
  --resource-group "rg-terraform" \
  --location "centralindia" \
  --sku "Standard_LRS" \
  --kind "StorageV2"

# 3. Create container
az storage container create \
  --name "tfstate" \
  --account-name "YOUR_STORAGE_ACCOUNT"

# 4. Enable versioning (for state recovery)
az storage account blob-service-properties update \
  --account-name "YOUR_STORAGE_ACCOUNT" \
  --resource-group "rg-terraform" \
  --enable-restore-policy true \
  --enable-versioning true
```

### Phase 2: Terraform Initialization

```bash
cd environments/dev

terraform init \
  -backend-config="storage_account_name=YOUR_STORAGE_ACCOUNT" \
  -backend-config="container_name=tfstate" \
  -backend-config="key=dev.tfstate" \
  -backend-config="resource_group_name=rg-terraform"

# Verify state is remote
terraform state list
```

### Phase 3: Plan & Review

```bash
# Generate plan
terraform plan -out=tfplan -var-file="terraform.tfvars"

# Review changes
terraform show tfplan

# Export plan to JSON for review
terraform show -json tfplan > tfplan.json
```

### Phase 4: Apply Infrastructure

```bash
# Apply with confirmation
terraform apply tfplan

# Save outputs
terraform output -json > outputs.json

# Display important outputs
terraform output
```

### Phase 5: Post-Deployment Configuration

```bash
# 1. Get AKS credentials
az aks get-credentials \
  --resource-group "dev-todoapp-01" \
  --name "aks-dev-todoapp" \
  --admin

# 2. Verify cluster connectivity
kubectl cluster-info
kubectl get nodes
kubectl get pods --all-namespaces

# 3. Configure container registry login
az aks update \
  --name "aks-dev-todoapp" \
  --resource-group "dev-todoapp-01" \
  --attach-acr "acrdevtodoapp01"

# 4. Deploy microservices (via ArgoCD or Helm)
helm repo add todoapp https://your-helm-repo
helm install todoapp todoapp/todoapp-chart \
  --namespace "default" \
  --values values.yaml
```

---

## 🔐 Security Best Practices

### 1. **Secrets Management**

```bash
# Never commit secrets to Git
echo "admin_password = sensitive_value" >> .gitignore

# Use Key Vault for all secrets
az keyvault secret set \
  --vault-name "kv-dev-todoapp" \
  --name "db-password" \
  --value "$(openssl rand -base64 32)"

# Reference in Terraform
data "azurerm_key_vault_secret" "db_password" {
  name         = "db-password"
  key_vault_id = azurerm_key_vault.main.id
}
```

### 2. **Network Security**

```hcl
# Restrict AKS API access
resource "azurerm_kubernetes_cluster" "main" {
  # ... other config

  api_server_authorized_ip_ranges = [
    "203.0.113.0/24",    # Office network
    "198.51.100.0/24"    # VPN network
  ]
}
```

### 3. **Database Security**

- ✅ Enable Azure AD authentication
- ✅ Configure transparent data encryption (TDE)
- ✅ Enable threat detection
- ✅ Restrict firewall rules
- ✅ Enable SQL Auditing

### 4. **Container Registry Security**

```bash
# Enable image scanning
az acr config content-trust update \
  --registry "acrdevtodoapp01" \
  --status enabled

# Use private endpoints
az network private-endpoint create \
  --name "pe-acr" \
  --resource-group "dev-todoapp-01" \
  --vnet-name "vnet-dev" \
  --subnet "subnet-acr"
```

### 5. **Regular Security Audits**

```bash
# Run compliance check
az security jit-network-access-policy list \
  --resource-group "dev-todoapp-01"

# Review audit logs
az monitor activity-log list \
  --resource-group "dev-todoapp-01" \
  --max-events 50
```

---

## 📊 Monitoring & Observability

### Azure Monitor Integration

```hcl
resource "azurerm_monitor_diagnostic_setting" "aks" {
  name               = "aks-diagnostics"
  target_resource_id = azurerm_kubernetes_cluster.main.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  log {
    category = "kube-apiserver"
    enabled  = true
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
```

### Key Metrics to Monitor

| Metric | Threshold | Alert Action |
|--------|-----------|--------------|
| **CPU Usage** | > 80% | Scale up nodes |
| **Memory Usage** | > 85% | Scale up nodes |
| **Pod Restart Rate** | > 5/hour | Investigate logs |
| **Database CPU** | > 90% | Scale up DB |
| **Storage Used** | > 80% | Increase capacity |
| **Network Latency** | > 100ms | Check connectivity |

### Recommended Monitoring Stack

```yaml
# Prometheus + Grafana
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack

# ELK Stack for logs
helm repo add elastic https://helm.elastic.co
helm install elasticsearch elastic/elasticsearch

# Application Insights
az monitor app-insights component create \
  --app "todoapp-insights" \
  --location "centralindia" \
  --resource-group "dev-todoapp-01"
```

---

## 🐛 Troubleshooting

### Common Issues & Solutions

#### **Issue: Terraform State Lock**
```bash
# View state lock
terraform force-unlock <LOCK_ID>

# Increase timeout
terraform apply -lock-timeout=10m
```

#### **Issue: AKS Node Pool Issues**
```bash
# Check node status
kubectl get nodes -o wide

# Drain and delete problematic node
kubectl drain <NODE_NAME>
kubectl delete node <NODE_NAME>

# Node autoscaler will create replacement
```

#### **Issue: Database Connection Failures**
```bash
# Test connectivity
az sql db audit-policy show \
  --resource-group "dev-todoapp-01" \
  --server "sql-dev-todoapp-01" \
  --name "sqldb-dev-todoapp"

# Check firewall rules
az sql server firewall-rule list \
  --resource-group "dev-todoapp-01" \
  --server "sql-dev-todoapp-01"
```

#### **Issue: High Container Registry Costs**
```bash
# Cleanup old images
az acr repository delete \
  --name "acrdevtodoapp01" \
  --repository "todoapp" \
  --tag "<OLD_TAG>"

# Enable purge
az acr purge \
  --registry "acrdevtodoapp01" \
  --filter "todoapp:.*" \
  --ago 30d
```

---

## 📖 Additional Resources

- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Best Practices](https://docs.microsoft.com/en-us/azure/architecture/guide/)
- [Kubernetes Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/)
- [Azure Security Center](https://docs.microsoft.com/en-us/azure/security-center/)
- [FinOps Foundation](https://www.finops.org/)

---

## 🤝 Contributing

### Code Style

```hcl
# Variable naming
variable "resource_name" {
  description = "Clear, concise description"
  type        = string
  default     = "sensible-default"
}

# Resource naming
resource "azurerm_resource_group" "main" {
  name     = "${var.environment}-${var.application}-rg"
  location = var.azure_region
}
```

### Pull Request Checklist

- [ ] Terraform code formatted (`terraform fmt`)
- [ ] Security scan passed (`checkov`, `tfsec`)
- [ ] Cost estimate reviewed (`infracost`)
- [ ] Tests passed (`terraform plan`)
- [ ] README updated
- [ ] No hardcoded secrets or credentials

### Running Tests

```bash
# Format check
terraform fmt -check -recursive .

# Security checks
checkov -d . --framework terraform
tfsec . --minimum-severity CRITICAL

# Cost analysis
infracost breakdown --path environments/dev
```

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

---

## 👥 Support & Contact

For issues, questions, or suggestions:

- **GitHub Issues**: [Create an issue](https://github.com/your-org/microservice-infra-automation/issues)
- **Email**: devops@your-company.com
- **Slack**: #infrastructure-code channel

---

## 📋 Changelog

### v2.0.0 (2024-01-03)
- ✨ Added enterprise-grade DevSecOps implementation
- ✨ Integrated FinOps cost optimization tools
- ✨ Enhanced monitoring and observability
- 🔒 Implemented secret management best practices
- 📊 Added comprehensive cost analysis

### v1.0.0 (2023-12-01)
- 🎉 Initial release
- ✅ Core AKS, SQL, ACR, and networking modules
- ✅ Multi-environment support (dev, prod)
- ✅ Basic monitoring and logging

---

**Last Updated**: January 2024  
**Maintained By**: DevOps Team  
**Status**: Production Ready ✅