#!/bin/bash

# This script sets up a secure GCP reference architecture using Terraform.
# Reference: https://www.hashicorp.com/blog/building-a-secure-gcp-reference-architecture-with-terraform

# Ensure gcloud CLI is installed and authenticated
if ! command -v gcloud &> /dev/null; then
    echo "❌ gcloud CLI is not installed. Please install it first."
    exit 1
fi

echo "ℹ️ Ensure you are authenticated with gcloud CLI before proceeding."
read -p "Press Enter to continue..."

# Initialize Terraform
terraform init || { echo "❌ Terraform initialization failed"; exit 1; }

# Validate Terraform configuration
terraform validate || { echo "❌ Terraform validation failed"; exit 1; }

# Plan the deployment
terraform plan -out=tfplan || { echo "❌ Terraform plan failed"; exit 1; }

# Apply the deployment
terraform apply tfplan || { echo "❌ Terraform apply failed"; exit 1; }

echo "✅ Secure GCP reference architecture deployed successfully!"
