@echo off
setlocal enabledelayedexpansion

rem Mudar para o diretório onde o docker-compose.yml está localizado
cd %~dp0
cd ..

echo ================================================
echo        INSTALADOR DO N8N PARA WINDOWS
echo ================================================
echo.

REM Verificar se o arquivo .env existe
echo Verificando se o arquivo .env existe...
if not exist ".env" (
    echo [INFO] Arquivo .env não encontrado. Criando a partir do .env.example...
    if exist ".env.example" (
        copy .env.example .env
        echo [OK] Arquivo .env criado com sucesso!
    ) else (
        echo [ERRO] Arquivo .env.example não encontrado. Por favor, crie um arquivo .env manualmente.
        exit /b 1
    )
) else (
    echo [OK] Arquivo .env já existe.
)

REM Verificando requisitos
echo Verificando se o Docker Desktop está instalado...
docker --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Docker não encontrado. Por favor, instale o Docker Desktop:
    echo https://www.docker.com/products/docker-desktop/
    exit /b 1
)

echo Verificando se o Docker Compose está instalado...
docker-compose --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [AVISO] Docker Compose CLI não encontrado. Verificando se o Docker Compose Plugin está instalado...
    docker compose version >nul 2>&1
    if %ERRORLEVEL% NEQ 0 (
        echo [ERRO] Docker Compose não encontrado. Por favor, instale o Docker Desktop que inclui o Docker Compose.
        exit /b 1
    ) else (
        echo [OK] Docker Compose Plugin está disponível!
        set COMPOSE_CMD=docker compose
    )
) else (
    echo [OK] Docker Compose já está instalado!
    set COMPOSE_CMD=docker-compose
)

echo.
echo [OK] Todos os requisitos estão instalados!
echo.

REM Verificar e ajustar o docker-compose.yml para compatibilidade
echo Verificando compatibilidade do arquivo docker-compose.yml...
findstr /C:"required: false" docker-compose.yml >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [INFO] Ajustando o docker-compose.yml para compatibilidade...
    powershell -Command "(Get-Content docker-compose.yml) -replace 'required: false', 'condition: service_healthy' | Set-Content docker-compose.yml"
    echo [OK] Arquivo docker-compose.yml ajustado para compatibilidade!
)

REM Gerando chaves seguras
echo Gerando chave de criptografia segura para o N8N...
for /f "tokens=*" %%a in ('powershell -Command "[System.BitConverter]::ToString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(24)).Replace('-', '').ToLower()"') do set N8N_KEY=%%a

echo Gerando chave de API segura para o Qdrant...
for /f "tokens=*" %%a in ('powershell -Command "[System.BitConverter]::ToString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(32)).Replace('-', '').ToLower()"') do set QDRANT_KEY=%%a

echo Gerando credenciais seguras para o MinIO...
for /f "tokens=*" %%a in ('powershell -Command "[System.BitConverter]::ToString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(4)).Replace('-', '').ToLower()"') do set MINIO_USER=admin_%%a
for /f "tokens=*" %%a in ('powershell -Command "[Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(9))"') do set MINIO_PASS=%%a

echo Gerando credenciais seguras para o RabbitMQ...
for /f "tokens=*" %%a in ('powershell -Command "[System.BitConverter]::ToString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(3)).Replace('-', '').ToLower()"') do set RABBITMQ_USER=admin_%%a
for /f "tokens=*" %%a in ('powershell -Command "[Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(8))"') do set RABBITMQ_PASS=%%a

echo Gerando credenciais seguras para o Elasticsearch...
for /f "tokens=*" %%a in ('powershell -Command "[Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(12))"') do set ELASTIC_PASS=%%a

echo Gerando credenciais seguras para o PostgreSQL com pgvector...
for /f "tokens=*" %%a in ('powershell -Command "[Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(9))"') do set PGVECTOR_PASS=%%a

echo Gerando credenciais seguras para o pgAdmin...
for /f "tokens=*" %%a in ('powershell -Command "[System.BitConverter]::ToString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(4)).Replace('-', '').ToLower()"') do set PGADMIN_EMAIL=admin.%%a@example.com
for /f "tokens=*" %%a in ('powershell -Command "[Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(9))"') do set PGADMIN_PASS=%%a
for /f "tokens=*" %%a in ('powershell -Command "[System.BitConverter]::ToString([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(3)).Replace('-', '').ToLower()"') do set PGADMIN_USER=pgadmin_%%a
for /f "tokens=*" %%a in ('powershell -Command "[Convert]::ToBase64String([System.Security.Cryptography.RandomNumberGenerator]::GetBytes(8))"') do set PGADMIN_PASSWORD=%%a

echo.
echo [INFO] Atualizando as chaves no arquivo .env
REM Usar delimitadores diferentes para evitar problemas com caracteres especiais
powershell -Command "$content = Get-Content .env; $content -replace 'N8N_ENCRYPTION_KEY=.*', 'N8N_ENCRYPTION_KEY=%N8N_KEY%' | Set-Content .env"
powershell -Command "$content = Get-Content .env; $content -replace 'QDRANT_API_KEY=.*', 'QDRANT_API_KEY=%QDRANT_KEY%' | Set-Content .env"
powershell -Command "$content = Get-Content .env; $content -replace 'MINIO_ROOT_USER=.*', 'MINIO_ROOT_USER=%MINIO_USER%' | Set-Content .env"
powershell -Command "$content = Get-Content .env; $content -replace 'MINIO_ROOT_PASSWORD=.*', 'MINIO_ROOT_PASSWORD=%MINIO_PASS%' | Set-Content .env"
powershell -Command "$content = Get-Content .env; $content -replace 'RABBITMQ_DEFAULT_USER=.*', 'RABBITMQ_DEFAULT_USER=%RABBITMQ_USER%' | Set-Content .env"
powershell -Command "$content = Get-Content .env; $content -replace 'RABBITMQ_DEFAULT_PASS=.*', 'RABBITMQ_DEFAULT_PASS=%RABBITMQ_PASS%' | Set-Content .env"
powershell -Command "$content = Get-Content .env; $content -replace 'ELASTICSEARCH_PASSWORD=.*', 'ELASTICSEARCH_PASSWORD=%ELASTIC_PASS%' | Set-Content .env"
powershell -Command "$content = Get-Content .env; $content -replace 'PGVECTOR_PASSWORD=.*', 'PGVECTOR_PASSWORD=%PGVECTOR_PASS%' | Set-Content .env"
powershell -Command "$content = Get-Content .env; $content -replace 'PGADMIN_DEFAULT_EMAIL=.*', 'PGADMIN_DEFAULT_EMAIL=%PGADMIN_EMAIL%' | Set-Content .env"
powershell -Command "$content = Get-Content .env; $content -replace 'PGADMIN_DEFAULT_PASSWORD=.*', 'PGADMIN_DEFAULT_PASSWORD=%PGADMIN_PASS%' | Set-Content .env"
powershell -Command "$content = Get-Content .env; $content -replace 'PGADMIN_USER=.*', 'PGADMIN_USER=%PGADMIN_USER%' | Set-Content .env"
powershell -Command "$content = Get-Content .env; $content -replace 'PGADMIN_PASSWORD=.*', 'PGADMIN_PASSWORD=%PGADMIN_PASSWORD%' | Set-Content .env"

echo.
echo [INFO] Criando estrutura de pastas necessária...
if not exist "data" mkdir data
if not exist "n8n-local-files" mkdir n8n-local-files

echo.
echo [INFO] Iniciando os serviços com o Docker Compose...
%COMPOSE_CMD% up -d

echo.
echo Verificando se os serviços estão em execução...
timeout /t 5 >nul
%COMPOSE_CMD% ps

REM Obtendo a porta do N8N do arquivo .env
for /f "tokens=2 delims==" %%a in ('findstr "N8N_PORT" .env') do set N8N_PORT=%%a

echo.
echo ================================================
echo                INSTALAÇÃO CONCLUÍDA
echo ================================================
echo.
echo O N8N está disponível em: http://localhost:%N8N_PORT%
echo.
echo MinIO S3 está disponível em: http://localhost:9000
echo MinIO Console está disponível em: http://localhost:9001
echo   Usuário: %MINIO_USER%
echo   Senha: %MINIO_PASS%
echo   (guarde estas credenciais para acesso futuro)
echo.
echo RabbitMQ está disponível em: http://localhost:15672
echo   Usuário: %RABBITMQ_USER%
echo   Senha: %RABBITMQ_PASS%
echo   (guarde estas credenciais para acesso futuro)
echo.
echo Elasticsearch está disponível em: http://localhost:9200
echo   Usuário: elastic
echo   Senha: %ELASTIC_PASS%
echo   (guarde estas credenciais para acesso futuro)
echo.
echo PostgreSQL com pgvector está disponível em: localhost:5433
echo   Usuário: pgvector
echo   Senha: %PGVECTOR_PASS%
echo   Banco: vectordb
echo   (guarde estas credenciais para acesso futuro)
echo.
echo pgAdmin está disponível em: http://localhost:%PGADMIN_PORT%
echo   Email: %PGADMIN_EMAIL%
echo   Senha: %PGADMIN_PASS%
echo   ou use:
echo   Usuário: %PGADMIN_USER%
echo   Senha: %PGADMIN_PASSWORD%
echo   (guarde estas credenciais para acesso futuro)
echo.
echo Para parar os serviços, execute:
echo   %COMPOSE_CMD% down

echo [INFO] Configurando serviços...
echo Para personalizar quais serviços serão executados, você pode editar diretamente
echo o arquivo docker-compose.yml e comentar os serviços que não deseja utilizar.
echo Uma lista completa dos serviços disponíveis e um exemplo de como desabilitar
echo podem ser encontrados na seção 'INFORMAÇÕES SOBRE SERVIÇOS DISPONÍVEIS' do arquivo .env
echo Nota: O PostgreSQL e o Redis são obrigatórios e não devem ser desabilitados, pois são necessários para o n8n.

echo.
echo Para visualizar os logs, execute:
echo   %COMPOSE_CMD% logs -f
echo.
echo Divirta-se usando o N8N!

endlocal 