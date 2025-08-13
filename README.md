## README.md

### Implantação Automatizada de Grafana na AWS

Este projeto utiliza **Terraform** e **Ansible** para automatizar a implantação de uma infraestrutura de monitoramento com Grafana na AWS. O objetivo é seguir as melhores práticas, eliminando o *hardcode* e garantindo a segurança e reutilização do código.

-----

### Estrutura de Arquivos e Funções

A estrutura do seu projeto é organizada para separar as responsabilidades:

  * **Raiz do Projeto**

      * `.gitignore`: **Crucial para a segurança.** Este arquivo instrui o Git a ignorar arquivos sensíveis como sua chave SSH (`devops-pdi.pem`), o arquivo de estado do Terraform (`terraform.tfstate`) e os arquivos de variáveis (`terraform.tfvars`), garantindo que eles não sejam enviados para o GitHub.
      * `README.md`: Este arquivo, que você está lendo.

  * **`compute/` (Código do Terraform)**

      * `main.tf`: Define a instância EC2 e o Security Group.
      * `providers.tf`: Configura o provedor AWS, utilizando variáveis para o perfil e a região.
      * `variables.tf`: Declara todas as variáveis de entrada do Terraform, como `ami_id` e `instance_type`, sem valores padrão.
      * `terraform.tfvars`: **Este arquivo define os valores de todas as variáveis** declaradas em `variables.tf`. É aqui que você configura a AMI, o tipo de instância, etc. Este arquivo deve ser ignorado pelo Git.
      * `outputs.tf`: Expõe o IP público da instância, que é o ponto de conexão entre o Terraform e o Ansible.
      * `sua-chave.pem`: Sua chave SSH privada.

  * **`automation/` (Código do Ansible)**

      * `playbook.yml`: O playbook do Ansible que orquestra a instalação e a configuração do Grafana.
      * `group_vars/grafana-servers.yml`: **Arquivo de variáveis criptografado**. Ele armazena de forma segura a senha do administrador do Grafana usando o Ansible Vault.
      * `inventory.sh`: **Inventário dinâmico.** Este script lê o IP público da sua instância automaticamente do `terraform.tfstate`, eliminando a necessidade de um arquivo `hosts.yml` estático.

-----

### Fluxo de Trabalho Completo

#### Fase 1: Provisionamento da Infraestrutura com Terraform

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