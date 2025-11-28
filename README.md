# SkinCareQuiz

SkinCareQuiz is a React-based web application for skincare products and a skin-type quiz that provides personalized product recommendations.

This repository contains both the frontend (Vite + React) and a simple backend under `backend/`. It also includes deployment and CI/CD artifacts (Kubernetes manifests, Jenkinsfiles, Terraform snippets and monitoring config) used for demonstration and automation.

## Features

- SignUp / LogIn (local storage)
- Skin-type quiz for personalized recommendations
- Product list, product details, Add to Cart and wishlist functionality

## Technologies

- React.js
- Vite
- Tailwind CSS
- Node.js (backend)
- Docker, Kubernetes (EKS)
- Jenkins (CI/CD), Terraform (IAC)
- Prometheus / Grafana monitoring, Trivy scanning

## Quick start (development)

1. Clone the repository:

```bash
git clone https://github.com/Tanveernz/SkinCareQuiz.git
```

2. Install dependencies (frontend):

```bash
cd skinCare
npm install
```

3. Run the frontend dev server:

```bash
npm run dev
```

4. Backend (if you want to run locally):

```bash
cd backend
npm install
node index.js
```

Open the app at the URL shown by Vite (usually http://localhost:5173).

## Docker / Container

- Build the Docker image:

```bash
docker build -t tanveernz/skincarequiz:latest .
```

- Run locally:

```bash
docker run -d --name skincarequiz -p 3000:3000 tanveernz/skincarequiz:latest
```

## Kubernetes / EKS

This repo includes Kubernetes manifests in `kubernetes/` and example EKS commands in `kubernetes/Eks cluster setup commands`.

- `kubernetes/manifest.yml` — Deployment and Service (update image name and replicas as needed).
- `kubernetes/Jenkinsfile` — CI pipeline used for building, scanning and pushing images (update credential IDs and email addresses before use).

Notes:
- Replace placeholders in the Kubernetes and Jenkins files (Docker registry, credential IDs, email addresses, keypair names) with your values before running pipelines or creating clusters.
- The `Eks cluster setup commands` file contains `eksctl` commands; if you run them on Windows `cmd.exe` use single-line commands or PowerShell/Git Bash for line-continuations.

## CI/CD and Terraform

- `terraform/jenkinsfile` is a Jenkins pipeline that demonstrates running Terraform commands. It checks out the repo and runs `terraform init/plan/apply`. Review and replace the credential bindings before using in production.

## Monitoring

- `monitoring/promotheus_configfile.txt` includes example Prometheus scrape/blackbox targets. Replace `YOUR_APPLICATION_HOST`, `YOUR_BLACKBOX_HOST`, and `YOUR_NODE_IP` with actual hosts or configure Kubernetes service discovery.

## What I changed for this repository

I updated CI/Kubernetes/monitoring files that previously contained references to another project. Key files to review before using in your environment:

- `kubernetes/Jenkinsfile` — git URL, sonar project, docker image/tag, notification email (placeholders used)
- `kubernetes/manifest.yml` — updated deployment/service name and image
- `kubernetes/Eks cluster setup commands` — added 3rd AZ and replaced SSH key name with placeholder
- `monitoring/promotheus_configfile.txt` — replaced hard-coded IPs with placeholders
- `terraform/jenkinsfile` — updated git checkout URL to this repo

## Contributing

If you'd like to contribute, please open an issue or submit a PR. Before submitting a PR, ensure:

- All tests pass (if added)
- You update any deployment/CI manifest placeholders required for your changes

## License

This project does not include an explicit license — add one if you plan to open-source it.

---
