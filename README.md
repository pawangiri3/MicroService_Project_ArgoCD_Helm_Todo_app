# TodoApp Microservices Platform

**Enterprise-ready microservices sample project — infrastructure, backend services, and frontend UI deploying to Azure.**

---

**Project Summary**

- **Purpose:** Deploy a small microservices-based Todo application to Azure using modular Terraform (IaC), AKS, ACR, and GitOps.  
- **Repositories / Folders:** The repository contains an infrastructure automation workspace and multiple service folders (backend services and frontend UI). Each service folder already includes a README explaining how to build and run that component locally and in CI.

---

**Repository layout** (top-level folders)

- **microservice-infra-automation/** : Terraform modules and environment configs for Azure (AKS, ACR, SQL, Key Vault, networking). See [microservice-infra-automation/README.md](microservice-infra-automation/README.md) for infra details.
- **AddTaskTodoMicroservice/** : Python backend service (Add Task). Includes Dockerfile, manifests and build instructions.
- **GetTasksTodoMicroservice/** : Python backend service (Get Tasks). Includes Dockerfile, manifests and build instructions.
- **DeleteTaskTodoMicroservice/** : Python backend service (Delete Task). Includes Dockerfile, manifests and build instructions.
- **MicroTodoUI/** : React/JavaScript frontend. Includes Dockerfile, Helm/manifest and build instructions.

---

**Architecture & Components**

- **Frontend:** `MicroTodoUI` — React SPA served from container in AKS (optionally fronted by Ingress/Ingress Controller or CDN).
- **Backend microservices:** `AddTask`, `GetTasks`, `DeleteTask` — lightweight Python Flask/FastAPI services exposing REST endpoints.
- **Container Registry:** Azure Container Registry (ACR) to store images.
- **Orchestration:** Azure Kubernetes Service (AKS) with node pools, autoscaling and network policies.
- **Data layer:** Azure SQL Database (or configurable DB) with backups and secure access via Private Endpoint.
- **Secrets:** Azure Key Vault for credentials, connection strings and certificates.
- **CI/CD / GitOps:** Build pipelines push images to ACR; deployments managed via ArgoCD or Helm charts.

---

**Prerequisites**

- **Azure subscription** with sufficient quotas and permissions (Contributor or RBAC scoped service principal).  
- **Local tools:** `terraform` >= 1.0, `az` (Azure CLI), `kubectl`, `helm`, `docker`/`buildx`, `git`.
- **Optional security & cost tools:** `checkov`, `tfsec`, `trivy`, `infracost` for IaC security, image scanning and cost estimates.

---

**Quick Start (high level)**

1. Review infra module docs: open [microservice-infra-automation/README.md](microservice-infra-automation/README.md) and configure environment variables / backend state.  
2. Prepare Azure credentials and remote state (create storage account and container for Terraform state).  
3. From `microservice-infra-automation/environments/<env>` run `terraform init` → `terraform plan` → `terraform apply` to provision infrastructure (resource group, ACR, AKS, SQL, Key Vault, public IPs).  
4. Build and push each service image to ACR (each service folder has a `Dockerfile` and README with build/push steps).  
5. Deploy manifests/Helm charts to AKS (use `kubectl` or GitOps via ArgoCD).  
6. Verify services and UI via Ingress endpoint or public IP.

Example commands (adapt variables):

```powershell
# Authenticate
az login
az account set --subscription "YOUR_SUBSCRIPTION_ID"

# Initialize Terraform (example)
cd microservice-infra-automation/environments/dev
terraform init
terraform plan -out=tfplan
terraform apply tfplan

# Build & push a backend image (example)
cd AddTaskTodoMicroservice
docker build -t acrname.azurecr.io/addtask:dev .
docker push acrname.azurecr.io/addtask:dev

# Deploy to AKS (example using kubectl)
kubectl apply -f manifests/service.yaml
kubectl apply -f manifests/deployment.yaml
```

---

**Build & Component Notes**

- **Backend services (Python):** Each backend service folder contains `app.py`, `requirements.txt`, `Dockerfile`, and `manifests/` for Kubernetes. Follow the per-folder README to run locally (`pip install -r requirements.txt`) and to containerize.
- **Frontend (React):** `MicroTodoUI` contains the React app source in `src/` and `public/`. Use `npm install` and `npm run build` to produce static assets; Dockerfile packages it for serving.
- **Kubernetes manifests & Helm:** Basic manifests are provided under each `manifests/` folder. For production use, convert to Helm charts and parameterize values (replicas, resource limits, secrets references to Key Vault via CSI driver or Azure AD Pod Identity).

---

**CI/CD and GitOps recommendations**

This project is intended to be deployed using modern DevSecOps tooling — Helm for templated, parameterized Kubernetes packages and ArgoCD for GitOps-driven continuous delivery. CI pipelines should integrate SAST, IaC scanning, container vulnerability scanning, image signing/content-trust, and cost estimation to enforce security and cost controls before deployment.

- **Build pipeline:** Use Azure DevOps/GitHub Actions to build images, run unit tests, run SAST (SonarQube), run container scans (Trivy), sign images, and push to ACR.  
- **Deployment pipeline:** Package releases as Helm charts and use ArgoCD to sync the desired state from Git to AKS. This enables safe, auditable, and declarative deployments.
- **Security gates:** Enforce checks (checkov, tfsec) on PRs, require container scans to pass (Trivy), and block deployments for critical vulnerabilities or failing policy checks.

Recommended DevSecOps tools: `Helm`, `ArgoCD`, `Trivy`, `Checkov`, `tfsec`, `SonarQube`, `Infracost`.

---

**Where to find per-component docs**

- Infrastructure: [microservice-infra-automation/README.md](microservice-infra-automation/README.md)
- Add Task service: [AddTaskTodoMicroservice/Readme.md](AddTaskTodoMicroservice/Readme.md)
- Get Tasks service: [GetTasksTodoMicroservice/Readme.md](GetTasksTodoMicroservice/Readme.md)
- Delete Task service: [DeleteTaskTodoMicroservice/Readme.md](DeleteTaskTodoMicroservice/Readme.md)
- Frontend UI: [MicroTodoUI/README.md](MicroTodoUI/README.md)

If a service README is missing or needs expansion, open an issue or submit a PR with the missing build/deploy steps.

---

**Support & Contacts**

- **Owner:** TodoApp DevOps Team
- **Issues:** Use GitHub Issues in this repository

---

**Status:** Project scaffolding with modular infra; each component contains build instructions. Follow the infra README first to provision cloud resources, then build and deploy services.

---

*Last updated: January 2026*
