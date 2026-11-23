#!/bin/bash
# Script de Deploy Automático na VPS Hostinger (Ubuntu/Debian)
set -e

echo "=================================================="
echo "    Instalando LiveKit Server na VPS Hostinger    "
echo "=================================================="

# 1. Atualizar pacotes
sudo apt update && sudo apt upgrade -y

# 2. Instalar Docker e Docker Compose caso não existam
if ! command -v docker &> /dev/null; then
    echo "Instalando Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
fi

if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "Instalando Docker Compose..."
    sudo apt install -y docker-compose-plugin
fi

# 3. Configurar Firewall (UFW)
echo "Configurando portas no Firewall (UFW)..."
sudo ufw allow 22/tcp comment "SSH"
sudo ufw allow 80/tcp comment "HTTP Let's Encrypt"
sudo ufw allow 443/tcp comment "HTTPS Caddy"
sudo ufw allow 7880/tcp comment "LiveKit Signaling"
sudo ufw allow 7881/tcp comment "LiveKit WebRTC TCP"
sudo ufw allow 50000:60000/udp comment "LiveKit WebRTC UDP"
sudo ufw --force enable

# 4. Verificar arquivo .env
if [ ! -f .env ]; then
    echo "Criando .env a partir do .env.example..."
    cp .env.example .env
    echo "⚠️ Por favor, edite o arquivo .env com seu DOMÍNIO e CHAVES antes de continuar!"
    exit 1
fi

# 5. Iniciar os containers
echo "Iniciando LiveKit Server e Caddy SSL com Docker Compose..."
docker compose pull
docker compose up -d

echo "=================================================="
echo "✅ LiveKit Server rodando com sucesso com SSL!"
echo "Acesse: https://$(grep DOMAIN .env | cut -d '=' -f2)"
echo "=================================================="
