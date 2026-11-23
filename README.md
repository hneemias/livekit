# LiveKit Server - Self-Hosted Deploy no Coolify (Hostinger)

Projeto configurado e otimizado para deploy em **1 clique no Coolify** na sua VPS da Hostinger, com **HTTPS/WSS automático (Traefik/Let's Encrypt)**, WebRTC otimizado e **Painel de Moderação de Usuários**.

---

## 🚀 Como Fazer o Deploy no Coolify (Passo a Passo)

### 1. Criar o apontamento de Domínio no seu DNS
No painel onde está seu domínio (Hostinger, Cloudflare ou Registro.br):
- Crie um registro do tipo **A**:
  - **Nome**: `livekit` (ex: `livekit.seusite.com.br`)
  - **Destino/IP**: O endereço IP da sua VPS Hostinger

---

### 2. Liberar as Portas WebRTC no Firewall da Hostinger
O Coolify cuida das portas `80` e `443` automaticamente. Para o áudio/vídeo WebRTC do LiveKit fluir sem bloqueios, libere as seguintes portas no Firewall da VPS (pelo painel da Hostinger ou via terminal SSH):

```bash
sudo ufw allow 7881/tcp comment "LiveKit WebRTC TCP"
sudo ufw allow 50000:50050/udp comment "LiveKit WebRTC UDP"
```

---

### 3. Adicionar o Projeto no Coolify

1. Acesse o painel do seu **Coolify**.
2. Clique em **+ Create Resource** -> **Git Based** -> **Public Repository** (ou conecte com sua conta GitHub).
3. Cole a URL do repositório:
   ```text
   https://github.com/hneemias/livekit.git
   ```
4. Em **Build Pack**, selecione: **Docker Compose** (o Coolify já reconhecerá o `docker-compose.yml`).
5. No campo **Domains**, informe o seu domínio com `https://`:
   ```text
   https://livekit.seusite.com.br
   ```
6. Vá na aba **Environment Variables** e adicione as duas chaves:
   - `LIVEKIT_API_KEY`: (ex: crie uma chave forte como `lk_api_bancada_inovar`)
   - `LIVEKIT_API_SECRET`: (ex: crie um segredo forte com letras e números)
7. Clique em **Save** e depois em **Deploy**!

O Coolify vai baixar a imagem oficial do LiveKit, configurar o proxy reverso do Traefik com certificado SSL válido e iniciar o servidor!

---

## 🛡️ Como Usar o Painel Administrativo de Usuários

Para monitorar quem está conectado na sua VPS e expulsar/chutar conexões indevidas:

1. Gere um Token de Administrador localmente:
   ```powershell
   .\generate-admin-token.ps1 -ApiKey "sua_chave_do_coolify" -ApiSecret "seu_secret_do_coolify"
   ```
2. Abra o arquivo [admin-dashboard.html](file:///e:/projetos/LiveKit/admin-dashboard.html) no seu navegador.
3. No campo URL, informe a URL do seu Coolify (ex: `https://livekit.seusite.com.br`) e cole o seu Admin Token.
4. Clique em **"Atualizar Salas"**:
   - Você verá todas as salas abertas e quem está conectado.
   - Para desconectar qualquer usuário indevido, basta clicar no botão vermelho **🚫 Desconectar (Kick)**.
   - Para fechar uma sala inteira, clique em **❌ Fechar Sala**.

---

## 🧪 Testando a Conexão Remota

Abra o arquivo [test-client.html](file:///e:/projetos/LiveKit/test-client.html):
- **LiveKit WebSocket URL**: `wss://livekit.seusite.com.br`
- **Token**: Um token gerado com o script `generate-test-token.ps1`.
- Clique em **Conectar à Sala** para testar voz, chat e participantes em tempo real!
