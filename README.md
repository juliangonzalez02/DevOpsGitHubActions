# DevOps with GitHub Actions

This is a personal DevOps/DevSecOps project leveraging GitHub Actions, Docker, Azure Container Registry, and Azure Container Apps.

The goal of this project is to learn how to build, validate, maintain, containerize, secure, and deploy a web app using a professional CI/CD pipeline.

## Security

This project utilizes Azure OpenID Connect to authenticate GitHub Actions requests with short-lived identity tokens.

Security is built into the CI/CD pipelines to ensure supply-chain security. npm audit and Docker Scout are leveraged in order to prevent known Common Vulnerabilities and Exposures from being pushed to the main branch.

## Stack
* HTML
* JavaScript
* Node.js / npm
* ESLint
* Vitest
* GitHub Actions
* Docker
* Azure Container Registry
* Azure Container Apps

## Local Dependencies

* Git
* Node.js
* npm
* Docker