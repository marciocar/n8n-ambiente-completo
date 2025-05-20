#!/bin/bash

# Cores para facilitar a leitura
VERDE='\033[0;32m'
VERMELHO='\033[0;31m'
AMARELO='\033[1;33m'
RESET='\033[0m'

# Detectar o diretório onde o docker-compose.yml está localizado
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_DIR"

echo -e "${AMARELO}================================================${RESET}"
echo -e "${AMARELO}        INSTALADOR DO N8N PARA UBUNTU          ${RESET}"
echo -e "${AMARELO}================================================${RESET}"
echo ""

# Verificar se o arquivo .env existe
if [ ! -f ".env" ]; then
    echo -e "${AMARELO}[INFO] Arquivo .env não encontrado. Criando a partir do .env.example...${RESET}"
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo -e "${VERDE}[OK] Arquivo .env criado com sucesso!${RESET}"
    else
        echo -e "${VERMELHO}[ERRO] Arquivo .env.example não encontrado. Por favor, crie um arquivo .env manualmente.${RESET}"
        exit 1
    fi
else
    echo -e "${VERDE}[OK] Arquivo .env já existe.${RESET}"
fi

# Verificando requisitos
echo -e "Verificando se o Docker está instalado..."
if ! command -v docker &> /dev/null; then
    echo -e "${VERMELHO}[ERRO] Docker não encontrado. Instalando...${RESET}"
    
    # Atualizar o apt e instalar dependências
    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    
    # Adicionar a chave GPG oficial do Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    
    # Adicionar o repositório do Docker
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    
    # Atualizar o apt e instalar o Docker
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    
    # Adicionar o usuário atual ao grupo docker
    sudo usermod -aG docker $USER
    
    echo -e "${VERDE}[OK] Docker instalado com sucesso!${RESET}"
    echo -e "${AMARELO}ATENÇÃO: Você precisará fazer logout e login novamente para que as alterações do grupo docker tenham efeito.${RESET}"
    echo -e "Deseja continuar com a instalação? (s/n)"
    read resposta
    if [[ "$resposta" != "s" && "$resposta" != "S" ]]; then
        echo -e "Por favor, faça logout e login novamente, e então execute este script novamente."
        exit 0
    fi
else
    echo -e "${VERDE}[OK] Docker já está instalado!${RESET}"
fi

echo -e "Verificando se o Docker Compose está instalado..."
if ! command -v docker-compose &> /dev/null; then
    echo -e "${AMARELO}[AVISO] Docker Compose CLI não encontrado. Verificando se o Docker Compose Plugin está instalado...${RESET}"
    
    if docker compose version &> /dev/null; then
        echo -e "${VERDE}[OK] Docker Compose Plugin está disponível!${RESET}"
        # Criar alias para compatibilidade
        COMPOSE_CMD="docker compose"
    else
        echo -e "${VERMELHO}[ERRO] Docker Compose não encontrado. Instalando...${RESET}"
    
        # Instalar a versão mais recente do Docker Compose
        sudo curl -L "https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        
        echo -e "${VERDE}[OK] Docker Compose instalado com sucesso!${RESET}"
        COMPOSE_CMD="docker-compose"
    fi
else
    echo -e "${VERDE}[OK] Docker Compose já está instalado!${RESET}"
    COMPOSE_CMD="docker-compose"
fi

echo ""
echo -e "${VERDE}[OK] Todos os requisitos estão instalados!${RESET}"
echo ""

# Verifica a versão do Docker Compose
COMPOSE_VERSION=$(docker-compose --version | grep -oP 'version \K[0-9]+\.[0-9]+')
if (( $(echo "$COMPOSE_VERSION < 1.29" | bc -l) )); then
    echo -e "${AMARELO}[AVISO] A versão do Docker Compose ($COMPOSE_VERSION) pode não suportar algumas funcionalidades.${RESET}"
    echo -e "${AMARELO}Ajustando o arquivo docker-compose.yml para compatibilidade...${RESET}"
    
    # Modificar o docker-compose.yml para remover a opção 'required'
    if [ -f "docker-compose.yml" ]; then
        sed -i 's/required: false/condition: service_started/g' docker-compose.yml
        echo -e "${VERDE}[OK] Arquivo docker-compose.yml ajustado para compatibilidade!${RESET}"
    else
        echo -e "${VERMELHO}[ERRO] Arquivo docker-compose.yml não encontrado no diretório atual.${RESET}"
        exit 1
    fi
fi

# Gerando chaves seguras
echo -e "Gerando chave de criptografia segura para o N8N..."
N8N_KEY=$(openssl rand -hex 24)

echo -e "Gerando chave de API segura para o Qdrant..."
QDRANT_KEY=$(openssl rand -hex 32)

echo -e "Gerando credenciais seguras para o MinIO..."
MINIO_USER="admin_$(openssl rand -hex 4)"
MINIO_PASS="$(openssl rand -base64 12)"

echo -e "Gerando credenciais seguras para o RabbitMQ..."
RABBITMQ_USER="admin_$(openssl rand -hex 3)"
RABBITMQ_PASS="$(openssl rand -base64 10)"

echo -e "Gerando credenciais seguras para o Elasticsearch..."
ELASTIC_PASS="$(openssl rand -base64 16)"

echo -e "Gerando credenciais seguras para o PostgreSQL com pgvector..."
PGVECTOR_PASS="$(openssl rand -base64 12)"

echo -e "Gerando credenciais seguras para o pgAdmin..."
PGADMIN_EMAIL="admin.$(openssl rand -hex 4)@example.com"
PGADMIN_PASS="$(openssl rand -base64 12)"
PGADMIN_USER="pgadmin_$(openssl rand -hex 3)"
PGADMIN_PASSWORD="$(openssl rand -base64 10)"

echo ""
echo -e "${AMARELO}[INFO] Atualizando as chaves no arquivo .env${RESET}"

# Usar delimitadores diferentes para evitar problemas com caracteres especiais
sed -i "s|N8N_ENCRYPTION_KEY=.*|N8N_ENCRYPTION_KEY=$N8N_KEY|" .env
sed -i "s|QDRANT_API_KEY=.*|QDRANT_API_KEY=$QDRANT_KEY|" .env
sed -i "s|MINIO_ROOT_USER=.*|MINIO_ROOT_USER=$MINIO_USER|" .env
sed -i "s|MINIO_ROOT_PASSWORD=.*|MINIO_ROOT_PASSWORD=$MINIO_PASS|" .env
sed -i "s|RABBITMQ_DEFAULT_USER=.*|RABBITMQ_DEFAULT_USER=$RABBITMQ_USER|" .env
sed -i "s|RABBITMQ_DEFAULT_PASS=.*|RABBITMQ_DEFAULT_PASS=$RABBITMQ_PASS|" .env
sed -i "s|ELASTICSEARCH_PASSWORD=.*|ELASTICSEARCH_PASSWORD=$ELASTIC_PASS|" .env
sed -i "s|PGVECTOR_PASSWORD=.*|PGVECTOR_PASSWORD=$PGVECTOR_PASS|" .env
sed -i "s|PGADMIN_DEFAULT_EMAIL=.*|PGADMIN_DEFAULT_EMAIL=$PGADMIN_EMAIL|" .env
sed -i "s|PGADMIN_DEFAULT_PASSWORD=.*|PGADMIN_DEFAULT_PASSWORD=$PGADMIN_PASS|" .env
sed -i "s|PGADMIN_USER=.*|PGADMIN_USER=$PGADMIN_USER|" .env
sed -i "s|PGADMIN_PASSWORD=.*|PGADMIN_PASSWORD=$PGADMIN_PASSWORD|" .env

echo ""
echo -e "${AMARELO}[INFO] Criando estrutura de pastas necessária...${RESET}"
mkdir -p data
mkdir -p n8n-local-files

echo ""
echo -e "${AMARELO}[INFO] Definindo permissões corretas...${RESET}"
# Garantir que o usuário atual seja o proprietário das pastas
sudo chown -R $USER:$USER data n8n-local-files

echo ""
echo -e "${AMARELO}[INFO] Iniciando os serviços com o Docker Compose...${RESET}"
$COMPOSE_CMD up -d

echo ""
echo -e "Verificando se os serviços estão em execução..."
sleep 5
$COMPOSE_CMD ps

# Obtendo a porta do N8N do arquivo .env
N8N_PORT=$(grep -oE 'N8N_PORT=[0-9]+' .env | cut -d= -f2)
PGADMIN_PORT=$(grep -oE 'PGADMIN_PORT=[0-9]+' .env | cut -d= -f2)

echo ""
echo -e "${AMARELO}================================================${RESET}"
echo -e "${VERDE}                INSTALAÇÃO CONCLUÍDA             ${RESET}"
echo -e "${AMARELO}================================================${RESET}"
echo ""
echo -e "O N8N está disponível em: ${VERDE}http://localhost:$N8N_PORT${RESET}"
echo ""
echo -e "MinIO S3 está disponível em: ${VERDE}http://localhost:9000${RESET}"
echo -e "MinIO Console está disponível em: ${VERDE}http://localhost:9001${RESET}"
echo -e "  Usuário: ${VERDE}$MINIO_USER${RESET}"
echo -e "  Senha: ${VERDE}$MINIO_PASS${RESET}"
echo -e "  (guarde estas credenciais para acesso futuro)"
echo ""
echo -e "RabbitMQ está disponível em: ${VERDE}http://localhost:15672${RESET}"
echo -e "  Usuário: ${VERDE}$RABBITMQ_USER${RESET}"
echo -e "  Senha: ${VERDE}$RABBITMQ_PASS${RESET}"
echo -e "  (guarde estas credenciais para acesso futuro)"
echo ""
echo -e "Elasticsearch está disponível em: ${VERDE}http://localhost:9200${RESET}"
echo -e "  Usuário: ${VERDE}elastic${RESET}"
echo -e "  Senha: ${VERDE}$ELASTIC_PASS${RESET}"
echo -e "  (guarde estas credenciais para acesso futuro)"
echo ""
echo -e "PostgreSQL com pgvector está disponível em: ${VERDE}localhost:5433${RESET}"
echo -e "  Usuário: ${VERDE}pgvector${RESET}"
echo -e "  Senha: ${VERDE}$PGVECTOR_PASS${RESET}"
echo -e "  Banco: ${VERDE}vectordb${RESET}"
echo -e "  (guarde estas credenciais para acesso futuro)"
echo ""
echo -e "pgAdmin está disponível em: ${VERDE}http://localhost:${PGADMIN_PORT}${RESET}"
echo -e "  Email: ${VERDE}$PGADMIN_EMAIL${RESET}"
echo -e "  Senha: ${VERDE}$PGADMIN_PASS${RESET}"
echo -e "  ou use:"
echo -e "  Usuário: ${VERDE}$PGADMIN_USER${RESET}"
echo -e "  Senha: ${VERDE}$PGADMIN_PASSWORD${RESET}"
echo -e "  (guarde estas credenciais para acesso futuro)"
echo ""
echo -e "Para parar os serviços, execute:"
echo -e "  ${AMARELO}$COMPOSE_CMD down${RESET}"
echo ""
echo -e "Para visualizar os logs, execute:"
echo -e "  ${AMARELO}$COMPOSE_CMD logs -f${RESET}"
echo ""
echo -e "${AMARELO}[INFO] Configurando serviços...${RESET}"
echo -e "Para personalizar quais serviços serão executados, você pode editar diretamente"
echo -e "o arquivo docker-compose.yml e comentar os serviços que não deseja utilizar."
echo -e "Uma lista completa dos serviços disponíveis e um exemplo de como desabilitar"
echo -e "podem ser encontrados na seção 'INFORMAÇÕES SOBRE SERVIÇOS DISPONÍVEIS' do arquivo .env"
echo -e "Nota: O PostgreSQL e o Redis são obrigatórios e não devem ser desabilitados, pois são necessários para o n8n."
echo ""
echo -e "Divirta-se usando o N8N!"

echo ""
echo -e "${AMARELO}[INFO] Configurando serviços...${RESET}"
echo -e "Para personalizar quais serviços serão executados, você pode editar diretamente"
echo -e "o arquivo docker-compose.yml e comentar os serviços que não deseja utilizar."
echo -e "Uma lista completa dos serviços disponíveis e um exemplo de como desabilitar"
echo -e "podem ser encontrados na seção 'INFORMAÇÕES SOBRE SERVIÇOS DISPONÍVEIS' do arquivo .env"
echo -e "Nota: O PostgreSQL e o Redis são obrigatórios e não devem ser desabilitados, pois são necessários para o n8n." 