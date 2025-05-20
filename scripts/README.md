# Scripts de Instalação do N8N

Esta pasta contém scripts para facilitar a instalação e configuração completa do ambiente N8N com todos os serviços necessários.

## Compatibilidade com Docker Compose

Os scripts nesta pasta são compatíveis com ambas as versões do Docker Compose:

- **Versão CLI tradicional**: Instalada separadamente e invocada com `docker-compose`
- **Versão Plugin**: Integrada ao Docker e invocada com `docker compose` (sem hífen)

Os scripts de instalação detectam automaticamente qual versão está disponível no seu sistema e ajustam os comandos adequadamente. Não é necessário fazer nenhuma modificação manual nos scripts.

## Instruções de Uso

### Para Windows

1. Abra um Prompt de Comando como Administrador
2. Navegue até a pasta raiz do projeto
3. Execute o script:
   ```
   scripts\install_windows.bat
   ```

O script irá:
- Verificar se o Docker Desktop está instalado
- Gerar chaves seguras para o N8N e o Qdrant
- Atualizar o arquivo .env com as chaves geradas
- Criar as pastas necessárias para o funcionamento
- Iniciar todos os serviços com o Docker Compose

### Para macOS

1. Abra o Terminal
2. Navegue até a pasta raiz do projeto
3. Execute o script:
   ```
   ./scripts/install_mac.sh
   ```

O script irá:
- Verificar se o Docker Desktop está instalado
- Detectar a versão do Docker Compose (CLI ou Plugin)
- Gerar chaves seguras para o N8N e outros serviços
- Atualizar o arquivo .env com as chaves geradas
- Criar as pastas necessárias para o funcionamento
- Iniciar todos os serviços com o Docker Compose

### Para Ubuntu (ou outras distribuições Linux baseadas em Debian)

1. Abra um Terminal
2. Navegue até a pasta raiz do projeto
3. Execute o script:
   ```
   ./scripts/install_ubuntu.sh
   ```

O script irá:
- Verificar se o Docker e o Docker Compose estão instalados e, se necessário, instalá-los
- Gerar chaves seguras para o N8N e o Qdrant
- Atualizar o arquivo .env com as chaves geradas
- Criar as pastas necessárias para o funcionamento
- Configurar as permissões corretas
- Iniciar todos os serviços com o Docker Compose

## Habilitando ou Desabilitando Serviços

Para personalizar quais serviços serão executados, você pode editar diretamente o arquivo `docker-compose.yml` e comentar os serviços que não deseja utilizar.

Uma lista completa dos serviços disponíveis e um exemplo de como desabilitar podem ser encontrados na seção `INFORMAÇÕES SOBRE SERVIÇOS DISPONÍVEIS` do arquivo `.env`.

Cada serviço no arquivo `docker-compose.yml` possui um comentário explicativo:
```yaml
# ===========================================
# SERVIÇO EXEMPLO
# Descrição do serviço
# ===========================================
# Para desabilitar este serviço, comente todas as linhas do serviço ou apenas o bloco inteiro
```

Para comentar um serviço, basta adicionar o caractere `#` no início de cada linha ou comentar todo o bloco do serviço, como mostrado no exemplo do arquivo `.env`.

**Importante:** Os serviços PostgreSQL e Redis são essenciais para o funcionamento do N8N e não devem ser desabilitados.

## Após a Instalação

Após a conclusão da instalação, você poderá acessar:

- N8N: http://localhost:5678 (ou a porta configurada no .env)
- Qdrant: http://localhost:6333 (ou a porta configurada no .env)
- MinIO API: http://localhost:9000 (ou a porta configurada no .env)
- MinIO Console: http://localhost:9001 (ou a porta configurada no .env)
  - Usuário: minioadmin (ou o configurado no .env)
  - Senha: minioadmin (ou o configurado no .env)
- RabbitMQ Management: http://localhost:15672 (ou a porta configurada no .env)
  - Usuário: admin (ou o configurado no .env)
  - Senha: rabbitmq123 (ou o configurado no .env)
- Elasticsearch: http://localhost:9200 (ou a porta configurada no .env)
  - Usuário: elastic (ou o configurado no .env)
  - Senha: elasticsearch123 (ou o configurado no .env)
- PostgreSQL: localhost:5432 (para o PostgreSQL principal do n8n)
  - Usuário: n8n (ou o configurado no .env)
  - Senha: n8n (ou o configurado no .env)
  - Banco: n8n (ou o configurado no .env)
- PostgreSQL com pgvector: localhost:5433 (para o PostgreSQL com suporte a vetores)
  - Usuário: pgvector (ou o configurado no .env)
  - Senha: pgvector123 (ou o configurado no .env)
  - Banco: vectordb (ou o configurado no .env)
- pgAdmin: http://localhost:5050 (ou a porta configurada no .env)
  - Email: admin@example.com (ou o configurado no .env)
  - Senha: pgadmin@123 (ou o configurado no .env)
  - ou alternativamente:
  - Usuário: admin (ou o configurado no .env)
  - Senha: admin123 (ou o configurado no .env)

## Comandos Úteis

- Para parar todos os serviços:
  ```
  docker-compose down
  ```

- Para visualizar os logs:
  ```
  docker-compose logs -f
  ```

- Para reiniciar todos os serviços:
  ```
  docker-compose restart
  ```

- Para atualizar para a versão mais recente:
  1. Edite o arquivo .env e altere a versão do N8N
  2. Execute:
     ```
     docker-compose down
     docker-compose up -d
     ``` 