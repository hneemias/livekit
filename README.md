# LiveKit Server - Self-Hosted Deploy & Painel de Controle

Projeto completo para rodar o **LiveKit Server** de forma independente (Self-Hosted), seja localmente no Windows ou em uma **VPS na nuvem (Hostinger, Hetzner, AWS, etc.)**, com **Docker Compose**, **HTTPS/SSL automático (Caddy)** e **Painel de Moderação/Administração de Usuários**.

---

## 🔒 Segurança: Como o LiveKit Protege sua Máquina?

O LiveKit Server é **blindado por criptografia JWT**:
1. **Zero Acesso Público**: Ninguém consegue entrar em uma sala ou gastar CPU/banda da sua VPS sem um Token de Acesso assinado pelo seu `LIVEKIT_API_SECRET`.
2. **Controle Total no Backend**: Apenas os usuários autenticados no seu sistema (ex: os técnicos logados no ERP) recebem tokens para se conectar.
3. **Painel de Moderação**: Você pode ver em tempo real quem está conectado e desconectar (*kick*) invasores com 1 clique.

---

## 📁 Estrutura do Repositório

```text
├── docker-compose.yml          # Orquestração do LiveKit Server + Caddy SSL
├── livekit.production.yaml     # Configuração de produção para a VPS
├── Caddyfile                   # Proxy reverso com HTTPS automático (Let's Encrypt)
├── deploy-hostinger.sh         # Script de instalação automática na VPS
├── admin-dashboard.html        # Painel Web de Administração (Ver salas e Chutar usuários)
├── test-client.html            # Cliente de teste WebRTC com voz, chat e vídeo
├── generate-test-token.ps1     # Gerador de tokens para usuários comuns
├── generate-admin-token.ps1    # Gerador de tokens para o Painel Admin
├── livekit.yaml                # Configuração para desenvolvimento local no Windows
├── start-server.bat            # Execução rápida do servidor local
└── .env.example                # Modelo de variáveis de ambiente
```

---

## 🚀 Como Fazer o Deploy na VPS Hostinger (Passo a Passo)

### 1. Aponte seu Domínio
No painel de DNS do seu domínio, crie um registro do tipo **A**:
- **Nome**: `livekit` (ex: `livekit.seusite.com.br`)
- **Destino / IP**: O endereço IP da sua VPS Hostinger

### 2. Conecte na sua VPS via SSH
```bash
ssh root@SEU_IP_DA_VPS
```

### 3. Clone este repositório na VPS
```bash
git clone https://github.com/hneemias/livekit.git
cd livekit
```

### 4. Configure o arquivo `.env`
Copie o arquivo de exemplo e edite com seu domínio e senhas fortes:
```bash
cp .env.example .env
nano .env
```
Exemplo:
```env
DOMAIN=livekit.seusite.com.br
LIVEKIT_API_KEY=sua_chave_forte_aqui
LIVEKIT_API_SECRET=seu_secret_muito_seguro_aqui
```

### 5. Execute o script de instalação
```bash
chmod +x deploy-hostinger.sh
./deploy-hostinger.sh
```
O script cuidará de tudo: instalará o Docker, liberará as portas no firewall e subirá o LiveKit com certificado SSL automático!

---

## 🛡️ Como Usar o Painel Administrativo de Usuários

1. Gere um Token de Administrador:
   ```powershell
   .\generate-admin-token.ps1 -ApiKey "sua_chave" -ApiSecret "seu_secret"
   ```
2. Abra o arquivo `admin-dashboard.html` no seu navegador.
3. Insira a URL do seu LiveKit (ex: `https://livekit.seusite.com.br` ou `http://localhost:7880`) e cole o seu Token de Administrador.
4. Clique em **Atualizar Salas**:
   - Você verá todas as salas abertas e a lista de pessoas conectadas.
   - Para desconectar qualquer usuário suspeito, basta clicar no botão vermelho **🚫 Desconectar (Kick)**.
   - Para fechar uma sala inteira, clique em **❌ Fechar Sala**.
