*** Settings ***
Library     DiffLibrary

*** Test Cases ***
Caso de teste 1 - Comprarar dois arquivos de teste
    [Tags]    comparar os casos
    Realizar o primeiro teste de dois arquivos identicos
    Realizar o primeiro teste de dois arquivos diferentes


*** Keywords ***
Realizar o primeiro teste de dois arquivos identicos
    Diff Files    file1=C:/Users/jotha.joao/Downloads/teste.txt    file2=C:/Users/jotha.joao/Downloads/teste_certo.txt



Realizar o primeiro teste de dois arquivos diferentes
    Diff Files    file1=C:/Users/jotha.joao/Downloads/teste.txt    file2=C:/Users/jotha.joao/Downloads/teste_errado.txt