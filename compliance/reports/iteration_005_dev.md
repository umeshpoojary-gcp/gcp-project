# Terraform Compliance Audit Report - Iteration #005 (Private-Only 4-VM Scale Set + External HTTP Load Balancer)

- **Iteration ID**: `DEV-005`
- **Deployment Timestamp**: `2026-08-06 16:41:39 CST`
- **Target Environment**: `dev` ([`environments/dev`](../../environments/dev))
- **Profile File**: [`environments/dev/load-balancer.tfvars`](../../environments/dev/load-balancer.tfvars)
- **Region**: `us-south1` (South US / Dallas, TX)
- **Security Mode**: **PRIVATE-ONLY VMs (Public IPs Removed)**
- **Status**: **DEPLOYED & ACTIVE**

---

## 1. `terraform init` Output Log

```
Initializing the backend...
Initializing modules...
- load_balancer in ..\..\modules\compute
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
module.compute_us_south1[0].google_compute_instance.vm_instance[0]: Modifications complete after 11s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/us-south1-a/instances/umzy-app-vm-scaleset-01]
module.compute_us_south1[0].google_compute_instance.vm_instance[3]: Modifications complete after 11s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/us-south1-a/instances/umzy-app-vm-scaleset-04]
module.compute_us_south1[0].google_compute_instance.vm_instance[2]: Modifications complete after 12s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/us-south1-a/instances/umzy-app-vm-scaleset-03]
module.compute_us_south1[0].google_compute_instance.vm_instance[1]: Modifications complete after 12s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/us-south1-a/instances/umzy-app-vm-scaleset-02]

Apply complete! Resources: 0 added, 4 changed, 0 destroyed.

Outputs:

load_balancer_public_ip = "8.233.214.139"
load_balancer_url = "http://8.233.214.139"
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
  "N/A (Private Only)",
  "N/A (Private Only)",
  "N/A (Private Only)",
  "N/A (Private Only)",
]
vm_us_south1_web_urls = [
  "N/A (Private Only)",
  "N/A (Private Only)",
  "N/A (Private Only)",
  "N/A (Private Only)",
]
vpc_id = "projects/project-f69b612e-dd6f-4ddc-a25/global/networks/umzy-vpc-scaleset"
vpc_name = "umzy-vpc-scaleset"
```
- **Status**: **0 ADDED, 4 CHANGED, 0 DESTROYED**

---

## 4. Compliance Verification Checklist

| Rule | Requirement | Status | Verification Detail |
| :--- | :--- | :--- | :--- |
| **Private-Only VMs** | Remove public access_config (nat_ip = null) | **COMPLIANT** | All 4 VMs updated in-place to Private-Only (`10.128.0.x`) |
| **Single Public Gateway** | External HTTP Load Balancer IP `8.233.214.139` | **COMPLIANT** | `http://8.233.214.139` tested & returning HTTP `200 OK` |
| **HTTP Health Check** | Port 80 `/` health check | **COMPLIANT** | Active health check `umzy-web-lb-health-check` |
| **Backend Round-Robin** | Load balancing across 4 private VMs | **COMPLIANT** | Target Instance Group `umzy-web-lb-ig` receiving traffic |
| **Audit Logging** | State outputs recorded | **COMPLIANT** | Public IPs confirmed `N/A (Private Only)` in audit log |
