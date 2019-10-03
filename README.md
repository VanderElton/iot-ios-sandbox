#  Template IoT iOS Sandbox

### Descrição
Projeto de Template iOS para servir como base para o desenvolvimento
de aplicações nativas. Possui Autenticação Azure AD B2C, já configurada
com redirecionamento para a URI de autenticação do portal IoT,
integração com API, para consumo
de serviços e integração com ferramentas de integração contínua.

### Pré-Requisitos
##### IDE
XCODE Version 10.2.1 (10E1001)

##### SDK
Target: iOS 12.2
Language: Swift

##### Versão Swift
Apple Swift version 5.0.1 (swiftlang-1001.0.82.4 clang-1001.0.46.5)
Target: x86_64-apple-darwin18.5.0

### Configurar Dependencias
##### Adicionar MSAL no projeto
1. Registrar App no portal Azure
2. Adicionar scheme URI redirect no arquivo Info.plist, com o formato msauth.<BUNDLE_ID>
3. Adicionar `LSApplicationQueriesSchemes` para permitir o uso do Microsoft Authenticator.
4. Adicionar uma nova chave `com.microsoft.adalcache` ao projeto.

### Utilização do Template

1. Solicitar CLIENT_ID do aplicativo configurado na Azure, e configurá-lo
no template, `utils/Constants
"CLIENT_ID"`;

2. Solicitar configuração das ferramentas de integração contínua;

a. [Jenkins](https://jenkins.io/doc/) - Ferramenta de integração
contínua, que executa o pipeline,
configurado no arquivo `Jenskinsfile` do projeto
- Deve apontar para repositório clonado;

b. [SonarQube](https://docs.sonarqube.org/latest/) - Ferramenta de
inspeção contínua da qualidade do código.

3. Para criar novos serviços no Template recomenda-se seguir os
seguintes passos:

a. No pacote `model`, criar modelo (POJO), referente ao endpoint
(JSON) do serviço; 

b. Mapear rota do endpoint do servico na classe `APIRouter`;

d. Adicionar views ao Storyboard principal;

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/caa84cb0f5b8fa01b23b)

### Informações sobre o produto
- Tipo de planta: `HomeAutomation`

Exemplo:

```json
{
"id": "string",
"name": "My Smart Home",
"description": "My Smart Home Description",
"inaugurationDate": "2019-04-18T10:35:57.366Z",
"location": {
"cep": "string",
"city": "string",
"countryId": "BR",
"latitude": 0.0,
"longitude": 0.0,
"number": "string",
"stateId": "string",
"street": "string"
},
"plantType": "string",
"policyAgreed": true,
"timezoneId": "Etc/GMT+3"
}
```

### Informações sobre dependências
- Biblioteca utilizada para autenticação -
[MSAL](https://cocoapods.org/pods/MSAL)
- Biblioteca utilizada para realizar requisições REST -
[Alamofire](https://cocoapods.org/pods/Alamofire)


### Configuração para aplicativos iOS nativos na Azure

Configuração - [https://portal.azure.com/](https://portal.azure.com/)

Em aplicativos nativos e mobile:
1.  O aplicativo executa  [políticas](https://docs.microsoft.com/pt-br/azure/active-directory-b2c/active-directory-b2c-reference-policies)  e recebe um  `authorization_code`  do Azure AD depois que o usuário conclui a política; 
2. O  `authorization_code`  representa a permissão do aplicativo para chamar serviços back-end em nome do usuário conectado no momento;  
3. O aplicativo pode trocar o  `authorization_code`  em segundo plano por um  `access_token`  e um  `refresh_token`;  
4. O aplicativo pode usar o `access_token` para autenticar em uma API
Web back-end em solicitações HTTP. Ele também pode usar o
`refresh_token` para obter um novo `access_token` quando o antigo
expira.

### Arquitetura do Template
```bash

───src

```
As classes do template foram organizadas em pacotes, conforme suas funcionalidades.

+ ***adapter:***

Contém as classes referentes a configuração dos dados na tela;

+ ***api :***

Contém classes referentes a configuração do Retrofit, responsável pelas
requisições Rest a API. Para cada novo serviço criado, deve-se criar seu
respectivo construtor na classe RetrofitConfig, para obter o objeto
retrofit;

+ ***auth :***

Contém classe referente a autenticação do aplicativo na Azure AD B2C;

+ ***filter :***

Contém classe referente ao filtro de busca do Android Toolbar;

+ ***helper :***

Contém classe referente ao armazenamento de variáveis primárias no
SharedPreference do contexto Android;

+ ***listener :***

Contém classe referente ao retorno da lógica de logout, que deve limpar
dados salvos e direcionar a página de acesso;

+ ***model :***

Contém os modelos referentes aos dados extraídos da API, para cada novo objeto a ser recebido, deve-se criar seu modelo neste pacote;

+ ***service :***

Contém as interfaces referentes aos serviços criados, que irão realizar requisições a API, os novos serviços devem ser criados neste pacote;

+ ***ui.activity :***

Contém as activities do aplicativo;

+ ***utils :***

Contém variáveis estáticas utilizadas no Aplicativo;

### Testes
