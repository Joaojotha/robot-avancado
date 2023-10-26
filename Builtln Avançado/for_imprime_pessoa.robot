*** Settings ***

*** Test Cases ***
Teste de FOR aninhado
    cadastro de pessoa (FOR aninhado)

Teste de FOR com varias variaveis
    Criar lista de pessoas cargos e setor

*** Keywords ***
cadastro de pessoa (FOR aninhado)
    FOR  ${pessoas}    IN    JOAO    RAMOS    MARCOS
       Imprime os nome das pessoas    ${pessoas}
    END

Imprime os nome das pessoas
    [Arguments]    ${pessoas}
    FOR      ${tarefas}  IN   lavar    passar    limpar
       Log    O: ${pessoas} - vai: ${tarefas}
    END

Criar lista de pessoas cargos e setor
    FOR    ${index}    ${pessoa}    ${cargo}    ${setor}    IN
    ...    1    marcos    cordenador    sistema
    ...    2    felipe    cordenador    projetos
    ...    3    medice    cordenador    MIS
        Log    Chamada ${index}:\nO: ${pessoa}\nÉ: ${cargo}\nNo setor de: ${setor}
    END