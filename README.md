# **Provisionamento e Configuração de Servidores com Terraform + Ansible — Setup Grafana**

Este projeto provisiona servidores via **Terraform** (pasta `compute`) e os configura automaticamente com **Ansible** (pasta `automation`), instalando e configurando o **Grafana** pronto para uso no navegador.

---

## **📂 Estrutura do Projeto**

```
.
├── automation/              # Automação e configuração com Ansible
│   ├── group_vars/           # Variáveis de grupo (inclui dados sensíveis)
│   │   └── grafana-servers.yml  # Inventário criptografado com Ansible Vault
│   ├── inventory.sh          # Script que gera inventário dinâmico
│   └── playbook.yml          # Playbook principal do Ansible
│
├── compute/                  # Provisionamento de infraestrutura com Terraform
│   ├── main.tf               # Declara recursos principais
│   ├── outputs.tf            # Exporta IPs e infos para o Ansible
│   ├── providers.tf          # Configuração do provedor cloud
│   ├── terraform.tfvars      # Valores reais das variáveis (não versionado)
│   └── variables.tf          # Declaração de variáveis usadas no main.tf
│
├── devops-pdi.pem            # Chave privada para acesso SSH ao servidor
├── README.md                 # Este documento
└── .gitignore                # Arquivos ignorados no versionamento
```

---

## **🛠️ Descrição dos Principais Arquivos**

### **Pasta `compute` — Terraform**

* **`main.tf`** → Define a infraestrutura: instância, rede, regras de segurança etc.

* **`variables.tf`** → Declara variáveis para tornar o código reutilizável.

* **`terraform.tfvars`** → Guarda os valores reais das variáveis.
  ⚠️ **Não versionar** este arquivo.

  **Exemplo:**

  ```hcl
  region        = "us-east-1"
  instance_type = "t3.micro"
  ssh_key_path  = "~/.ssh/id_rsa.pub"
  grafana_port  = 3000
  ```

* **`outputs.tf`** → Exporta informações como IP público para serem usadas pelo Ansible.

* **`providers.tf`** → Configura o provedor (ex: AWS, OCI, Azure).

---

### **Pasta `automation` — Ansible**

* **`playbook.yml`** →

  * Instala o Grafana e suas dependências.
  * Configura o firewall liberando a porta configurada.
  * Habilita e inicia o serviço do Grafana.
  * Garante que esteja acessível no navegador.

* **`inventory.sh`** →
  Script que lê a saída do Terraform (`terraform output`) e gera o inventário dinâmico para o Ansible.
  **Uso:**

  ```bash
  cd automation
  ./inventory.sh
  ```

* **`group_vars/grafana-servers.yml`** →
  Variáveis sensíveis (usuário, senha, IPs, configs específicas) **criptografadas** com Ansible Vault.

---

## **🔐 Criptografar e Descriptografar com Ansible Vault**

**Criptografar arquivo:**

```bash
ansible-vault encrypt group_vars/grafana-servers.yml
```

**Visualizar conteúdo:**

```bash
ansible-vault view group_vars/grafana-servers.yml
```

**Editar conteúdo protegido:**

```bash
ansible-vault edit group_vars/grafana-servers.yml
```

**Executar playbook usando arquivo criptografado:**

```bash
ansible-playbook playbook.yml --ask-vault-pass
```

---

## **🚀 Fluxo de Uso do Projeto**

1. **Criar o `terraform.tfvars`** em `compute/` com suas variáveis.
2. **Provisionar infraestrutura**:

   ```bash
   cd compute
   terraform init
   terraform apply
   ```
3. **Gerar inventário para o Ansible**:

   ```bash
   cd ../automation
   ./inventory.sh
   ```
4. **Executar o playbook**:

   ```bash
   ansible-playbook playbook.yml --ask-vault-pass
   ```
5. **Acessar Grafana no navegador**:

   ```
   http://<IP_PUBLICO>:<PORTA>
   ```

---

## **📌 Boas Práticas**

* Nunca versionar `terraform.tfvars` nem chaves privadas (`.pem`).
* Proteger variáveis sensíveis com **Ansible Vault**.
* Sempre rodar `inventory.sh` após criar ou alterar instâncias.
* Usar `terraform plan` antes de aplicar mudanças.

---

Se quiser, posso **acrescentar um diagrama visual** mostrando o fluxo **Terraform → Inventory → Ansible → Grafana** para deixar o README mais didático. Isso daria um ar profissional e facilitaria para qualquer pessoa entender o processo. Quer que eu já adicione?
