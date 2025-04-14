# 🔐 Remote SSH Access

Este projeto fornece um script Bash para habilitar o acesso remoto seguro a um computador Linux via SSH. Você pode acessar a máquina:

- 🌐 Pela **mesma rede local** (via IP interno)
- 🌍 De qualquer lugar do mundo (via **túnel reverso SSH com Serveo.net**)

---

## 🚀 Como usar

### 1. Clonar o projeto (ou copiar os arquivos)
```bash
git clone git@github.com:mrsmatos/remote-ssh-access.git
cd remote-ssh-access
```

### 2. Tornar o script executável
```bash
chmod +x start_remote_access.sh
```

### 3. Rodar o script
Você pode escolher a forma de acesso:

#### ▶️ **Acesso pela mesma rede (IP interno)**
```bash
./start_remote_access.sh local
```
> Após rodar, será exibido o IP local para acesso:
> 
> ```bash
> ssh mraylan@192.168.1.10
> ```

#### ▶️ **Acesso via internet (Serveo.net)**
```bash
./start_remote_access.sh externo
```
> Será exibida uma porta gerada dinamicamente:
>
> ```bash
> ssh -p 37198 mraylan@serveo.net
> ```

---

## 🧰 Requisitos

- Linux (Ubuntu, Debian ou derivados)
- `openssh-server` (instalado automaticamente)
- Conexão com a internet (para acesso externo)
- Conta no [GitHub](https://github.com/) (opcional, para clonar o projeto)

---

## 📜 Comandos úteis

### Gerar chave SSH (se necessário)
```bash
ssh-keygen -t rsa -b 4096
```

### Verificar IP local
```bash
hostname -I
```

### Encerrar túnel Serveo
```bash
pkill -f "ssh -o StrictHostKeyChecking=no -R"
```

---

## 🧑‍💻 Autor

**Marcos Matos** – [@mrsmatos](https://github.com/mrsmatos)  
Projeto livre para estudos e automação pessoal.

---
