# Terraform Compliance Audit Report - Iteration #005 (Scenario 5: 4-VM Scale Set with External HTTP Load Balancer & Health Checks)

- **Iteration ID**: `DEV-005`
- **Deployment Timestamp**: `2026-08-06 15:58:55 CST`
- **Target Environment**: `dev` ([`environments/dev`](../../environments/dev))
- **Profile File**: [`environments/dev/load-balancer.tfvars`](../../environments/dev/load-balancer.tfvars)
- **Region**: `us-south1` (South US / Dallas, TX)
- **Status**: **DEPLOYED & ACTIVE**

---

## 1. `terraform init` Output Log

```
Initializing the backend...
Initializing modules...
- load_balancer in ..\..\modules\lb_http
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
module.load_balancer[0].google_compute_health_check.http_check: Creation complete after 11s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/healthChecks/umzy-web-lb-health-check]
module.load_balancer[0].google_compute_instance_group.web_group: Creation complete after 11s [id=projects/project-f69b612e-dd6f-4ddc-a25/zones/us-south1-a/instanceGroups/umzy-web-lb-ig]
module.load_balancer[0].google_compute_backend_service.backend_service: Creation complete after 2m15s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/backendServices/umzy-web-lb-backend]
module.load_balancer[0].google_compute_url_map.url_map: Creation complete after 12s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/urlMaps/umzy-web-lb-url-map]
module.load_balancer[0].google_compute_target_http_proxy.http_proxy: Creation complete after 11s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/targetHttpProxies/umzy-web-lb-http-proxy]
module.load_balancer[0].google_compute_global_forwarding_rule.forwarding_rule: Creation complete after 22s [id=projects/project-f69b612e-dd6f-4ddc-a25/global/forwardingRules/umzy-web-lb-forwarding-rule]

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

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
- **Status**: **7 ADDED, 0 CHANGED, 0 DESTROYED**

---

## 4. Compliance Verification Checklist

| Rule | Requirement | Status | Verification Detail |
| :--- | :--- | :--- | :--- |
| **HTTP Load Balancer** | GCP External Forwarding Rule + Target Proxy + URL Map | **COMPLIANT** | Provisioned Load Balancer IP: `8.233.214.139` |
| **HTTP Health Check** | Port 80 `/` health check | **COMPLIANT** | Created `umzy-web-lb-health-check` |
| **Backend Round-Robin** | Backend service balancing mode | **COMPLIANT** | Attached Instance Group `umzy-web-lb-ig` (4 VMs) |
| **Modular Code Isolation** | Reusable `modules/lb_http` module | **COMPLIANT** | Dynamic conditional invocation in `environments/dev/main.tf` |
| **Audit Logging** | State outputs recorded | **COMPLIANT** | Load Balancer URL `http://8.233.214.139` recorded |
