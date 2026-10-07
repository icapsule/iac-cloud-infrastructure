# 🌐 Enterprise Multi-Cloud Infrastructure as Code (IaC)

![Terraform](https://img.shields.io/badge/Terraform-1.5%2B-844FBA?logo=terraform&logoColor=white)
![Multi-Cloud](https://img.shields.io/badge/Topology-Multi--Cloud%20(OCI%20%2B%20Azure%20%2B%20AWS%20%2B%20GCP)-blue)
![Azure](https://img.shields.io/badge/Azure-Sweden%20Central-0078D4?logo=microsoft-azure&logoColor=white)
![Edge](https://img.shields.io/badge/Edge-Cloudflare%20Anycast-F38020?logo=cloudflare&logoColor=white)
![GitOps](https://img.shields.io/badge/Delivery-GitOps%20%2F%20VCS--Driven-2088FF?logo=github-actions&logoColor=white)
![Security](https://img.shields.io/badge/State-Blast%20Radius%20Isolated-success)

> **Repository**: `iac-cloud-infrastructure`  
> **Architecture Pattern**: Layered & Modular Multi-Cloud Topology with State Boundary Isolation  
> **Managed Footprint**: Oracle Cloud (Stockholm), Microsoft Azure (Sweden Central), Amazon Web Services, Google Cloud, Cloudflare Global Edge.

---

## 🏛 Multi-Cloud Architecture Topology

This repository orchestrates a production-grade, multi-cloud foundation designed for **zero single-point-of-failure (SPOF)**, cross-cloud disaster recovery, and edge-routed low latency:

```mermaid
flowchart TD
    subgraph Edge["1. Global Edge Routing (Cloudflare)"]
        CF["Cloudflare Anycast Network & WAF<br/><code>stacks/global-edge</code>"]
    end

    subgraph OCI["2. Primary Compute Cluster (Oracle Cloud Infrastructure)"]
        direction TB
        VCN["Virtual Cloud Network (VCN)<br/><code>stacks/oci-infra</code>"]
        VM1["<b>VM1: AI Gateway Core</b><br/>IP: 79.76.48.169<br/>Docker Compose: LiteLLM"]
        VM2["<b>VM2: Omniroute Failover</b><br/>IP: 129.151.210.179<br/>Docker Compose: Omniroute"]
        VCN --- VM1
        VCN --- VM2
    end

    subgraph AZ["3. Secrets & Enterprise Governance (Microsoft Azure - Sweden)"]
        KV["<b>Azure Key Vault & Storage</b><br/><code>stacks/azure-infra</code><br/>Sweden Central (Zero Trust)"]
    end

    subgraph AWS["4. Disaster Recovery & Snapshot Store (Amazon Web Services)"]
        S3["<b>S3 Bucket (AES256 Versioned)</b><br/><code>stacks/aws-infra</code><br/>Cross-Cloud Backup Replicas"]
    end

    subgraph GCP["5. Telemetry & Cold Archive (Google Cloud Platform)"]
        GCS["<b>GCS Nearline Bucket</b><br/><code>stacks/gcp-infra</code><br/>Long-term Audit & Log Retention"]
    end

    subgraph DataTier["External Serverless Data Tier"]
        DB[(Neon PostgreSQL Serverless)]
    end

    CF -->|Zero Trust Tunnel| VM1
    CF -.->|Health Check Failover| VM2
    VM1 -->|Pooled SSL| DB
    VM2 -->|Pooled SSL| DB
    VM1 -.->|Secrets & Identity| KV
    VM1 -.->|Nightly Encrypted Dumps| S3
    VM1 -.->|Audit Telemetry| GCS
```

---

## 📐 Architecture Design Principles

### 1. 🛡️ Blast Radius Isolation
Instead of a monolithic `main.tf` binding all cloud providers into a single state file, this repository strictly separates state boundaries by **Cloud Provider**:
* Modifying OCI compute firewall will **never** trigger resource locks or risk regressions against AWS or GCP states.
* An outage in one cloud provider's API endpoint does not block continuous deployment pipelines across the other providers.

### 2. 🧱 Modular Reusability (DRY Infrastructure)
* Shared infrastructure patterns (compute provisioning, DNS health routing) are abstracted under [`modules/`](file:///Users/icapsule/Developer/iac-cloud-infrastructure/modules/).
* Environment/Stack root modules instantiate these reusable components with parameterized variables.

### 3. 🔄 Stateless Compute & Cattle Architecture
* OCI compute instances run containerized workloads (via Docker Compose) and store zero persistent business state locally.
* Stateful databases reside in managed serverless PostgreSQL (Neon).
* Compute nodes can be torn down and recreated in under 3 minutes via Terraform with zero data loss.

### 4. 🔒 Zero-Trust Secrets Hygiene
* Air-gapped secrets management: **Zero credentials, API tokens, or SSH private keys are checked into Git.**
* All variables marked `sensitive = true` are injected at runtime via encrypted environment variables or Terraform Cloud workspace settings.

---

## 📂 Repository Topology

```text
iac-cloud-infrastructure/
├── .gitignore                      # Comprehensive security ignore rules
├── README.md                       # Architecture documentation & operational runbooks
│
├── modules/                        # 🧱 Reusable Infrastructure Modules
│   ├── oci-compute-node/           # OCI Compute instance & tagging module
│   └── cloudflare-dns-failover/    # Cloudflare multi-origin DNS routing module
│
└── stacks/                         # 🌐 Independent State Boundaries
    ├── global-edge/                # Cloudflare DNS & Global Anycast Routing
    │   ├── versions.tf
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── oci-infra/                  # OCI Primary & Secondary Compute Nodes
    │   ├── versions.tf             # Native import blocks for Brownfield assets
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── azure-infra/                # Microsoft Azure Key Vault & Blob Store
    │   ├── versions.tf
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── aws-infra/                  # AWS Cross-Cloud DR & S3 Backup Storage
    │   ├── versions.tf
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── gcp-infra/                  # GCP Telemetry Archive & Nearline Storage
        ├── versions.tf
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## 🛠 Operational Runbook: Deploying a Stack

Each stack operates independently. Navigate into the target stack directory:

### Step 1: Manage OCI Compute Stack
```bash
cd stacks/oci-infra

# Initialize provider plugins (OCI >= 6.0)
terraform init

# Review execution plan (verifies native import blocks against live instances)
terraform plan

# Apply declarative configuration
terraform apply
```

### Step 2: Manage Global Edge DNS
```bash
cd stacks/global-edge
terraform init
terraform plan
terraform apply
```

### Step 3: Manage Azure Enterprise Vault & Storage
```bash
cd stacks/azure-infra
terraform init
terraform plan
terraform apply
```

### Step 4: Manage AWS DR Store
```bash
cd stacks/aws-infra
terraform init
terraform plan
terraform apply
```

### Step 5: Manage GCP Archive
```bash
cd stacks/gcp-infra
terraform init
terraform plan
terraform apply
```

---

## 📜 Compliance & Disaster Recovery Strategy

| Scenario | Recovery Mechanism | Target RTO (Recovery Time Objective) |
| :--- | :--- | :--- |
| **OCI VM Crash / OOM** | Automated container restart via Docker Compose `restart: always` | < 10 seconds |
| **OCI Regional Outage** | Cloudflare automatically fails over origin traffic to secondary node | < 30 seconds |
| **Accidental VM Deletion** | Re-run `terraform apply` in `stacks/oci-stockholm` | < 3 minutes |
| **Database Corruption** | Point-in-time recovery via Neon + snapshot sync from AWS S3 | < 15 minutes |

---

## 🗺 Roadmap (Future Enhancements)

*   [ ] **OIDC Dynamic Credentials**: Upgrade the current GitHub-to-HCP authentication (`TF_API_TOKEN`) to a Keyless OpenID Connect (OIDC) architecture, achieving true Zero-Trust dynamic trust without storing static API tokens in GitHub Secrets.
*   [ ] **Cross-Cloud State Data Sources**: Utilize `terraform_remote_state` to dynamically pass output variables (e.g., OCI IP addresses) directly into the Cloudflare Edge stack.
*   [ ] **Automated Drift Detection**: Schedule a nightly cron job in GitHub Actions to run `terraform plan` and alert on any out-of-band changes to infrastructure.





