*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections

*** Variables ***
${MEU_DIC_ESPERADO}    {"primeiro_nome": "joao" , "nomes_do_meio": "marcos" , "ultimo_nome": "jotha" , "apelido": "jotinha"}
${MEU_DIC_ESPERADO2}    {"primeiro_nome": "joao" , "nomes_do_meio": "otario" , "ultimo_nome": "ramos" , "apelido": "ramitos"}

*** Test Cases ***
Exemplo: Conferindo JSON complexo
    Confere objetos e sub-objetos do JSON
    Confere listas no JSON

*** Keywords ***
Pega JSON
    ${MEU_JSON_COMPLEXO}    Get File    ${CURDIR}/data/output/json_complexo.json
    ${MEU_JSON_COMPLEXO}    To Json    ${MEU_JSON_COMPLEXO}
    [Return]    ${MEU_JSON_COMPLEXO}



Confere objetos e sub-objetos do JSON
    ${MEU_JSON_COMPLEXO}    Pega JSON
    ${MEU_DIC_ESPERADO}    To Json    ${MEU_DIC_ESPERADO}
    ${MEU_DIC_ESPERADO2}    To Json    ${MEU_DIC_ESPERADO2} 
    ### Conferindo um sub-dicionário dentro de um JSON
    Dictionary Should Contain Sub Dictionary    ${MEU_JSON_COMPLEXO["pessoa"]["primeiro"]}
    ...         ${MEU_DIC_ESPERADO}
    Dictionary Should Contain Sub Dictionary    ${MEU_JSON_COMPLEXO["pessoa"]["segundo"]} 
    ...          ${MEU_DIC_ESPERADO2}

    ### Conferindo campo a campo
    Dictionary Should Contain Item    ${MEU_JSON_COMPLEXO["pessoa"]["primeiro"]}    apelido    jotinha
    Dictionary Should Contain Item    ${MEU_JSON_COMPLEXO["pessoa"]["segundo"]}    apelido    ramitos

    ### Chegando em um valor dentro de uma lista de dicionários

    Dictionary Should Contain Item    ${MEU_JSON_COMPLEXO["pessoa"]["hcosta"]["cargos"][0]}    setor    Sistemas
    Dictionary Should Contain Item    ${MEU_JSON_COMPLEXO["pessoa"]["hcosta"]["cargos"][1]}    setor    Sistemas
    Dictionary Should Contain Item    ${MEU_JSON_COMPLEXO["pessoa"]["hcosta"]["cargos"][0]}    cargo    analista de testes  

Confere listas no JSON

    ${MEU_JSON_COMPLEXO}    Pega JSON
    ### Conferindo valor contido em uma lista
    List Should Contain Value    ${MEU_JSON_COMPLEXO["pessoa"]["hcosta"]["linguagens"]["sistema"]}    PHP

    ### Pegando o valor de uma determinada posição da lista
    ${VALOR}    Get From List    ${MEU_JSON_COMPLEXO["pessoa"]["hcosta"]["linguagens"]["inovacao"]}    2
    Log    Game da opção escolhida: ${VALOR} 

    ### Conferindo se não há duplicidade de itens da lista
    List Should Not Contain Duplicates    ${MEU_JSON_COMPLEXO["pessoa"]["hcosta"]["linguagens"]["sistema"]}


    ### Percorrendo uma lista
    @{LISTA}    Get From Dictionary    ${MEU_JSON_COMPLEXO["pessoa"]["hcosta"]}    cargos
    FOR    ${element}    IN    @{LISTA}
        Log    ${element}
        
    END