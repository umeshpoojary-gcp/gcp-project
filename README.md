<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Ubuntu:ital,wght@0,300;0,400;0,500;0,700;1,400&display=swap">

<div style="font-family: 'Ubuntu', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">

# Enterprise GCP Cloud Architecture & Terraform Automation

Welcome to the **Modular GCP Infrastructure Repository**. This project provisions a secure, highly scalable, and enterprise-compliant Google Cloud Platform (GCP) environment using **Terraform (Infrastructure as Code - IaC)**.

---

## 📸 High-Resolution Architecture Diagram

<p align="center">
  <img src="gcp_architecture_diagram.jpg" alt="GCP Architecture Diagram" width="100%" />
</p>

---

## 📐 Visual Architecture Blueprints

### A. End-to-End GCP Network & Security Flow

```mermaid
graph TD
    classDef internetStyle fill:#1e293b,stroke:#3b82f6,stroke-width:2px,color:#fff;
    classDef gcpStyle fill:#0f172a,stroke:#10b981,stroke-width:2px,color:#fff;
    classDef vpcStyle fill:#1e1e38,stroke:#6366f1,stroke-width:2px,color:#fff;
    classDef subnetStyle fill:#1e293b,stroke:#f59e0b,stroke-width:2px,color:#fff;
    classDef vmStyle fill:#334155,stroke:#ec4899,stroke-width:2px,color:#fff;

    subgraph IN ["🌐 Public Internet (0.0.0.0/0)"]
        A["👨‍💻 Admin (SSH Port 22)"]
        B["🌐 Web User (HTTP Port 80)"]
        C["🚫 Unauthorized Traffic (Port 443, etc.)"]
    end

    subgraph GCP ["☁️ Google Cloud Platform (Region: us-south1)"]
        subgraph VPC ["🛡️ Custom VPC Network (umzy-vpc-dev)"]
            subgraph FW ["🔥 Security Layer (Firewall Rules)"]
                FW1["Rule: allow_ssh (TCP 22) -> Target Tag: ssh"]
                FW2["Rule: allow_http (TCP 80) -> Target Tag: web-server"]
                FW3["Implicit Deny All Ingress (Blocks 443 & All Other Ports)"]
            end

            subgraph SUB ["📍 Custom Subnet (umzy-app-subnet-01)"]
                SUBNET_INFO["CIDR: 10.128.0.0/20 | 4,094 Usable IPs"]
                
                subgraph VM1 ["💻 Compute Engine VM 1 (umzy-app-vm-dev-01)"]
                    VM1_INFO["Type: e2-micro | OS: Debian 12<br/>Private IP: 10.128.0.2<br/>Dedicated Public Ephemeral IP 1"]
                    APP1["🚀 Apache Web Server (Port 80)<br/>Auto-bootstrapped via startup.sh"]
                end

                subgraph VM2 ["💻 Compute Engine VM 2 (umzy-app-vm-dev-02)"]
                    VM2_INFO["Type: e2-micro | OS: Debian 12<br/>Private IP: 10.128.0.3<br/>Dedicated Public Ephemeral IP 2"]
                    APP2["🚀 Apache Web Server (Port 80)<br/>Auto-bootstrapped via startup.sh"]
                end
            end
        end
    end

    A -->|TCP 22| FW1
    B -->|TCP 80| FW2
    C -.->|Dropped at Edge| FW3

    FW1 -->|Matches Tag: ssh| VM1
    FW1 -->|Matches Tag: ssh| VM2
    FW2 -->|Matches Tag: web-server| VM1
    FW2 -->|Matches Tag: web-server| VM2

    class IN internetStyle;
    class GCP gcpStyle;
    class VPC vpcStyle;
    class SUB subnetStyle;
    class VM1,VM2 vmStyle;
```

---

### B. Dynamic Terraform Module & Dependency Sequence

```mermaid
sequenceDiagram
    autonumber
    actor User as User / Admin
    participant Dev as Dev Environment (environments/dev)
    participant VPC as VPC Module (modules/vpc)
    participant Compute as Compute Module (modules/compute)
    participant GCP as Google Cloud API

    User->>Dev: Execute terraform apply
    Dev->>VPC: 1. Provision Custom VPC & Subnet (10.128.0.0/20)
    VPC->>GCP: Create google_compute_network & subnetwork
    Dev->>VPC: 2. Create Firewall Rules (allow_ssh & allow_http)
    VPC->>GCP: Create google_compute_firewall resources
    VPC-->>Dev: 3. Export target_tags output via tolist(setunion(...))
    Dev->>Compute: 4. Pass tags = module.vpc.firewall_target_tags & count = 2
    Compute->>GCP: 5. Create 2 VMs (umzy-app-vm-dev-01 & umzy-app-vm-dev-02)
    Compute->>GCP: 6. Inject metadata_startup_script file("scripts/startup.sh") into both VMs
    GCP-->>Dev: 7. Return Array of Instance IPs & Web Server URLs
    Dev-->>User: Deployment Complete!
```

---

## 🎯 Architecture Explanation & Technical Design Deep-Dive

### 1. Network Topology & Subnet Engineering
* **Custom VPC Network Isolation:**
  Default GCP networks auto-provision subnets across every global region, introducing unnecessary attack surface and overlapping IP space. This architecture explicitly creates a **Custom VPC Network** (`auto_create_subnetworks = false`), granting total control over subnetwork placement, routing tables, and perimeter boundaries.
* **`/20` Subnetwork Capacity Planning:**
  The subnetwork (`umzy-app-subnet-01`) is configured with a `/20` IPv4 CIDR range (`10.128.0.0/20`), providing **4,094 usable host IP addresses** (`10.128.0.1` to `10.128.15.254`). This sizing satisfies enterprise growth requirements for running auto-scaling Compute groups, Google Kubernetes Engine (GKE) nodes, and internal Load Balancers.

---

### 2. Zero-Trust Perimeter & Security Governance
* **Implicit Deny Ingress Model:**
  GCP VPC networks operate under a strict default-deny policy for incoming traffic. No ports are reachable from the public internet unless an explicit `google_compute_firewall` ingress resource is defined.
* **Tag-Based Firewalls (Least-Privilege Enforcement):**
  Instead of binding firewall rules to static IP addresses or applying them network-wide, access is granted strictly to workloads bearing specific **Network Tags**:
  * **`allow_ssh`:** Opens TCP Port 22 only to instances bearing the `ssh` network tag.
  * **`allow_http`:** Opens TCP Port 80 only to instances bearing the `web-server` network tag.
  * **Default Blocked Traffic:** Port 443 (HTTPS) and all unlisted ports are blocked at the GCP edge boundary.
* **Dynamic Dependency Chaining (Zero Hardcoding):**
  The VPC module dynamically collects target tags using `tolist(setunion(google_compute_firewall.allow_ssh.target_tags, google_compute_firewall.allow_http.target_tags))` and exports them via `firewall_target_tags`. The Compute module consumes this output (`tags = module.vpc.firewall_target_tags`), ensuring that any modification to firewall rules instantly updates the VM tags without requiring code refactoring.

---

### 3. Compute Layer & Automated Bootstrapping Lifecycle
* **Compute Instance Profile:**
  Provisioned using `google_compute_instance` configured with cost-optimized compute profiles (`e2-micro` for development, `e2-standard-2` for production) running `Debian 12 Bookworm`.
* **Public Internet Gateway:**
  Each VM includes an `access_config {}` block under its `network_interface` mapping, assigning a public ephemeral IPv4 address to enable direct HTTP/SSH access and outbound internet connectivity.
* **Out-of-Band Application Bootstrapping:**
  Software installation is externalized via Terraform's `file("${path.module}/scripts/startup.sh")` function. During VM initialization, GCP's metadata agent executes the script to:
  1. Update Debian package repositories and install `apache2` and `curl`.
  2. Enable and start the Apache web service.
  3. Query GCP's internal metadata server (`http://metadata.google.internal/computeMetadata/v1/`) for runtime metrics (hostname, internal IP, external IP, app version).
  4. Dynamically generate `/var/www/html/index.html` to present live system information upon deployment.

---

### 4. Modular Infrastructure Blueprint & State Parity
* **DRY (Don't Repeat Yourself) Modularization:**
  Infrastructure definitions are split into reusable modules (`modules/vpc` and `modules/compute`). Environment root modules (`environments/dev` and `environments/prod`) invoke identical underlying modules with environment-specific input variables.
* **Environment State Isolation:**
  `dev` and `prod` maintain isolated Terraform state files, preventing accidental state contamination or blast-radius propagation during maintenance runs.

---

## 🗂️ Repository Directory Structure

```text
umzy-gcp-terraform/
├── README.md                      # Architecture blueprint & execution guide
├── gcp_architecture_diagram.jpg   # Architecture diagram visual asset
├── main.tf                        # Root entrypoint
├── provider.tf                    # Root GCP provider settings (Region: us-south1)
├── variables.tf                   # Global input variables
├── terraform.tfvars               # Global variable overrides
├── outputs.tf                     # Global project outputs
├── compliance/                    # Compliance & audit logging directory
├── modules/                       # Reusable Core Infrastructure Modules
│   ├── vpc/                       # Custom VPC, Subnet, and Firewall Rules
│   │   ├── vpc.tf                 # Network & Subnet resource declarations
│   │   ├── firewall.tf            # SSH (22) and HTTP (80) Firewall rules
│   │   ├── variables.tf           # Module input variables
│   │   └── outputs.tf             # Outputs & Dynamic target_tags
│   └── compute/               # Compute Engine VM Module
│       ├── compute.tf             # Compute instance & boot disk declaration
│       ├── variables.tf           # Module input variables
│       ├── outputs.tf             # Instance IP & Web Server URL outputs
│       └── scripts/
│           └── startup.sh         # Apache installation & dynamic HTML metadata script
└── environments/                  # Environment Invocations
    ├── dev/                       # Development Environment (Active)
    │   ├── main.tf                # Invokes VPC & Compute modules
    │   ├── variables.tf           # Dev environment variables
    │   ├── terraform.tfvars       # Dev environment values (IP CIDR, Instance Name)
    │   ├── provider.tf            # Provider configuration
    │   └── outputs.tf             # Dev environment outputs
    └── prod/                      # Production Environment
        ├── main.tf                # Invokes VPC & Compute modules
        ├── variables.tf           # Prod environment variables
        ├── terraform.tfvars       # Prod-specific values
        ├── provider.tf            # Provider configuration
        └── outputs.tf             # Prod environment outputs
```

---

## 📊 Environment Specification Matrix

| Attribute | Development (`dev`) | Production (`prod`) |
| :--- | :--- | :--- |
| **VPC Network Name** | `umzy-vpc-dev` | `umzy-vpc-prod` |
| **Subnet Name** | `umzy-app-subnet-01` | `umzy-app-subnet-01` |
| **Subnet CIDR Range** | `10.128.0.0/20` (4,094 IPs) | `10.128.0.0/20` (4,094 IPs) |
| **VM Instance Names** | `umzy-app-vm-dev-01`, `umzy-app-vm-dev-02` (2 VMs) | `umzy-app-vm-prod-01`, `umzy-app-vm-prod-02` (2 VMs) |
| **Public Ephemeral IPs** | Dedicated Public IP per VM instance | Dedicated Public IP per VM instance |
| **Compute Profile** | `e2-micro` (0.25–2 vCPU, 1 GB RAM) | `e2-standard-2` (2 vCPU, 8 GB RAM) |
| **OS Distribution** | `Debian 12 Bookworm` | `Debian 12 Bookworm` |
| **GCP Region / Zone** | `us-south1` (`us-south1-a`) | `us-south1` (`us-south1-a`) |
| **Firewall Target Tags** | `["ssh", "web-server"]` | `["ssh", "web-server"]` |

---

## 🛠️ CLI Execution Commands

### 1. Authenticate with GCP
```bash
gcloud auth application-default login
```

### 2. Deploy Environment (`dev`)
```bash
cd environments/dev
terraform init
terraform plan
terraform apply -auto-approve
```

### 3. Teardown Environment (`dev`)
```bash
cd environments/dev
terraform destroy -auto-approve
```

</div>
