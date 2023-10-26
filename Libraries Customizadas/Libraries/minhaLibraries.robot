*** Settings ***
Library    C:/Users/jotha.joao/Desktop/robot/robot avancado/Libraries Customizadas/Libraries/SimpleMathLibrary/SimpleMathLibrary.py

*** Test Cases ***
Exemplo de Uso
    ${soma} =    Add Numbers    10    5
    ${subtracao} =    Subtract Numbers    20    7
    Should Be Equal As Numbers    ${soma}    15
    Should Be Equal As Numbers    ${subtracao}    13