# Terraform Compliance Audit Report - Iteration #001 (Dev Environment Deployment)

- **Iteration ID**: `DEV-001`
- **Deployment Timestamp**: `2026-08-04 18:40:52 CST`
- **Target Environment**: `dev` ([`environments/dev`](../../environments/dev))
- **Mandated Region**: `us-south1` (GCP Dallas, TX)
- **Status**: **DEPLOYED & ACTIVE**

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

## 3. `terraform apply` Execution Result Log

```
module.vpc.google_compute_network.vpc_network: Creating...
module.vpc.google_compute_network.vpc_network: Creation complete after 22s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/networks/umzy-vpc-dev]
module.vpc.google_compute_subnetwork.subnet: Creating...
module.vpc.google_compute_subnetwork.subnet: Creation complete after 11s [id=projects/project-f69b612e-dd6f-4ddc-a25/regions/us-south1/subnetworks/umzy-subnet-dev-01]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

subnet_id = "projects/project-f69b612e-dd6f-4ddc-a25/regions/us-south1/subnetworks/umzy-subnet-dev-01"
subnet_ip_cidr = "10.10.1.0/24"
subnet_name = "umzy-subnet-dev-01"
subnet_self_link = "https://www.googleapis.com/compute/v1/projects/project-f69b612e-dd6f-4ddc-a25/regions/us-south1/subnetworks/umzy-subnet-dev-01"
vpc_id = "projects/project-f69b612e-dd6f-4ddc-a25/global/networks/umzy-vpc-dev"
vpc_name = "umzy-vpc-dev"
vpc_self_link = "https://www.googleapis.com/compute/v1/projects/project-f69b612e-dd6f-4ddc-a25/global/networks/umzy-vpc-dev"
```
- **Status**: **2 ADDED, 0 CHANGED, 0 DESTROYED**

---

## 4. Compliance Verification Checklist

| Rule | Requirement | Status | Verification Detail |
| :--- | :--- | :--- | :--- |
| **Region Mandate** | Region must be `us-south1` (Dallas) | **COMPLIANT** | Deployed to `regions/us-south1/subnetworks/umzy-subnet-dev-01` |
| **Modular Standard** | Resources must consume `./modules/vpc` | **COMPLIANT** | Resource `module.vpc.google_compute_network.vpc_network` |
| **Active Scope Limit** | Only VPC & Subnet active | **COMPLIANT** | Compute and Storage kept as commented placeholders |
| **Audit Logging** | State outputs recorded | **COMPLIANT** | Outputs captured in audit log |
