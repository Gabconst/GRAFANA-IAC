# Automation-K8s

Este projeto automatiza a criação de uma infraestrutura em uma instância EC2, provisiona o Minikube e aplica um cluster Kubernetes com dois deployments principais: **NGINX** e **Prometheus**. Todo o processo é gerenciado por uma pipeline **GitHub Actions** e um **playbook Ansible**.

---

### Estrutura do Projeto

automation-k8s
├── .vscode
└── files/k8s
├── configmap-nginx.yaml
├── configmap-prometheus.yaml
├── configmap.yaml
├── deployment.yaml
├── nginx.conf
├── prometheus-deployment.yaml
├── prometheus-service.yaml
└── service.yaml

* **`configmap-nginx.yaml`**: ConfigMap personalizado do NGINX com variáveis de worker, logs e proxy reverso para o Prometheus.
* **`configmap-prometheus.yaml`**: ConfigMap com a configuração do Prometheus (scrape interval, targets).
* **`configmap.yaml`**: ConfigMap com variáveis de ambiente do NGINX.
* **`deployment.yaml`**: Deployment do NGINX, que consome os ConfigMaps e expõe a porta configurada.
* **`nginx.conf`**: Configuração do NGINX aplicada diretamente no container.
* **`prometheus-deployment.yaml`**: Deployment do Prometheus, configurando porta, volumes e argumentos.
* **`prometheus-service.yaml`**: Serviço **NodePort** para expor o Prometheus.
* **`service.yaml`**: Serviço **ClusterIP** para expor o NGINX internamente no cluster.

---

### Diagrama de Arquitetura

{} [ GitHub Actions Pipeline ]
|
v
[ Terraform Provisiona EC2 ]
|
v
[ Ansible Playbook Instala Minikube + Docker + NGINX ]
|
v
[ Minikube Cluster (Kubernetes) ]
|                     |
v                     v
[ Deployment NGINX ]   [ Deployment Prometheus ]
|                     |
-----------------------
|
Comunicação interna
via proxy reverso

A. Sim, claro\! Aqui está todo o conteúdo do README, formatado e pronto para você copiar e colar:

```markdown
# Automation-K8s

Este projeto automatiza a criação de uma infraestrutura em uma instância EC2, provisiona o Minikube e aplica um cluster Kubernetes com dois deployments principais: **NGINX** e **Prometheus**. Todo o processo é gerenciado por uma pipeline **GitHub Actions** e um **playbook Ansible**.

---

### Estrutura do Projeto

```

automation-k8s
├── .vscode
└── files/k8s
├── configmap-nginx.yaml
├── configmap-prometheus.yaml
├── configmap.yaml
├── deployment.yaml
├── nginx.conf
├── prometheus-deployment.yaml
├── prometheus-service.yaml
└── service.yaml

```

* **`configmap-nginx.yaml`**: ConfigMap personalizado do NGINX com variáveis de worker, logs e proxy reverso para o Prometheus.
* **`configmap-prometheus.yaml`**: ConfigMap com a configuração do Prometheus (scrape interval, targets).
* **`configmap.yaml`**: ConfigMap com variáveis de ambiente do NGINX.
* **`deployment.yaml`**: Deployment do NGINX, que consome os ConfigMaps e expõe a porta configurada.
* **`nginx.conf`**: Configuração do NGINX aplicada diretamente no container.
* **`prometheus-deployment.yaml`**: Deployment do Prometheus, configurando porta, volumes e argumentos.
* **`prometheus-service.yaml`**: Serviço **NodePort** para expor o Prometheus.
* **`service.yaml`**: Serviço **ClusterIP** para expor o NGINX internamente no cluster.

---

### Diagrama de Arquitetura

```

[ GitHub Actions Pipeline ]
|
v
[ Terraform Provisiona EC2 ]
|
v
[ Ansible Playbook Instala Minikube + Docker + NGINX ]
|
v
[ Minikube Cluster (Kubernetes) ]
|                     |
v                     v
[ Deployment NGINX ]   [ Deployment Prometheus ]
|                     |
\-----------------------
|
Comunicação interna
via proxy reverso

````

---

### Fluxo do Pipeline

#### GitHub Actions
1.  Faz checkout do repositório.
2.  Clona o módulo Terraform e o repositório com o playbook.
3.  Configura credenciais AWS.
4.  Executa o Terraform para provisionar a instância EC2.
5.  Configura o SSH para acessar a instância.
6.  Instala o Ansible e suas dependências.
7.  Executa o playbook Ansible para instalar o Minikube, Docker, NGINX e aplicar os manifests do Kubernetes.

#### Ansible Playbook
1.  Atualiza e instala os pacotes necessários.
2.  Instala o Docker e adiciona o usuário ao grupo.
3.  Instala e configura o Minikube.
4.  Instala o Python e a biblioteca `kubernetes`.
5.  Configura e aplica os arquivos YAML do Kubernetes (Deployments, Services, ConfigMaps).

---

### Comandos Úteis no Minikube

* **Listar Pods**
    ```bash
    minikube kubectl get pods
    ```

* **Testar NGINX**
    ```bash
    minikube kubectl -- exec nginx-env-vars-<pod-id> -- curl localhost
    ```

* **Entrar no container do Prometheus**
    ```bash
    minikube kubectl -- exec -it prometheus-<pod-id> -- /bin/sh
    ```

* **Testar Prometheus dentro do container**
    ```bash
    wget -qO- http://localhost:9090
    ```

* **Sair do container Prometheus**
    ```bash
    exit
    ```

* **Testar conexão do NGINX com Prometheus (proxy reverso)**
    ```bash
    minikube kubectl exec -- nginx-env-vars-<pod-id> -- curl localhost/prometheus/
    ```
    *Substitua `<pod-id>` pelo identificador do pod retornado pelo comando `minikube kubectl get pods`.*

---

### Observações

* O NGINX retorna uma mensagem padrão "Olá, DevOps!" na raiz (`/`).
* O Prometheus está exposto internamente na porta 9090 e é acessível via proxy reverso do NGINX.
* O cluster Kubernetes é criado dentro da instância EC2 provisionada, utilizando o Minikube.
* O projeto é totalmente automatizado via pipeline GitHub Actions, que provisiona a instância, configura o ambiente e aplica os manifests do Kubernetes.
````