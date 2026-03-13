*** Settings ***
Library    Selenium2Library
Library    Collections
Library    String

#Bejelentkezés és hitelesítés
#Bejelentkezés érvényes adatokkal
#Bejelentkezés érvénytelen adatokkal
#Üres mezők ellenőrzése
#Kijelentkezés

*** Test Cases ***
Login and validating right
    Open Browser    https://demo.testim.io/    chrome
    Click Button    //*[@id="app"]/div/header/div/div[2]/ul/li/button
    Input Text    locator=//*[@id="login"]/div[1]/input    text=JOHN
    Input Password    locator=//*[@id="login"]/div[2]/input    password=Password
    Click Button    //*[@id="app"]/div/section[3]/div/div[2]/div/nav/button[2]
    ${username}=    Get Text    //*[@id="app"]/div/header/div/div[2]/ul/div/button/span[1]
    ${username}=    Convert To Upper Case    ${username.replace('HELLO, ','')}
    Should Be Equal    ${username}    JOHN
    Click Button    //*[@id="app"]/div/header/div/div[2]/ul/div/button
    Click Element    //*[@id="app"]/div/header/div/div[2]/ul/div/ul/li/a
    Close Browser

Login and validating wrong
    Open Browser    https://demo.testim.io/    chrome
    Click Button    //*[@id="app"]/div/header/div/div[2]/ul/li/button
    Input Text    locator=//*[@id="login"]/div[1]/input    text=NOTJOHN
    Input Password    locator=//*[@id="login"]/div[2]/input    password=Password
    Click Button    //*[@id="app"]/div/section[3]/div/div[2]/div/nav/button[2]
    ${username}=    Get Text    //*[@id="app"]/div/header/div/div[2]/ul/div/button/span[1]
    ${username}=    Convert To Upper Case    ${username.replace('HELLO, ','')}
    Should Not Be Equal    ${username}    NOTJOHN
    Click Button    //*[@id="app"]/div/header/div/div[2]/ul/div/button
    Click Element    //*[@id="app"]/div/header/div/div[2]/ul/div/ul/li/a
    Close Browser

Login with invalid user
    Open Browser    https://demo.testim.io/    chrome
    Click Button    //*[@id="app"]/div/header/div/div[2]/ul/li/button
    Input Text    locator=//*[@id="login"]/div[1]/input    text=
    Input Password    locator=//*[@id="login"]/div[2]/input    password=Password
    Sleep    1s
    Click Button    //*[@id="app"]/div/section[3]/div/div[2]/div/nav/button[2]
    Page Should Contain Element    //*[@id="login"]/div[1]/span[3]
    Close Browser

Check empty credentials
    Open Browser    https://demo.testim.io/    chrome
    Click Button    //*[@id="app"]/div/header/div/div[2]/ul/li/button
    Input Text    locator=//*[@id="login"]/div[1]/input    text=
    Input Password    locator=//*[@id="login"]/div[2]/input    password=
    Sleep    1s
    Click Button    //*[@id="app"]/div/section[3]/div/div[2]/div/nav/button[2]
    Element Text Should Be    //*[@id="login"]/div[1]/span[3]    Name is a required field.
    Element Text Should Be    //*[@id="login"]/div[2]/span[3]    Password is a required field.
    Close Browser