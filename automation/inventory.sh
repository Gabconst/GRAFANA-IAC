#!/usr/bin/env bash

# Caminho absoluto para evitar erro de execução
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -f "$BASE_DIR/../compute/terraform.tfstate" ]; then
  echo "Terraform state file not found." >&2
  exit 1
fi

TF_STATE_IP=$(terraform -chdir="$BASE_DIR/../compute" output -raw instance_ip)

cat <<EOF
{
  "grafana-servers": {
    "hosts": ["$TF_STATE_IP"],
    "vars": {
      "ansible_host": "$TF_STATE_IP",
      "ansible_user": "ubuntu",
      "ansible_ssh_private_key_file": "$BASE_DIR/../compute/devops-pdi.pem"
    }
  }
}
EOF
