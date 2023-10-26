*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***

${BROWSER}    firefox
${CADASTRO_EMAIL}    email_create
${CADASTRO_CONTA}    SubmitCreate
${CADASTRO_CAMPO}    //*[@id="account-creation_form"]//h3[contains(text(),"Your personal information")]
${CADASTRO_GENDER}    id_gender2
${CADSTRO_NOME}    customer_firstname
${CADASTRO_SOBRENOME}    customer_lastname
${CADASTRO_PASS}    passwd 
${CADASTRO_ADRESS}    address1 
${CADASTRO_CIDADE}    city
${CASTRO_STATE}    id_state
${CADASTRO_CODE}    postcode
${CADASTRO_FONE}    phone_mobile
${CADASTRO_SUBMIT}    submitAccount
${CADASTRO_OK}    //*[@id="center_column"]/p
${CADASTRO_HEADER}    //*[@id="header"]/div[2]//div[1]/a/span


*** Keywords ***

Informar um e-mail válido
    Wait Until Element Is Visible   ${CADASTRO_EMAIL}
    ${EMAIL}                        Generate Random String
    Input Text                      ${CADASTRO_EMAIL}    ${EMAIL}@testerobot.com

Clicar em "Create an account"
    Click Button    ${CADASTRO_CONTA}    

Preencher os dados obrigatórios
    Wait Until Element Is Visible    ${CADASTRO_CAMPO}   
    Click Element                   ${CADASTRO_GENDER}
    Input Text                      ${CADSTRO_NOME}                 May
    Input Text                      ${CADASTRO_SOBRENOME}           Fernandes
    Input Text                      ${CADASTRO_PASS}                123456
    Input Text                      ${CADASTRO_ADRESS}              Rua Framework, Bairro Robot
    Input Text                      ${CADASTRO_CIDADE}              Floripa
    Set Focus To Element            ${CASTRO_STATE} 
    ### No firefox ocorreu problema ao achar o listbox State, então coloquei um if para esperar
    ### pelo elemento quando for firefox
    Run Keyword If    '${BROWSER}'=='firefox'  Wait Until Element Is Visible   ${CASTRO_STATE}
    Select From List By Index       ${CASTRO_STATE}           9
    Input Text                      ${CADASTRO_CODE}          12345
    Input Text                      ${CADASTRO_FONE}          99988877

Submeter cadastro
    Click Button    ${CADASTRO_SUBMIT}

Conferir se o cadastro foi efetuado com sucesso
    Wait Until Element Is Visible    ${CADASTRO_OK}
    Element Text Should Be           ${CADASTRO_OK}
    ...    Welcome to your account. Here you can manage all of your personal information and orders.
    Element Text Should Be           ${CADASTRO_HEADER}    May Fernandes