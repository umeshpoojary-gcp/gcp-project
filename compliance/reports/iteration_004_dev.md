# Terraform Compliance Audit Report - Iteration #004 (Scenario 4: Single Region 4-VM Scale Set)

- **Iteration ID**: `DEV-004`
- **Deployment Timestamp**: `2026-08-06 15:38:31 CST`
- **Target Environment**: `dev` ([`environments/dev`](../../environments/dev))
- **Profile File**: [`environments/dev/scale-set.tfvars`](../../environments/dev/scale-set.tfvars)
- **Region**: `us-south1` (South US / Dallas, TX)
- **Status**: **DEPLOYED & ACTIVE**

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
module.vpc.google_compute_network.vpc_network: Creation complete after 11s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/networks/umzy-vpc-scaleset]
module.vpc.google_compute_firewall.allow_http: Creation complete after 11s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/firewalls/umzy-vpc-scaleset-allow-http]
module.vpc.google_compute_firewall.allow_ssh: Creation complete after 11s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/firewalls/umzy-vpc-scaleset-allow-ssh]
module.vpc.google_compute_subnetwork.subnet["us_south1"]: Creation complete after 21s [id=projects/project-f69b612e-dd6f-4ddc-a25/regions/us-south1/subnetworks/umzy-subnet-us-south1]
module.compute_us_south1[0].google_compute_instance.vm_instance[0]: Creation complete after 12s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/us-south1-a/instances/umzy-app-vm-scaleset-01]
module.compute_us_south1[0].google_compute_instance.vm_instance[1]: Creation complete after 12s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/us-south1-a/instances/umzy-app-vm-scaleset-02]
module.compute_us_south1[0].google_compute_instance.vm_instance[2]: Creation complete after 12s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/us-south1-a/instances/umzy-app-vm-scaleset-03]
module.compute_us_south1[0].google_compute_instance.vm_instance[3]: Creation complete after 12s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/us-south1-a/instances/umzy-app-vm-scaleset-04]

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

subnets = {
  "us_south1" = {
    "id" = "projects/project-f69b612e-dd6f-4ddc-a25/regions/us-south1/subnetworks/umzy-subnet-us-south1"
    "ip_cidr_range" = "10.128.0.0/20"
    "name" = "umzy-subnet-us-south1"
    "region" = "us-south1"
  }
}
vm_us_south1_internal_ips = [
  "10.128.0.2",
  "10.128.0.4",
  "10.128.0.5",
  "10.128.0.3",
]
vm_us_south1_public_ips = [
  "34.174.201.249",
  "34.174.30.41",
  "34.174.15.90",
  "34.174.10.164",
]
vm_us_south1_web_urls = [
  "http://34.174.201.249",
  "http://34.174.30.41",
  "http://34.174.15.90",
  "http://34.174.10.164",
]
vpc_id = "projects/project-f69b612e-dd6f-4ddc-a25/global/networks/umzy-vpc-scaleset"
vpc_name = "umzy-vpc-scaleset"
```
- **Status**: **8 ADDED, 0 CHANGED, 0 DESTROYED**

---

## 4. Compliance Verification Checklist

| Rule | Requirement | Status | Verification Detail |
| :--- | :--- | :--- | :--- |
| **Scale Set Sizing** | 4 Compute Engine VMs in `us-south1-a` | **COMPLIANT** | VMs `umzy-app-vm-scaleset-01..04` provisioned |
| **Subnet CIDR Mandate** | Subnet must use `10.128.0.0/20` | **COMPLIANT** | Subnet `umzy-subnet-us-south1` active |
| **Modular Execution** | Invoked `-var-file="scale-set.tfvars"` | **COMPLIANT** | Dynamic conditional module execution verified |
| **Audit Logging** | State outputs recorded | **COMPLIANT** | 4 Public IPs & Web URLs captured in log |
