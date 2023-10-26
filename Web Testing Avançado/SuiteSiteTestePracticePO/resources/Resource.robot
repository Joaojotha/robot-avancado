*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${BROWSER}      firefox


*** Keywords ***
#### Setup e Teardown
Abrir navegador
    Open Browser        about:blank   ${BROWSER}

Fechar navegador
    Close Browser


