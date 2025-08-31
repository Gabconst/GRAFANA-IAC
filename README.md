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

1.  Navegue até a pasta `compute`:
    ```bash
    cd compute
    ```
2.  Inicie o Terraform:
    ```bash
    terraform init
    ```
3.  Execute o `terraform apply` para criar a infraestrutura na AWS:
    ```bash
    terraform apply --auto-approve
    ```
    O IP público da sua instância será salvo no `terraform.tfstate`.

#### Fase 2: Configuração com Ansible

1.  Navegue até a pasta `automation`:
    ```bash
    cd ../automation
    ```
2.  Execute o playbook do Ansible:
    ```bash
    ansible-playbook -i inventory.sh playbook.yml --ask-vault-pass
    ```
      * O inventário dinâmico (`-i inventory.sh`) encontrará o IP da instância automaticamente.
      * O `--ask-vault-pass` pedirá a senha que você usou para criptografar o arquivo `grafana-servers.yml`.

-----

### Gerenciamento de Variáveis e Senhas

  * **Terraform:** As variáveis de configuração estão no `terraform.tfvars`. Para alterá-las, basta editar este arquivo.
  * **Ansible Vault:** Para gerenciar o arquivo criptografado do Ansible:
      * **Ver conteúdo:** `ansible-vault view group_vars/grafana-servers.yml`
      * **Editar:** `ansible-vault edit group_vars/grafana-servers.yml`