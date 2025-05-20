# 📚 Grimório das Bibliotecas Ancestrais

> *"Todo grande Mestre da Automação conhece um segredo: por trás dos fluxos visuais existem magias antigas, criadas pelos Programadores Code, que podem ser invocadas para potencializar seus feitiços."* - *Conselho dos Arcanos da Automação*

## 🪄 As Magias Primitivas do n8n

No coração do n8n existe um portal dimensional que permite acessar magias ancestrais da terra do JavaScript, criadas pelos Programadores Code ao longo de eras. Estas magias, conhecidas como "bibliotecas externas", são artefatos de poder que permitem realizar feitos extraordinários sem precisar escrever encantamentos complexos do zero.

## 🔓 O Portal Dimensional: NODE_FUNCTION_ALLOW_EXTERNAL

Para proteger o reino da automação, o n8n mantém este portal dimensional fechado por padrão. A variável sagrada `NODE_FUNCTION_ALLOW_EXTERNAL` é a chave que abre este portal, permitindo que bibliotecas específicas sejam invocadas em seus fluxos de trabalho.

```
NODE_FUNCTION_ALLOW_EXTERNAL=moment,lodash,axios,date-fns,uuid,crypto-js,validator,numeral,mathjs,xml2js,cheerio,dotenv,js-yaml,papaparse,fast-csv,qs,jsonwebtoken,node-fetch,dayjs,luxon,xlsx
```

Esta linha de encantamento em seu grimório `docker-compose.yml` permite que você use estas bibliotecas poderosas diretamente dentro de nós "Function" ou "Code" do n8n. Sem esta permissão, suas tentativas de invocar estas magias seriam bloqueadas pelos guardiões da segurança.

## 🧙‍♂️ O Grimório das Bibliotecas Ancestrais

Aqui está um catálogo das magias mais poderosas disponíveis através do portal dimensional:

### ⏳ Magias do Tempo
- **moment**: O manipulador do tempo primordial. Permite transformar, calcular e formatar datas com precisão.
   ```javascript
   const dataFormatada = moment().format('DD/MM/YYYY');
   ```

- **date-fns**: Fragmentos de tempo encapsulados em funções modulares e precisas.
   ```javascript
   const dataFutura = dateFns.addDays(new Date(), 7);
   ```

- **dayjs**: Controle temporal leve e eficiente, perfeito para magias sutis.
   ```javascript
   const inicioDoMes = dayjs().startOf('month').format('YYYY-MM-DD');
   ```

- **luxon**: Manipulação avançada de datas, fusos horários e durações.
   ```javascript
   const dataEmTokyo = DateTime.now().setZone('Asia/Tokyo').toString();
   ```

### 🧰 Utilitários Arcanos
- **lodash**: A caixa de ferramentas dos magos. Uma coleção vasta de utilidades para manipular dados.
   ```javascript
   const itensUnicos = _.uniq(['magia', 'poção', 'grimório', 'poção']);
   ```

- **uuid**: Conjura identificadores únicos universais, essenciais para distinguir objetos mágicos.
   ```javascript
   const idUnico = uuid.v4(); // Cria um identificador único
   ```

- **validator**: O verificador de verdades. Confirma se textos seguem padrões específicos.
   ```javascript
   const emailValido = validator.isEmail('mago@reino.com');
   ```

- **numeral**: Transmuta números entre diferentes formas e unidades.
   ```javascript
   const ouro = numeral(1000).format('0,0.00');
   ```

- **mathjs**: Biblioteca de cálculos avançados e manipulação matemática.
   ```javascript
   const resultado = math.evaluate('2 + 3 * 4'); // 14
   ```

### 🌐 Comunicação com Outros Reinos
- **axios**: Emissário que viaja entre reinos digitais (APIs) com velocidade e confiabilidade.
   ```javascript
   const resposta = await axios.get('https://api.outromundo.com/dados');
   ```

- **node-fetch**: Invocador primitivo de dados de terras distantes.
   ```javascript
   const dados = await fetch('https://api.reino.com/recursos').then(r => r.json());
   ```

- **cheerio**: Extrator de conhecimento de pergaminhos HTML. Permite coletar informações específicas de páginas web.
   ```javascript
   const titulo = cheerio.load(html)('h1').text();
   ```

### 🔐 Magias de Proteção e Segurança
- **crypto-js**: Arsenal de encantos para proteger seus dados com criptografia.
   ```javascript
   const segredo = CryptoJS.AES.encrypt('mensagem secreta', 'chave').toString();
   ```

- **jsonwebtoken**: Forja selos mágicos que verificam a identidade de viajantes entre reinos.
   ```javascript
   const token = jwt.sign({ id: 'mago123' }, 'segredo_do_reino');
   ```

### 📊 Transmutação de Dados
- **xml2js**: Transforma escritos antigos (XML) em objetos modernos (JSON).
   ```javascript
   const objeto = await xml2js.parseStringPromise(xmlString);
   ```

- **js-yaml**: Converte entre o formato YAML e objetos JavaScript.
   ```javascript
   const config = yaml.load(conteudoYaml);
   ```

- **papaparse** e **fast-csv**: Decifradores de tabelas (CSV) com diferentes especialidades.
   ```javascript
   const resultados = Papa.parse(csvString, { header: true });
   ```

- **xlsx**: Manipulador de pergaminhos Excel, permitindo ler e criar planilhas mágicas.
   ```javascript
   const planilha = XLSX.read(dados, { type: 'array' });
   ```

- **qs**: Traduz entre strings de consulta e objetos JavaScript.
   ```javascript
   const parametros = qs.parse('categoria=poções&ordem=preco');
   ```

### 🏯 Configuração de Reinos
- **dotenv**: Guardião de segredos, permite armazenar configurações em arquivos .env.
   ```javascript
   require('dotenv').config();
   const apiKey = process.env.API_KEY;
   ```

## ✨ Invocando as Bibliotecas Ancestrais no n8n

Para usar estas magias em seus fluxos de trabalho:

1. **Crie um nó Function ou Code** no seu fluxo
2. **Invoque a biblioteca** no início do seu código:
   ```javascript
   const moment = require('moment');
   const _ = require('lodash');
   ```
3. **Utilize os poderes** da biblioteca em seu encantamento:
   ```javascript
   const agora = moment();
   const ontem = moment().subtract(1, 'days');
   const diasEntre = agora.diff(ontem, 'days');
   
   return {diasEntre};
   ```

## 🪄 Exemplos de Feitiços Avançados

### Encantamento da Transformação de Datas
```javascript
// Transforma todas as datas em um formato específico
const moment = require('moment');
const _ = require('lodash');

// Entrada: um array de objetos com datas
const items = $input.json.items;
const transformados = _.map(items, item => {
  return {
    ...item,
    dataFormatada: moment(item.data).format('DD/MM/YYYY'),
    prazoFinal: moment(item.data).add(30, 'days').format('DD/MM/YYYY')
  };
});

return {transformados};
```

### Ritual de Consulta à API Externa com Autenticação
```javascript
// Busca dados de um reino externo
const axios = require('axios');
const crypto = require('crypto-js');

// Gera assinatura para autenticação
const timestamp = Date.now().toString();
const signature = crypto.HmacSHA256(timestamp, 'chave_secreta').toString();

// Consulta o reino externo
const response = await axios.get('https://api.outromundo.com/recursos', {
  headers: {
    'X-Auth-Timestamp': timestamp,
    'X-Auth-Signature': signature
  }
});

return response.data;
```

### Feitiço de Processamento de Planilhas Mágicas
```javascript
// Transforma planilhas Excel em conhecimento
const XLSX = require('xlsx');
const _ = require('lodash');

// Lê a planilha mágica
const workbook = XLSX.read($binary.data, {type: 'buffer'});
const primeiraFolha = workbook.SheetNames[0];
const dados = XLSX.utils.sheet_to_json(workbook.Sheets[primeiraFolha]);

// Extrai estatísticas
const total = _.sumBy(dados, 'valor');
const media = total / dados.length;
const maximo = _.maxBy(dados, 'valor');

return {total, media, maximo, dados};
```

## ⚠️ Avisos dos Sábios Arcanos

1. **Use com Sabedoria**: Estas bibliotecas aumentam o poder de seus feitiços, mas também consomem mais recursos mágicos (memória e CPU).

2. **Cuidado com Versões**: O n8n inclui versões específicas destas bibliotecas. Algumas magias documentadas nos grimórios oficiais podem não funcionar se forem de versões diferentes.

3. **Segurança Acima de Tudo**: Bibliotecas como `crypto-js` oferecem proteção, mas lembre-se que a segurança verdadeira vem de práticas corretas. Nunca armazene chaves mágicas diretamente em seus fluxos.

4. **Expansão do Portal**: Para adicionar mais bibliotecas ao portal, você pode estender a lista em `NODE_FUNCTION_ALLOW_EXTERNAL`, mas faça isso com cautela, pois cada nova biblioteca pode trazer riscos desconhecidos.

---

## 🌟 Ascendendo à Maestria

Dominar estas bibliotecas ancestrais é o que separa um mero usuário de n8n de um verdadeiro Mestre da Automação. Ao combinar o poder visual dos fluxos com estas magias primitivas, você poderá criar soluções que transcendem as limitações dos nós padrão.

*"A verdadeira magia não está nas bibliotecas em si, mas na sabedoria de saber quando e como invocá-las."* - *Conselho dos Arcanos da Automação*

Que suas bibliotecas estejam sempre acessíveis e seus códigos, sempre funcionais! 📚✨ 