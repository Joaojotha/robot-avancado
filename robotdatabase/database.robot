*** Settings ***
Documentation   [14/10/2019] https://franz-see.github.io/Robotframework-Database-Library/api/1.2.2/DatabaseLibrary.html
...             Instale: "pip install -U robotframework-databaselibrary"
...             Para acessar o BD o Robot precisa conhecer o DRIVER de cada banco, então precisamos instalar esse DRIVER também (instale apenas para o BD que você utiliza!) ...
...             Para PostgreSQL: "pip install psycopg2"
...             Para SQLite 3: não precisa instalar nada!
...             Para MySQL: "pip install pymysql"
...             Para SQL Server: "pip install pymssql"
...             Para Oracle: "pip install cx-Oracle"
Library         DatabaseLibrary
Test Setup      Conectar no Banco de Dados
Test Teardown   Desconectar do Banco de Dados

*** Test Cases ***
#Exemplo 01: Executando scripts SQL via Arquivos
##    Executar script via ARQUIVO no Banco de Dados       ${CURDIR}/my_sql_scripts/create_table_accounts.sql
#    Executar script via ARQUIVO no Banco de Dados       ${CURDIR}/my_sql_scripts/insert_into_account.sql
#    Confere se "May Fernandes" foi inserido com sucesso

Exemplo 02: Executando scripts SQL via STRING
    Executar script via STRING no Banco de Dados        INSERT INTO api_bb_pagamentos_status_lote (codigo , descricao) VALUES (12 , 'teste')
    Confere se "teste" foi inserido com sucesso

Exemplo 03: Select Statement
    ${RESPOSTA_SELECT}      Executar query no Banco de dados    SELECT * from api_bb_pagamentos_status_lote
    Log    ${RESPOSTA_SELECT}
    ## Para pegar um campo específico, utilize as tuplas [NUM_LINHA][NUM_COLUNA]
    Log    codigo ${RESPOSTA_SELECT[11][0]} - descricao: ${RESPOSTA_SELECT[11][1]}


*** Keywords ***
Conectar no Banco de Dados
    ## PostgreSQL
    Connect To Database   dbapiModuleName=psycopg2   dbName=hcosta   dbUsername=postgres   dbPassword=GX5+W68$Pt&W   dbHost=172.25.5.3   dbPort=5432
    ## SQLite 3
      # Connect To Database Using Custom Params   dbapiModuleName=sqlite3    db_connect_string=database="./${DBName}.db", isolation_level=None
    ## MySQL
      # Connect To Database   dbapiModuleName=pymysql   dbName=${DBName}   dbUsername=${DBUser}   dbPassword=${DBPass}   dbHost=${DBHost}   dbPort=${DBPort}
    ## SQL Server
      # Connect To Database   dbapiModuleName=pymssql   dbName=${DBName}   dbUsername=${DBUser}   dbPassword=${DBPass}   dbHost=${DBHost}   dbPort=${DBPort}	  
    ## Oracle
      # Connect To Database Using Custom Params    dbapiModuleName=cx_Oracle    db_connect_string="${DBName}/${DBUser}@${DBHost}:${DBPort}/${DBalias}"

Desconectar do Banco de Dados
    Disconnect From Database

Executar script via STRING no Banco de Dados
    [Arguments]          ${SCRIPT}
    Execute SQL String   sqlString=${SCRIPT}  sansTran=${False}

#Executar script via ARQUIVO no Banco de Dados
#    [Arguments]          ${FILE}
#    Execute SQL Script   sqlScriptFileName=${FILE}

Executar query no Banco de dados
    [Arguments]         ${QUERY}
    ${RESPONSE_QUERY}   Query   selectStatement=${QUERY}
    [Return]            ${RESPONSE_QUERY}

Confere se "${USER}" foi inserido com sucesso
    Check If Exists In Database    selectStatement=SELECT descricao FROM api_bb_pagamentos_status_lote WHERE descricao = '${USER}'


Limpar Tabela
    [Arguments]     ${TABELA}
    ${REGISTROS}    Row Count    selectStatement=SELECT * FROM ${TABELA}
    Run Keyword If  ${REGISTROS} > 0    Delete All Rows From Table    ${TABELA}
