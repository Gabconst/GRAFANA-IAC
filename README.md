# Projeto de Automação de Infraestrutura (PDI-DevOps)

Este projeto demonstra a automação completa de infraestrutura usando **Terraform** para provisionar recursos e **Ansible** para configurá-los. O objetivo principal é seguir a metodologia de **Infraestrutura como Código (IaC)**, garantindo que o ambiente seja replicável e gerenciável.

## Estrutura de Diretórios

A estrutura abaixo mostra como os arquivos estão organizados para separar as responsabilidades de provisionamento e configuração.

## Pré-requisitos

Antes de começar, certifique-se de que os seguintes softwares estão instalados e configurados na sua máquina local:

- **Terraform**: Versão `1.0` ou superior.
- **Ansible**: Versão `2.9` ou superior.
- **Chave SSH**: É crucial ter a chave `devops-pdi.pem` na pasta `lab/compute/terraform` e com as permissões corretas (`chmod 400 devops-pdi.pem`) para que o Ansible possa se conectar aos servidores.

## Guia de Execução

Siga a ordem dos passos para garantir o funcionamento correto do pipeline de automação.

### 1. Provisionamento da Infraestrutura com Terraform

Navegue para o diretório `lab/compute/terraform` e execute os comandos:

```bash
# Inicializa o diretório de trabalho e baixa os provedores
cd lab/compute/terraform
terraform init

# Visualiza o plano de execução antes de aplicar as mudanças
terraform plan

# Aplica as mudanças para provisionar a infraestrutura
terraform apply --auto-approve

# Navega para o diretório do Ansible
cd ../../.ansible/automation

# Executa o playbook usando o inventário dinâmico e a chave SSH
ansible-playbook -i inventory.sh --private-key ../../compute/terraform/devops-pdi.pem playbook.yml

# Navega de volta para o diretório do Terraform
cd ../../compute/terraform

# Destrói toda a infraestrutura provisionada
terraform destroy --auto-approve
