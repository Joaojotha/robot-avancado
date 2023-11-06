*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    String
Library    OperatingSystem
Resource   ./variables/my_user_and_passwords.robot


*** Variables ***

${GIT_HOST}        https://api.github.com/
${ISSUE_URL}       /repos/Joaojotha/robot-avancado/issues


*** Test Cases ***
Exemplo: Fazendo autenticação básica (Basic Authentication)
    # Conectar com autenticação básica na API do GitHub
    Conectar com autenticação por token na API do GitHub
    Solicitar os dados do meu usuário

Exemplo: Usando parâmetros
     Conectar com autenticação por token na API do GitHub
     Pesquisar issues com o state "open" e com o label "bug"
#
Exemplo: Usando headers
    # Conectar com autenticação básica na API do GitHub
    Conectar com autenticação por token na API do GitHub
    Enviar a reação "eyes" para a issue "2"

Exemplo: Comentar em um issue
    Conectar com autenticação por token na API do GitHub
    Cadastrar comentário na issue "2"


*** Keywords ***

Conectar com autenticação por token na API do GitHub
    #Create dicttionary é usado para passar um login e senha ou um token para poder logar e obter a resposta da requisição
    #primeiro passo é criar o header, nesse caso usando bearer token. uma variavel sera criada para receber as informações
    #vinda da varivel armazenada no fonte my_user_and_passwords.robot. Nesse caso o token vai vim da variavel ${MY_GITHUB_TOKEN} 
    ${HEADERS}    Create Dictionary   Authorization=Bearer ${MY_GITHUB_TOKEN}
    #Create Session serve para criar uma sessão para passar toda requisção, token e o headers
    #Nesse caso abaixo, vamos passar o Token atraves da varivel ${HEADERS} que recebeu na hr da criação do dicionario e a url da requisição 
    Create Session    alias=testeGit    url=${GIT_HOST}    headers=${HEADERS}    disable_warnings=True
    

Solicitar os dados do meu usuário
    #agora vamos fazer a requisição passando como metodo GET e passando o endpoint user(usuario), onde vai ter a reposta de todas as informaçõs do ususario vinda da requisiçõa         
    ${DADOS_USUARIO}    POST On Session    alias=testeGit    url=/user
    Log    message=${DADOS_USUARIO.json()}
    Confere sucesso na requisição    ${DADOS_USUARIO}


Pesquisar issues com o state "${STATE}" e com o label "${LABEL}"
    &{PARAMETRO}           Create Dictionary    state=${STATE}       labels=${LABEL}
    ${DADOS_ISSUES}        Get Request          alias=testeGit       uri=${ISSUE_URL}     params=&{PARAMETRO} 
    Log                 Lista de Issues: ${DADOS_ISSUES.json()}
    Confere sucesso na requisição   ${DADOS_ISSUES}

Enviar a reação "${REACAO}" para a issue "${ISSUE_NUMERO}"
    ${HEADERS}    Create Dictionary   Accept=application/vnd.github.squirrel-girl-preview+json
    ${ENVIA_DADOS}    POST On Session    alias=testeGit   url=${ISSUE_URL}/${ISSUE_NUMERO}/reactions
    ...    data={"content": "${REACAO}"}    headers=${HEADERS}
    Log                 Meus dados: ${ENVIA_DADOS.json()}
    Confere sucesso na requisição    ${ENVIA_DADOS}    


Cadastrar comentário na issue "${ISSUE_12}"
      ${COMENTARIO}    POST On Session   alias=testeGit    url=${ISSUE_URL}/${ISSUE_12}/comments
      ...  data={"body": "Comentário cadastrado via Robot Framework!"}
      Confere sucesso na requisição    ${COMENTARIO}


Confere sucesso na requisição
    [Arguments]      ${RESPONSE}
    Should Be True   '${RESPONSE.status_code}'=='200' or '${RESPONSE.status_code}'=='201'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}


