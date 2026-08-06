# Terraform Compliance Audit Report - Iteration #002 (Dev Environment Deployment)

- **Iteration ID**: `DEV-002`
- **Deployment Timestamp**: `2026-08-06 12:42:43 CST`
- **Target Environment**: `dev` ([`environments/dev`](../../environments/dev))
- **Mandated Region**: `us-south1` (GCP Dallas, TX)
- **Status**: **DEPLOYED & ACTIVE**

---

## 1. `terraform init` Output Log

```
Initializing the backend...
Initializing modules...
- compute in ..\..\modules\compute
- vpc in ..\..\modules\vpc

Initializing provider plugins...
- Finding hashicorp/google versions matching "~> 5.0"...
- Using hashicorp/google v5.45.2 from the shared cache directory

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
module.vpc.google_compute_firewall.allow_http: Creating...
module.vpc.google_compute_firewall.allow_ssh: Creating...
module.vpc.google_compute_firewall.allow_http: Creation complete after 12s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/firewalls/umzy-vpc-dev-allow-http]
module.vpc.google_compute_firewall.allow_ssh: Creation complete after 12s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/firewalls/umzy-vpc-dev-allow-ssh]
module.vpc.google_compute_subnetwork.subnet: Creation complete after 21s [id=projects/project-f69b612e-dd6f-4ddc-a25/regions/us-south1/subnetworks/umzy-app-subnet-01]
module.compute.google_compute_instance.vm_instance[1]: Creating...
module.compute.google_compute_instance.vm_instance[0]: Creating...
module.compute.google_compute_instance.vm_instance[0]: Creation complete after 12s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/us-south1-a/instances/umzy-app-vm-dev-01]
module.compute.google_compute_instance.vm_instance[1]: Creation complete after 22s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/us-south1-a/instances/umzy-app-vm-dev-02]

Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

Outputs:

instance_internal_ips = [
  "10.128.0.3",
  "10.128.0.2",
]
instance_names = [
  "umzy-app-vm-dev-01",
  "umzy-app-vm-dev-02",
]
instance_public_ips = [
  "34.174.10.164",
  "34.174.201.249",
]
subnet_id = "projects/project-f69b612e-dd6f-4ddc-a25/regions/us-south1/subnetworks/umzy-app-subnet-01"
subnet_ip_cidr = "10.128.0.0/20"
subnet_name = "umzy-app-subnet-01"
subnet_self_link = "https://www.googleapis.com/compute/v1/projects/project-f69b612e-dd6f-4ddc-a25/regions/us-south1/subnetworks/umzy-app-subnet-01"
vpc_id = "projects/project-f69b612e-dd6f-4ddc-a25/global/networks/umzy-vpc-dev"
vpc_name = "umzy-vpc-dev"
vpc_self_link = "https://www.googleapis.com/compute/v1/projects/project-f69b612e-dd6f-4ddc-a25/global/networks/umzy-vpc-dev"
web_server_urls = [
  "http://34.174.10.164",
  "http://34.174.201.249",
]
```
- **Status**: **6 ADDED, 0 CHANGED, 0 DESTROYED**

---

## 4. Compliance Verification Checklist

| Rule | Requirement | Status | Verification Detail |
| :--- | :--- | :--- | :--- |
| **Region Mandate** | Region must be `us-south1` (Dallas) | **COMPLIANT** | Subnet deployed to `regions/us-south1/subnetworks/umzy-app-subnet-01`, VMs in `us-south1-a` |
| **Modular Standard** | Resources must consume `./modules/vpc` and `./modules/compute` | **COMPLIANT** | Modules `module.vpc` & `module.compute` successfully provisioned |
| **Audit Logging** | State outputs recorded | **COMPLIANT** | Public IPs and web server endpoints captured in compliance log |
