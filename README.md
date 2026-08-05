# Enterprise GCP Infrastructure via Terraform

This repository provisions Google Cloud Platform (GCP) infrastructure using **Terraform (Infrastructure as Code - IaC)** following a modular, multi-environment layout (`dev` and `prod`).

All infrastructure resources are localized in the **GCP Dallas (`us-south1`)** region per project governance.

---

## 🌟 Architecture Features

* **Custom VPC Network (`umzy-vpc-dev` / `umzy-vpc-prod`):** Custom VPC networks with `auto_create_subnetworks = false` for strict traffic control.
* **Subnetwork Allocation (`umzy-app-subnet-01`):** Subnets configured with `/20` CIDR blocks (`10.128.0.0/20`), accommodating 4,094 usable IP addresses per environment.
* **Zero-Trust Firewall Rules (`allow_ssh`, `allow_http`):** Inbound traffic is blocked by default and selectively allowed via network tags:
  * **TCP Port 22:** Allowed for instances tagged with `ssh`.
  * **TCP Port 80:** Allowed for web server instances tagged with `web-server`.
* **Dynamic Target Tag Propagation:** Network tags are exported from the VPC module (`module.vpc.firewall_target_tags`) and passed directly into the Compute module. Changes to firewall tags dynamically update attached VM instances.
* **Compute Engine VM & Automated Bootstrapping (`umzy-app-vm-dev-01`):**
  * Cost-optimized compute instances (`e2-micro`, `Debian 12`) attached to the custom subnet.
  * Ephemeral public IP assignment (`access_config`).
  * Automated application provisioning via a metadata startup script (`modules/compute/scripts/startup.sh`) that installs Apache web server and serves dynamic runtime metrics.

---

## 📁 Directory Structure

```text
umzy-gcp-terraform/
├── README.md                      # Project documentation and guide
├── main.tf                        # Root Terraform entrypoint
├── provider.tf                    # Root GCP provider configuration
├── variables.tf                   # Root variable declarations
├── terraform.tfvars               # Root environment variable values
├── outputs.tf                     # Root global outputs
├── compliance/                    # Compliance & audit reports
├── modules/                       # Reusable Infrastructure Modules
│   ├── vpc/                       # VPC Network, Subnetwork, and Firewall Rules
│   │   ├── vpc.tf                 # Network and Subnet definition
│   │   ├── firewall.tf            # SSH (22) and HTTP (80) Firewall rules
│   │   ├── variables.tf           # VPC input variables
│   │   └── outputs.tf             # VPC IDs, Subnet IDs, and Firewall Target Tags
│   └── compute/               # Compute Engine VM Module
│       ├── compute.tf             # VM instance definition & startup script hook
│       ├── variables.tf           # Compute input variables
│       ├── outputs.tf             # Instance IP, Self-Link, and Web URL outputs
│       └── scripts/
│           └── startup.sh         # Apache installation & metadata startup script
└── environments/                  # Environment Deployments
    ├── dev/                       # Development Environment
    │   ├── main.tf                # Dev VPC & Compute module invocations
    │   ├── variables.tf           # Dev variable definitions
    │   ├── terraform.tfvars       # Dev-specific configuration values
    │   ├── provider.tf            # Provider configuration
    │   └── outputs.tf             # Dev environment outputs
    └── prod/                      # Production Environment
        ├── main.tf                # Prod VPC & Compute module invocations
        ├── variables.tf           # Prod variable definitions
        ├── terraform.tfvars       # Prod-specific configuration values
        ├── provider.tf            # Provider configuration
        └── outputs.tf             # Prod environment outputs
```

---

## 🌐 Environment Resource Specifications

| Attribute | Development (`dev`) | Production (`prod`) |
| :--- | :--- | :--- |
| **VPC Network Name** | `umzy-vpc-dev` | `umzy-vpc-prod` |
| **Subnet Name** | `umzy-app-subnet-01` | `umzy-app-subnet-01` |
| **Subnet CIDR Range** | `10.128.0.0/20` | `10.128.0.0/20` |
| **VM Instance Name** | `umzy-app-vm-dev-01` | `umzy-app-vm-prod-01` |
| **Machine Type** | `e2-micro` | `e2-standard-2` |
| **GCP Region / Zone** | `us-south1` (`us-south1-a`) | `us-south1` (`us-south1-a`) |
| **Network Tags** | `["ssh", "web-server"]` | `["ssh", "web-server"]` |

---

## 🚀 Execution Guide

### 1. Authenticate with GCP
Ensure Application Default Credentials (ADC) are configured:
```bash
gcloud auth application-default login
```

### 2. Deploy Infrastructure (Development)
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### 3. Verify Deployment
Upon successful `terraform apply`, Terraform will display the instance outputs:
* `instance_public_ip`: Public IP of the VM instance.
* `web_server_url`: `http://<PUBLIC_IP>` to access the automated Apache landing page.

### 4. Teardown Infrastructure
To destroy all provisioned resources:
```bash
cd environments/dev
terraform destroy
```
