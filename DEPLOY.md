# BAI Portal - Deploy na Hostinger (VPS Node.js)

## Pré-requisitos
- Node.js 18+ instalado no servidor
- Acesso SSH ao servidor

## Passos de Deploy

### 1. Upload dos ficheiros
```bash
scp -r ./* usuario@seu-servidor:/home/usuario/bai-portal/
```

### 2. Instalar dependências
```bash
cd /home/usuario/bai-portal
npm install
```

### 3. Configurar variáveis de ambiente
```bash
cp .env.example .env
nano .env  # Editar com as suas credenciais
```

### 4. Build de produção
```bash
npm run build
```

### 5. Iniciar o servidor
```bash
node .output/server/index.mjs
```

### 6. (Opcional) Usar PM2 para manter online
```bash
npm install -g pm2
pm2 start .output/server/index.mjs --name bai-portal
pm2 save
pm2 startup
```

## Configuração do domínio
Na Hostinger, configure o proxy reverso para:
- Porta: 3000 (ou a definida em PORT)

## Dados Locais
Os dados ficam guardados em `.data/` (submissions.json, services.json).
Crie a pasta manualmente se não existir:
```bash
mkdir -p .data
```

## Variáveis de Ambiente (.env)
```
ADMIN_PASSWORD=bai2024
VITE_WEB3FORMS_ACCESS_KEY=74849a60-2d6c-47a9-a3ce-c46c01345139
PORT=3000
```
