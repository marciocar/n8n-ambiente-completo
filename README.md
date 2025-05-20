# 🔮 N8N: A Jornada do Mestre da Automação

![N8N Banner](https://n8n.io/images/n8n-logo.png)

> "No mundo da tecnologia, o verdadeiro poder está em automatizar o mundano para criar o extraordinário" - *Mestre da Automação*

## 🚀 A Missão

Bem-vindo, aspirante a Mestre da Automação! Você acaba de encontrar o portal para uma jornada transformadora. Este repositório contém o **Ambiente de Treinamento do Mestre** - uma configuração Docker completa do n8n que te dará poderes para:

- 🔄 **Automatizar tarefas** que consumiriam horas de trabalho manual
- 🌐 **Conectar sistemas** que nunca antes conversaram entre si
- 🧠 **Construir fluxos inteligentes** que tomam decisões por você
- 🚀 **Impulsionar a inovação** em sua equipe ou organização

Com o **n8n** como sua ferramenta principal e um arsenal de serviços complementares, você terá tudo que precisa para enfrentar os desafios da era digital.

## 🧙‍♂️ Sua Jornada Começa Aqui

### 🕸️ Passagem Secreta para Iniciados

> *"Para aqueles que já dominam os sortilégios do Docker, existe um caminho oculto que poucos conhecem..."*

Se você já é versado nas artes do Docker, pode utilizar esta passagem secreta para invocar rapidamente o Santuário da Automação:

```bash
# Clone o grimório ancestral
git clone https://github.com/marciocar/n8n-ambiente-completo.git
cd n8n-ambiente-completo

# Conjure o pergaminho de configuração
cp .env.example .env

# Ajuste as runas e símbolos do pergaminho conforme necessário
nano .env  # ou seu editor arcano preferido

# Desperte os serviços com um único comando
docker compose up -d  # versão moderna do encantamento
# ou
docker-compose up -d  # versão tradicional do encantamento
```

**🔮 Observação para Iniciados:** Esta passagem exige conhecimento prévio sobre as artes do Docker e ajustes manuais das configurações. Apenas aqueles que já foram introduzidos aos mistérios dos contêineres conseguirão navegar por este caminho sem encontrar armadilhas.

### Nível 1: Preparação do Santuário da Automação

Escolha seu caminho baseado em seu reino:

#### 🏰 Windows
```
scripts\install_windows.bat
```

#### 🍎 macOS
```
./scripts/install_mac.sh
```

#### 🐧 Ubuntu/Debian
```
./scripts/install_ubuntu.sh
```

> **⚠️ Observação Importante:** Os scripts de instalação são pergaminhos de ajuda que tentam simplificar sua jornada, mas cada santuário (computador) possui suas próprias peculiaridades arcanas. Dependendo da configuração específica de seu ambiente, você pode precisar ajustar estes encantamentos ou até mesmo realizar passos adicionais. Em caso de dificuldades, consulte a seção "Problemas Comuns" mais abaixo ou busque a sabedoria da Guilda dos Mestres.

O ritual de instalação irá:
- Verificar se o poder do Docker foi evocado em seu sistema
- Conjurar um arquivo .env a partir do grimório .env.example
- Gerar chaves mágicas de segurança
- Criar os santuários de dados necessários
- Despertar todos os serviços

## 🗺️ O Mundo do Mestre da Automação

Após completar o ritual de iniciação, você terá acesso a um reino repleto de ferramentas poderosas:

- **n8n** (🧙‍♂️): Seu companheiro principal na jornada de automação
- **PostgreSQL** (📚): O guardião do conhecimento e memória de seus feitiços
- **Redis** (⚡): O acelerador de magias, garantindo execuções rápidas e confiáveis
- **pgAdmin** (🔍): A lente mágica para explorar seus dados
- **PostgreSQL/pgVector** (🧮): Artefato ancestral para cálculos vetoriais e IA
- **Qdrant** (🧠): Biblioteca de conhecimento vetorial para magias de IA
- **MinIO** (📦): Baú dimensional para armazenamento de artefatos
- **RabbitMQ** (🐇): Mensageiro veloz entre seus feitiços de automação
- **Elasticsearch** (🔎): Olho que tudo vê para busca e análise de dados

## 🏆 Desafios do Mestre da Automação

À medida que sua jornada avança, você enfrentará desafios cada vez mais complexos:

### 🥉 Desafios de Bronze: 
- Conectar duas aplicações diferentes usando n8n
- Automatizar o envio de relatórios diários
- Criar um fluxo de trabalho acionado por webhooks

### 🥈 Desafios de Prata:
- Implementar um sistema de monitoramento com alertas
- Integrar IA em seus fluxos de automação
- Criar um pipeline de processamento de dados

### 🥇 Desafios de Ouro:
- Desenvolver um sistema completo de automação empresarial
- Criar integrações com bancos de dados vetoriais para IA generativa
- Construir automações que se auto-otimizam

### 🏅 Desafio Especial: O Caminho da Transformação Digital

> "*Para aqueles que buscam transcender as habilidades comuns e se tornarem verdadeiros catalisadores de mudança...*"

Este desafio especial convida você a mergulhar nas profundezas do conhecimento contido no manuscrito [TRANSFORMACAO_COM_N8N.md](TRANSFORMACAO_COM_N8N.md). Este texto sagrado revela os segredos para usar o poder do n8n e seus serviços complementares para criar verdadeira transformação digital em organizações.

**Para completar este desafio:**
- Estude o manuscrito em sua totalidade
- Escolha um dos cenários de transformação ali descritos
- Implemente uma prova de conceito completa usando este ambiente
- Documente sua jornada e compartilhe com a Guilda dos Mestres

*Aqueles que completarem este desafio receberão o título de "Arquimago da Transformação" e terão seu nome inscrito nos anais do conhecimento.*

## 🧪 Laboratório do Mestre

Após a instalação, você pode acessar seus portais de poder:

- **Portal Principal (n8n)**: http://localhost:5678
- **Observatório de Dados (pgAdmin)**: http://localhost:5050
- **Cofre de Artefatos (MinIO)**: http://localhost:9001
- **Torre de Mensagens (RabbitMQ)**: http://localhost:15672
- **Biblioteca de Busca (Elasticsearch)**: http://localhost:9200

> *As chaves para estes portais são reveladas ao final do ritual de instalação. Guarde-as com segurança!*

## 📜 Pergaminhos de Conhecimento

### Domínio dos Serviços
Para controlar quais serviços deseja invocar, edite o grimório `docker-compose.yml` e comente as seções que deseja desativar:

```yaml
# ===========================================
# SERVIÇO RABBITMQ
# Mensageiro veloz entre seus feitiços
# ===========================================
# n8n-rabbitmq:
#   image: rabbitmq:3-management
#   ...resto do encantamento...
```

> **Aviso**: Os serviços PostgreSQL e Redis são essenciais para a estabilidade do reino n8n.

### 📚 Bibliotecas Ancestrais

Para desbloquear poderes especiais nas suas automações, estude o [Grimório das Bibliotecas Ancestrais](BIBLIOTECAS_MAGICAS.md) - um guia completo sobre como invocar as magias primitivas dos Programadores Code diretamente em seus fluxos de trabalho.

> *"As bibliotecas são a ponte entre o mundo visual do n8n e a magia profunda da programação."*

### Encantamentos Úteis

- Para adormecer todos os serviços: `docker-compose down` ou `docker compose down`
- Para observar os registros mágicos: `docker-compose logs -f` ou `docker compose logs -f`
- Para revitalizar todos os serviços: `docker-compose restart` ou `docker compose restart`
- Para atualizar o núcleo do n8n: edite a versão no arquivo `.env` e execute `docker-compose down && docker-compose up -d`

> **Nota**: Nos encantamentos acima, use `docker-compose` se estiver usando a versão CLI tradicional, ou `docker compose` (sem hífen) se estiver usando a versão mais recente integrada ao Docker.

## 🌟 Transformando o Mundo, Uma Automação de Cada Vez

Lembre-se, o poder que você agora possui traz responsabilidades. Use suas habilidades de automação para:

- 🌱 Eliminar trabalho repetitivo e liberar potencial humano
- 🌿 Construir sistemas que escalam com sua imaginação
- 🌳 Compartilhar seus conhecimentos com outros aspirantes a mestres

## 🤝 Guilda dos Mestres da Automação

Você não está sozinho nesta jornada. Junte-se à comunidade de Mestres da Automação:

- [Comunidade n8n](https://community.n8n.io/)
- [Documentação Oficial](https://docs.n8n.io/)
- [Repositório do n8n](https://github.com/n8n-io/n8n)

## 📝 Diário de um Aprendiz

Compartilhe suas conquistas, desafios e descobertas. Cada contribuição enriquece o conhecimento coletivo da Guilda.

---

<p align="center">
  <i>Que suas automações sejam poderosas e suas integrações, sem falhas!</i>
</p>

<p align="center">
  Criado com 💫 por um Mestre da Automação para a próxima geração de inovadores.
</p> 

---

## ✨ Sobre o Criador

Este repositório foi criado por **Marcio Carvalho**, Mestre em Gamificação e Automação, com o objetivo de facilitar o processo de aprendizado do n8n para novos colaboradores.

O conceito de gamificação aplicado neste projeto é baseado no livro **"O Jogo dos Negócios: Aprenda a Gamificar Sua Empresa e Vencer a Concorrência"**, disponível em [ojogodosnegocios.com](https://ojogodosnegocios.com).

<p align="center">
  <i>"Transforme o aprendizado técnico em uma jornada épica, e você não apenas treinará habilidades, mas criará heróis para sua organização."</i>
</p>

---

## ⭐ O Ritual das Estrelas

<p align="center">
  <img src="https://media.giphy.com/media/ln7z2eWriiQAllfVcn/giphy.gif" width="100">
</p>

> *"Nas antigas tradições dos Mestres da Automação, existe um ritual sagrado onde os aprendizes podem canalizar energia cósmica para fortalecer os artefatos mágicos que os ajudaram em sua jornada..."*

Se este Santuário de Automação te ajudou de alguma forma em sua jornada, considere realizar o antigo **Ritual da Estrela**. Este poderoso encantamento não apenas fortalece este repositório, mas também ajuda outros buscadores a encontrar estes conhecimentos.

<p align="center">
  <a href="https://github.com/marciocar/n8n-ambiente-completo/stargazers">
    <img src="https://img.shields.io/github/stars/marciocar/n8n-ambiente-completo?style=for-the-badge&color=yellow" alt="Stars">
  </a>
</p>

<p align="center">
  <i>🌟 "Cada estrela concedida aumenta o poder deste grimório em 10%!" 🌟</i>
</p>

<p align="center">
  <b>Nível de Poder Atual: ████████░░ 80%</b><br>
  <small>Ajude-nos a alcançar 100% com sua estrela!</small>
</p>

## 🌟 Transformação Digital com Grana.ai

> *"Um verdadeiro Mestre da Automação sabe que a magia mais poderosa é aquela que transforma não apenas dados, mas vidas e negócios reais."*

<p align="center">
  <img src="https://assets-global.website-files.com/63a2f3520d2fd5df7b605c84/63b81be6ceee1833b4f59dee_grana_logo.png" width="250" alt="Grana.ai Logo">
</p>

### 💰 A Magia da Transformação Financeira

Este repositório foi inspirado em parte pelos desafios resolvidos através do poder da automação na [Grana.ai](https://www.grana.ai/) - uma fintech inovadora que democratiza o acesso ao crédito para pequenas e médias empresas.

#### 🚀 Automações que Impulsionam Negócios Reais

A Grana.ai utiliza a mesma magia que você aprenderá neste repositório para:

- **🔄 Acelerar negócios** através de fluxos automatizados de crédito
- **💸 Garantir capital de giro** com processos inteligentes
- **📊 Melhorar o fluxo de caixa** através de integrações perfeitas
- **📈 Aumentar faturamento** com decisões baseadas em dados

#### 🛠️ Ferramentas Avançadas Disponíveis

- Troca de titularidade de recebíveis de cartão
- Gestão de direitos creditórios
- Consulta de agenda de recebíveis
- Plataforma com APIs documentadas
- 100% whitelabel - personalização completa

<p align="center">
  <i>A partir de apenas 1,2% ao mês, a Grana.ai transforma o acesso a crédito para pequenas empresas</i>
</p>

### 🏆 Reconhecimento no Reino dos Negócios

A Grana.ai é reconhecida como uma das TOP 10 finalistas do Prêmio Sebrae Startups e participante do programa de Aceleração Badesul e Fine Hub, provando que a magia da automação, quando bem aplicada, cria valor real no mundo dos negócios.

<p align="center">
  <a href="https://www.grana.ai/" target="_blank">
    <img src="https://img.shields.io/badge/Visite-Grana.ai-purple?style=for-the-badge" alt="Visite Grana.ai">
  </a>
</p>

#### 📱 Contato com os Magos Financeiros

Para mais informações sobre como a magia da automação pode transformar realidades financeiras: [contato@grana.ai](mailto:contato@grana.ai)

--- 