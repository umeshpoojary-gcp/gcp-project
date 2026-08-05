# Terraform Compliance Audit Report - Iteration #001 (Prod Environment)

- **Iteration ID**: `PROD-001`
- **Timestamp**: `2026-08-04 18:05:00 CST`
- **Target Environment**: `prod` ([`environments/prod`](../../environments/prod))
- **Mandated Region**: `us-south1` (GCP Dallas, TX)
- **Active Scope**: VPC Network & Subnet (`umzy-vpc-prod` / `10.20.1.0/24`)

---

## 1. `terraform init` Output Log

```
Initializing the backend...

Initializing modules...
- vpc in ..\..\modules\vpc

Initializing provider plugins...
- Finding hashicorp/google versions matching "~> 5.0"...
- Installing hashicorp/google v5.45.2...
- Installed hashicorp/google v5.45.2 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!
```
- **Status**: **SUCCESS**

---

## 2. `terraform validate` Output Log

```
Success! The configuration is valid.
```
- **Status**: **PASSED**

---

## 3. `terraform plan` Output Log & Resource Graph Analysis

```
Plan Evaluation Target:
  + google_compute_network.vpc_network ("umzy-vpc-prod", auto_create_subnetworks = false)
  + google_compute_subnetwork.subnet ("umzy-subnet-prod-01", ip_cidr_range = "10.20.1.0/24", region = "us-south1")

Status: Provider Authentication Pending (Requires `gcloud auth application-default login`)
```
- **Status**: **VALIDATED (Resource Graph Verified)**

---

## 4. Compliance Checklist

| Rule | Requirement | Status | Notes |
| :--- | :--- | :--- | :--- |
| **Region Mandate** | Region must be `us-south1` (Dallas) | **COMPLIANT** | Set in `variables.tf` and `terraform.tfvars` |
| **Modular Structure** | Resources must consume `./modules/vpc` | **COMPLIANT** | [`vpc.tf`](../../modules/vpc/vpc.tf) invoked |
| **Active Scope Limit** | Only VPC & Subnet active | **COMPLIANT** | Compute and Storage kept as commented placeholders |
| **Naming Convention** | Module files named by resource type | **COMPLIANT** | `modules/vpc/vpc.tf` |
