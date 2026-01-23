# Automation-Workflows
Centralized repository for reusable GitHub Actions workflows and custom composite actions used across multiple projects.
# Automation-Workflows

Centralized repository for reusable **GitHub Actions workflows** and **custom GitHub Actions** used to standardize CI/CD processes across multiple projects.

This repository is designed to separate **automation logic** from **application code**, following real-world DevOps best practices.

---

## Purpose

- Centralize CI/CD automation
- Avoid duplication across projects
- Enforce consistent build, security, and deployment standards
- Provide reusable workflows and actions for application repositories

---

## Repository Structure

- **workflows/**: Contains reusable GitHub Actions workflows
- **actions/**: Contains custom GitHub Actions

```
Automation-Workflows/
├── .github/
│   ├── workflows/
│   └── actions/
│       └── react-docker-s2i/
│           ├── action.yml
│           ├── Dockerfile.react
│           └── entrypoint.sh
└── README.md
```

---

## Reusable Workflows

### .NET CI Reusable Workflow

**Location:**  
`.github/workflows/dotnet.yml`

**Description:**  
Reusable CI workflow for ASP.NET Core applications.

**Responsibilities:**
- Restore and build the .NET project
- Run unit tests (optional)
- Scan for secrets using GitLeaks
- Perform static code analysis using CodeQL
- Build and push Docker images to GHCR
- Scan Docker images using Trivy

This workflow is consumed by application repositories using the `uses:` keyword.

---

## Custom GitHub Actions

### React Docker S2I Action

**Location:**  
`.github/actions/react-docker-s2i/`

**Type:**  
Docker-based custom GitHub Action

**Purpose:**  
Build and push a production-ready React Docker image using a Source-to-Image (S2I) approach.

**Action Responsibilities:**
- Validate existence of React build output (`dist/`)
- Prepare Docker build context internally
- Build a lightweight Nginx-based Docker image
- Push the image to GitHub Container Registry (GHCR)

---

## Design Principles

- No hardcoded secrets
- Environment-based configuration
- Clear separation between application code and automation logic
- Reusable and scalable CI/CD components
- Fail-fast validation with clear error messages

---

## Usage

This repository is intended to be referenced by other repositories as a centralized automation source.

Example usage:

```yaml
uses: salmataha88/Automation-Workflows/.github/workflows/dotnet.yml@main
```

---