*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${HOME_URL}          http://automationpractice.com
${HOME_TITLE}    My Store
${HOME_TOPMENU}    //*[@id="block_top_menu"]/ul
${HOME_PROCUT}    //*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
${HOME_BUTTON}    //*[@id="add_to_cart"]/button
${HOME_CHECKOUT}    //*[@id="layer_cart"]//a[@title="Proceed to checkout"]
${HOME_PESQUISAR}    submit_search
${HOME_CAMPO_PESQUISAR}    search_query
${HOME_SIGN}    //*[@id="header"]//*[@class="login"][contains(text(),"Sign in")]

*** Keywords ***

#### Ações
Acessar a página home do site
    Go To               ${HOME_URL}
    Wait Until Element Is Visible    xpath=${HOME_TOPMENU}
    Title Should Be     ${HOME_TITLE}

Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Input Text    ${HOME_CAMPO_PESQUISAR}     ${PRODUTO}

Clicar no botão pesquisar
    Click Element       ${HOME_PESQUISAR}

Clicar no botão "Add to Cart" do produto
    Wait Until Element Is Visible   ${HOME_PROCUT}
    Click Element                   ${HOME_PROCUT}
    Wait Until Element Is Visible   ${HOME_BUTTON}
    Click Button                    ${HOME_BUTTON}

Clicar no botão "Proceed to checkout"
    Wait Until Element Is Visible   ${HOME_CHECKOUT} 
    Click Element                   ${HOME_CHECKOUT} 

Adicionar o produto "${PRODUTO}" no carrinho
    Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Clicar no botão pesquisar
    Clicar no botão "Add to Cart" do produto
    Clicar no botão "Proceed to checkout"


Clicar em "Sign in"
    Wait Until Element Is Visible    ${HOME_SIGN}
    Click Element    ${HOME_SIGN}