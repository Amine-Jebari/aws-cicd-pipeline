# AWS CI/CD Pipeline with Terraform

Automated infrastructure deployment pipeline using **Terraform**, **GitHub Actions**, and **AWS OIDC authentication**—no static credentials required.

## Architecture

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   GitHub     │───▶|    GitHub     |───▶│     AWS      |
│   Actions    │     │    OIDC      │     │   (Deploy)   │
└──────────────┘     └──────────────┘     └──────────────┘
       │                                         │
       ▼                                         ▼
┌──────────────┐                         ┌──────────────┐
│  PR: Plan    │                         │  S3 + Dynamo │
│  Merge: Apply│                         │  (TF State)  │
└──────────────┘                         └──────────────┘
```

## Features

- **Secure Authentication** — OIDC-based AWS access with short-lived tokens
- **GitOps Workflow** — Pull request validation with automatic plan comments
- **Remote State** — S3 backend with DynamoDB locking
- **Infrastructure as Code** — Fully declarative, version-controlled infrastructure

## Project Structure

```
├── main.tf              # AWS provider and demo S3 bucket
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── backend.tf           # Remote state configuration
├── github-oidc.tf       # OIDC authentication setup
└── .github/workflows/
    ├── terraform-ci.yml # PR validation workflow
    └── terraform-cd.yml # Deployment workflow
```

## Quick Start

### Prerequisites

- AWS Account with admin access
- GitHub Account
- Terraform >= 1.0.0
- AWS CLI configured

### Setup

1. **Configure GitHub username** in `variables.tf`:
   ```hcl
   variable "github_org" {
     default = "your-username"
   }
   ```

2. **Deploy infrastructure**:
   ```bash
   terraform init
   terraform apply
   ```

3. **Add GitHub secret** (`Settings → Secrets → Actions`):
   | Name | Value |
   |------|-------|
   | `AWS_ROLE_ARN` | Output from `terraform apply` |

4. **Push to GitHub** and create a PR to test the pipeline

## Pipeline Workflow

| Trigger | Actions |
|---------|---------|
| **Pull Request** | Format check → Validate → Plan → Comment results |
| **Merge to main** | Apply changes → Output deployed resources |



## Cleanup

```bash
terraform destroy
```

## Technologies

![Terraform](https://img.shields.io/badge/Terraform-844FBA?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?logo=amazonwebservices&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?logo=github-actions&logoColor=white)

## License

MIT
