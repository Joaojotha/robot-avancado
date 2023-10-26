*** Settings ***
Library    SeleniumLibrary

*** Variables ***

${CARRINHO_TITLE}    Order - My Store
${CARRINHO_DELETE}    //*[@class="cart_quantity_delete"]
${CARINHO_MENSAGEM}    //*[@id="center_column"]/p[@class='alert alert-warning']

*** Keywords ***

Excluir o produto do carrinho
    Title Should Be    ${CARRINHO_TITLE}
    Wait Until Element Is Visible    ${CARRINHO_DELETE}
    Click Element    ${CARRINHO_DELETE}


Conferir se o carrinho fica vazio
    Wait Until Element Is Visible   xpath=${CARINHO_MENSAGEM} 
    Element Text Should Be          xpath=${CARINHO_MENSAGEM}     Your shopping cart is empty.
