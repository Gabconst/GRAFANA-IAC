#!/bin/bash

if [ ! -f ../compute/terraform.tfstate ]; then
  echo "Terraform state file not found."
  exit 1
fi

TF_STATE_IP=$(terraform -chdir=../compute output -raw instance_ip)

cat <<END_OF_JSON
{
  "grafana-servers": {
    "hosts": [
      "$TF_STATE_IP"
    ],
    "vars": {
      "ansible_user": "ubuntu",
      "ansible_ssh_private_key_file": "../compute/devops-pdi.pem"
    }
  }
}
END_OF_JSON