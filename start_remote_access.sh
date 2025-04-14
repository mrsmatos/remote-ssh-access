#!/bin/bash

# === CONFIGURAR VARIÁVEIS ===
REMOTE_PORT=2222     # Porta usada no modo externo (serveo)
USER=$(whoami)
LOCAL_PORT=22
SSH_KEY=~/.ssh/id_rsa

echo "🔐 Verificando chave SSH..."
if [ ! -f "$SSH_KEY" ]; then
  echo "🔑 Gerando chave SSH..."
  ssh-keygen -t rsa -b 4096 -N "" -f "$SSH_KEY"
else
  echo "🔑 Chave SSH já existe: $SSH_KEY"
fi

echo "🔧 Instalando servidor SSH..."
sudo apt update
sudo apt install -y openssh-server

echo "✅ Verificando se o SSH está ativo..."
sudo systemctl enable --now ssh

# === ESCOLHA DO MODO ===
echo
echo "🛠️ Como deseja acessar este computador?"
echo "1) Pela internet (rede externa - via Serveo)"
echo "2) Pela mesma rede local (IP interno)"
read -rp "Digite 1 ou 2: " MODO

if [[ "$MODO" == "1" ]]; then
  echo "🌐 Criando túnel reverso seguro via Serveo.net..."
  ssh -o StrictHostKeyChecking=no -R 0:localhost:$LOCAL_PORT serveo.net > /tmp/serveo_output.log 2>&1 &

  sleep 3
  PORT_ASSIGNED=$(grep -oP 'Forwarding TCP connections from serveo.net:\K[0-9]+' /tmp/serveo_output.log)

  if [[ -n "$PORT_ASSIGNED" ]]; then
      echo "✅ Túnel criado com sucesso!"
      echo "📝 Anote esta porta: $PORT_ASSIGNED"
      echo "👉 Para se conectar de outro dispositivo:"
      echo "    ssh -p $PORT_ASSIGNED $USER@serveo.net"
      echo "ℹ️ Para encerrar o túnel, use: kill $!"
  else
      echo "❌ Falha ao obter a porta atribuída. Verifique o log: /tmp/serveo_output.log"
  fi

elif [[ "$MODO" == "2" ]]; then
  IP_LOCAL=$(hostname -I | awk '{print $1}')
  echo "📡 Acesso local habilitado!"
  echo "👉 Para se conectar a partir de outro dispositivo na mesma rede:"
  echo "    ssh $USER@$IP_LOCAL"
else
  echo "⚠️ Opção inválida. Execute novamente e escolha 1 ou 2."
fi

