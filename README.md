![](https://iot-dev.weg.net/assets/images/brand/brand.png) 

#  Template IoT iOS Sandbox

### Descrição
Projeto de Template iOS para servir como base para o desenvolvimento
de aplicações nativas. Possui Autenticação Azure AD B2C, já configurada
com redirecionamento para a URI de autenticação do portal IoT,
integração com API –
[http://iot-api-dev.weg.net](http://iot-api-dev.weg.net), para consumo
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

1. Solicitar acesso ao repositório
[IoT-IOS-Sandbox](http://sourcecode.weg.net:8080/external/git/iot-ios-sandbox),

2. Clonar Repositório e configurar novo Sourcecode;

3. Solicitar CLIENT_ID do aplicativo configurado na Azure, e configurá-lo
no template, `utils/Constants
"CLIENT_ID"`;

4. Solicitar configuração das ferramentas de integração contínua;

a. [Jenkins](https://jenkins.io/doc/) - Ferramenta de integração
contínua, que executa o pipeline no
[Jenkins WEG](http://jenkins.weg.net:8080/view/WEGDIGITAL/job/iot-ios-sandbox/),
configurado no arquivo `Jenskinsfile` do projeto
- Deve apontar para repositório clonado;
- Jenkinsfile deve apontar para novo projeto criado no Jenkins;

b. [SonarQube](https://docs.sonarqube.org/latest/) - Ferramenta de
inspeção contínua da qualidade do código,
[Sonar WEG](http://sonar.weg.net:4000/dashboard?id=iot-ios-sandbox).

5. Para criar novos serviços no Template recomenda-se seguir os
seguintes passos:

a. No pacote `model`, criar modelo (POJO), referente ao endpoint
(JSON) do serviço; 

b. Mapear rota do endpoint do servico na classe `APIRouter`;

d. Adicionar views ao Storyboard principal;

##### [OpenAPI - Swagger](https://swagger.io/docs/specification/about/)
Para receber informações sobre produtos WEG utiliza-se a API de
serviços [IoT API WEG](https://iot-api-dev.weg.net/swagger-ui.html).

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/caa84cb0f5b8fa01b23b)

##### [Sharepoint](https://intranet.weg.net/br/informatica/infra/cit/DOCUMENTOS/Forms/AllItems.aspx?RootFolder=%2Fbr%2Finformatica%2Finfra%2Fcit%2FDOCUMENTOS%2FProjetos%2F1000024412%20%2D%20WAU%20tomadas%20e%20interruptores%20inteligentes)

### Informações sobre o produto
- Tipo de planta: `HomeAutomation`

Exemplo:

```json
{
"id": "d41d8cd98f00b204e9800998ecf8427e",
"name": "My Smart Home",
"description": "My Smart Home Description",
"inaugurationDate": "2019-04-18T10:35:57.366Z",
"location": {
"cep": "89257-002",
"city": "Jaraguá do Sul",
"countryId": "BR",
"latitude": -26.4774303,
"longitude": -49.0473326,
"number": "1548",
"stateId": "SC",
"street": "Avenida Prefeito Waldemar Grubba - de 3293 ao fim - lado ímpar"
},
"plantType": "HomeAutomation",
"policyAgreed": true,
"timezoneId": "Etc/GMT+3"
}
```
- Tipo de produto: `home-automation`
- Tipos de dispositivo:
-- `WTOM01`: Smart Outlet
-- `WDIM01`: Smart Dimmer
-- `WINT01`: Smart Switch

Exemplo:
```json
{
"id": "d41d8cd98f00b204e9800998ecf8427e",
"name": "ITSmartOutlet01",
"productModelId": "WTOM01",
"productTypeId": "home-automation",
"characteristics": {
"ip": "opc.tcp://10.192.25.1:4840",
"certification": "true",
"authentication": "true"
},
"connectionType": "MqttDevice"
}
```

### Informações sobre dependências
- Biblioteca utilizada para autenticação -
[MSAL](https://github.com/AzureAD/)
- Biblioteca utilizada para realizar requisições REST -
[Alamofire](https:///)


##### Limitações


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
├───androidTest
│   └───java
│       └───net
│           └───weg
│               └───iot
│                   └───ui
│                       └───activity
├───main

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
A localização do código de teste depende do tipo de teste criado.
##### Testes Unitários
Localizados em `iot/src/test/java/`. Para realizar os testes unitários é
utilizado a ferramenta
[JUNIT](https://junit.org/junit5/docs/current/user-guide/), que executa
na JVM local do computador. Esses testes servem para testar pequenos
módulos da aplicação, minimizando o tempo de execução, quando os testes
não têm dependências de estrutura Android ou quando você pode simular
essas dependências, para isso é possível utilizar o Framework
[MOCKITO](https://site.mockito.org/). Este template possui um exemplo de
teste, em que é verificada a função de procura de plantas.

##### Testes Instrumentados
Localizados em `iot/src/androidTest/java/`. São testes executados em um
dispositivo ou emulador de hardware. Esses testes têm acesso a APIs de
[instrumentação](https://developer.android.com/reference/android/app/Instrumentation.html?hl=pt-br),
disponibilizando acesso a informações como o
[Context](https://developer.android.com/reference/android/content/Context.html?hl=pt-br)
do aplicativo. Use esses testes ao programar testes de integração e
funcionais de IU para automatizar a interação do usuário ou quando os
testes têm dependências do Android que os objetos simulados não
conseguem atender. A ferramenta
[Espresso](https://developer.android.com/topic/libraries/testing-support-library/index.html?hl=pt-br#Espresso)
auxilia no desenvolvimento destes testes. Neste template foram
implementados testes que verificam o fluxo de login, logout e procura de
plantas.


### Contato técnico
##### DEV
##### Negócio
### Release Notes

