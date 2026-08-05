---
name: terraform-automation
description: Automate, validate, plan, and deploy GCP infrastructure using modular Terraform across multi-environment setups (dev and prod).
---

# Terraform Infrastructure Automation Skill

This skill provides standard operational procedures and best practices for automating GCP resource deployment using modular Terraform and generating compliance audit records across code iterations.

## 1. Mandatory Location & Region Rule

- **Default Region**: All GCP resources must be provisioned in the **GCP Dallas, Texas (`us-south1`)** region unless explicitly instructed otherwise by the user.
- **Default Zone**: Default zone is **`us-south1-a`**.

## 2. Mandatory Code Verification & Compliance Logging Rule

Whenever any `.tf` or `.tfvars` file is created, edited, or modified:
1. **Automated Validation**: The agent MUST run `terraform validate` in the target environment directory (`environments/dev` or `environments/prod`).
2. **Automated Plan**: Immediately after validation succeeds, the agent MUST run `terraform plan` to verify resource graph integrity and preview changes.
3. **Compliance Audit Report Generation**: The agent MUST record the outputs of `init`, `validate`, and `plan` into a timestamped audit report inside [`compliance/reports/`](../../compliance/reports) (e.g., `iteration_001_dev.md`) and update [`compliance/README.md`](../../compliance/README.md).

## 3. Active vs. Future Infrastructure Scope

- **Active Scope**: Currently, **only VPC Network and Subnet resources** are instantiated and active.
- **Future Modules**: Compute Engine (`modules/compute`) and Storage (`modules/storage`) are maintained as modular placeholders for future expansion and must remain commented out until requested.

## 4. Directory Structure

```
.
├── main.tf                    # Root environment entrypoint
├── provider.tf                # Root provider configuration
├── variables.tf               # Root input variables
├── outputs.tf                 # Root outputs
├── terraform.tfvars           # Root environment variable values
├── compliance/                # Audit & Compliance Logs
│   ├── README.md              # Compliance Index & Audit History
│   └── reports/               # Iteration Audit Reports
│       ├── iteration_001_dev.md
│       └── iteration_001_prod.md
├── modules/                   # Reusable, resource-specific modules
│   ├── vpc/                   # VPC & Subnet module
│   │   ├── vpc.tf             # VPC Network & Subnet resource definition
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── compute/               # GCE Compute Engine module
│   │   ├── compute.tf         # Compute Engine instance resource definition
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── storage/               # Google Cloud Storage bucket module
│       ├── storage.tf         # Storage Bucket resource definition
│       ├── variables.tf
│       └── outputs.tf
└── environments/              # Environment-specific deployment entrypoints
    ├── dev/                   # Development environment
    │   ├── main.tf            # Module invocations for dev
    │   ├── variables.tf       # Input variables schema
    │   ├── outputs.tf         # Environment outputs
    │   ├── provider.tf        # Provider & Terraform version constraints
    │   └── terraform.tfvars   # Dev-specific variable values
    └── prod/                  # Production environment
        ├── main.tf            # Module invocations for prod
        ├── variables.tf       # Input variables schema
        ├── outputs.tf         # Environment outputs
        ├── provider.tf        # Provider & Terraform version constraints
        └── terraform.tfvars   # Prod-specific variable values
```

## 5. Environment Selection & Workflow Guidelines

When selecting or working with an environment:

1. **Development (`environments/dev`)**:
   - Change directory to `environments/dev`.
   - Run `terraform init` to initialize modules and providers.
   - Run `terraform validate` to ensure configuration syntax is clean.
   - Run `terraform plan` to inspect changes targeted for dev in `us-south1`.
   - Save iteration log to `compliance/reports/iteration_<XXX>_dev.md`.

2. **Production (`environments/prod`)**:
   - Change directory to `environments/prod`.
   - Run `terraform init` to initialize modules and providers.
   - Run `terraform validate` to ensure configuration syntax is clean.
   - Run `terraform plan` to inspect changes targeted for prod in `us-south1`.
   - Save iteration log to `compliance/reports/iteration_<XXX>_prod.md`.

## 6. Naming Conventions & Standards

- **Resource-Specific Module Files**: In each module directory, main resource definitions must be named after the resource (e.g. `vpc.tf`, `compute.tf`, `storage.tf`).
- **Root & Environment Entrypoints**: Top-level and environment directory entrypoints maintain `main.tf`.
- **No Hardcoded Values**: All names, regions, Machine Types, CIDRs, and project IDs must be exposed as input variables in `variables.tf`.
- **Explicit Outputs**: Every module must declare outputs in `outputs.tf` for resource properties consumed by downstream modules or environment entrypoints.
