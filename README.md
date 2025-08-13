### Projeto: Implantação de Infraestrutura de Monitoramento

Este projeto tem como objetivo automatizar a implantação de uma infraestrutura de monitoramento na AWS, utilizando Grafana. A automação é dividida em duas etapas principais: provisionamento da infraestrutura com Terraform e configuração do serviço com Ansible.

### Tecnologias Utilizadas

  * **Terraform:** Responsável pelo provisionamento da instância EC2 e do Security Group na AWS.
  * **Ansible:** Utilizado para a instalação e configuração do software Grafana na instância provisionada.
  * **Ansible Vault:** Garante a segurança de variáveis sensíveis, como credenciais de acesso, através de criptografia. As variáveis de usuário e senha do Grafana estão definidas neste arquivo.

### Pré-requisitos

Para executar este projeto, os seguintes softwares devem estar instalados e configurados em sua máquina local:

  * **Terraform**
  * **Ansible**
  * **AWS CLI** com credenciais configuradas.
  * **Chave SSH privada** associada à sua conta AWS.

### Instruções de Uso

O processo de implantação é sequencial e deve ser executado em duas fases.

#### Fase 1: Provisionamento com Terraform

Esta fase provisiona a infraestrutura necessária na AWS.

1.  Acesse o diretório `compute`.
2.  Inicialize o Terraform:
    ```bash
    terraform init
    ```
3.  Aplique a configuração para criar a instância EC2:
    ```bash
    terraform apply --auto-approve
    ```
    Ao final da execução, o endereço IP público da instância será exibido.

#### Fase 2: Configuração com Ansible

Esta fase instala o Grafana e suas dependências na instância recém-criada.

1.  Retorne ao diretório raiz do projeto (`automation`).
2.  No arquivo `hosts.yml`, referencie o IP da instância que foi criada pelo Terraform na etapa anterior.
3.  As credenciais de usuário (`admin`) e a senha do Grafana são gerenciadas no arquivo criptografado `group_vars/grafana-servers.yml`. Para visualizá-las ou alterá-las, utilize o comando:
    ```bash
    ansible-vault edit group_vars/grafana-servers.yml
    ```
4.  Execute o playbook do Ansible, fornecendo a senha do Vault quando solicitada:
    ```bash
    ansible-playbook -u ubuntu --private-key ../compute/devops-pdi.pem -i hosts.yml playbook.yml --ask-vault-pass
    ```

### Acesso ao Grafana

Após a conclusão bem-sucedida do playbook, o serviço do Grafana estará acessível.

  * **URL:** Utilize o endereço IP público da sua instância, seguido da porta 3000: `http://[IP_PÚBLICO_DA_SUA_INSTÂNCIA]:3000`
  * **Credenciais:** As credenciais de acesso são as que estão configuradas no arquivo `group_vars/grafana-servers.yml`.