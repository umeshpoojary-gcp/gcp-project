# Terraform Compliance Audit Report - Iteration #003 (Multi-Region Deployment - umzy-multivm-regional)

- **Iteration ID**: `DEV-003`
- **Deployment Timestamp**: `2026-08-06 14:24:28 CST`
- **Target Environment**: `dev` ([`environments/dev`](../../environments/dev))
- **Project Name**: `umzy-multivm-regional`
- **Regions**: `us-south1` (South US / Dallas, TX) & `europe-west1` (Western Europe / Belgium)
- **Status**: **DESTROYED (7 Removed)**

---

## 1. `terraform init` Output Log

```
Initializing the backend...
Initializing modules...
- compute_europe_west1 in ..\..\modules\compute
- compute_us_south1 in ..\..\modules\compute
- vpc in ..\..\modules\vpc

Initializing provider plugins...
- Reusing previous version of hashicorp/google from the dependency lock file
- Using previously-installed hashicorp/google v5.45.2

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
module.vpc.google_compute_network.vpc_network: Creation complete after 22s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/networks/umzy-vpc-regional]
module.vpc.google_compute_firewall.allow_http: Creation complete after 11s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/firewalls/umzy-vpc-regional-allow-http]
module.vpc.google_compute_firewall.allow_ssh: Creation complete after 11s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/firewalls/umzy-vpc-regional-allow-ssh]
module.vpc.google_compute_subnetwork.subnet["us_south1"]: Creation complete after 20s [id=projects/project-f69b612e-dd6f-4ddc-a25/regions/us-south1/subnetworks/umzy-subnet-us-south1]
module.vpc.google_compute_subnetwork.subnet["europe_west1"]: Creation complete after 37s [id=projects/project-f69b612e-dd6f-4ddc-a25/regions/europe-west1/subnetworks/umzy-subnet-europe-west1]
module.compute_us_south1.google_compute_instance.vm_instance[0]: Creation complete after 12s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/us-south1-a/instances/umzy-vm-us-south1]
module.compute_europe_west1.google_compute_instance.vm_instance[0]: Creation complete after 28s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/europe-west1-b/instances/umzy-vm-europe-west1]

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

subnets = {
  "europe_west1" = {
    "id" = "projects/project-f69b612e-dd6f-4ddc-a25/regions/europe-west1/subnetworks/umzy-subnet-europe-west1"
    "ip_cidr_range" = "10.132.0.0/20"
    "name" = "umzy-subnet-europe-west1"
    "region" = "europe-west1"
  }
  "us_south1" = {
    "id" = "projects/project-f69b612e-dd6f-4ddc-a25/regions/us-south1/subnetworks/umzy-subnet-us-south1"
    "ip_cidr_range" = "10.128.0.0/20"
    "name" = "umzy-subnet-us-south1"
    "region" = "us-south1"
  }
}
vm_europe_west1_internal_ip = [ "10.132.0.2" ]
vm_europe_west1_public_ip   = [ "34.79.157.57" ]
vm_europe_west1_web_url     = [ "http://34.79.157.57" ]
vm_us_south1_internal_ip    = [ "10.128.0.2" ]
vm_us_south1_public_ip      = [ "34.174.10.164" ]
vm_us_south1_web_url        = [ "http://34.174.10.164" ]
vpc_id                      = "projects/project-f69b612e-dd6f-4ddc-a25/global/networks/umzy-vpc-regional"
vpc_name                    = "umzy-vpc-regional"
```
- **Status**: **7 ADDED, 0 CHANGED, 0 DESTROYED**

---

## 4. Compliance Verification Checklist

| Rule | Requirement | Status | Verification Detail |
| :--- | :--- | :--- | :--- |
| **Multi-Region Deployment** | 2 VMs across 2 regions (`us-south1` & `europe-west1`) | **COMPLIANT** | Subnets `umzy-subnet-us-south1` (`10.128.0.0/20`) & `umzy-subnet-europe-west1` (`10.132.0.0/20`) active |
| **Subnet CIDR Mandate** | Europe West subnet must use `10.132.0.0/20` | **COMPLIANT** | Deployed `10.132.0.0/20` in `europe-west1` |
| **Modular Standard** | Dynamic `modules/vpc` multi-subnet map + `modules/compute` | **COMPLIANT** | Modules provisioned and endpoints reachable |
| **Audit Logging** | State outputs recorded | **COMPLIANT** | Public IPs (`34.174.10.164` & `34.79.157.57`) captured in log |
