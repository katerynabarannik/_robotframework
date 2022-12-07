*** Settings ***
Library         SeleniumLibrary
Documentation       Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}            https://scouts.futbolkolektyw.pl/en/
${BROWSER}              Chrome
${SIGNINBUTTON}         xpath=//*/button/span[1]
${EMAILINPUT}           xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//input[@type='password']
${PAGELOGO}             xpath=//*[@title='Logo Scouts Panel']
${LANGUAGEDROPDOWN}     xpath=//*[@aria-haspopup]
${POLISH}               xpath=//*[@data-value='pl']
${ENGLISH}              xpath=//*[@data-value='en']
${FAIlMESSAGE}          xpath=//div[3]/span
${HEADEROFBOX}          xpath = //*/div[1]/h5

@{languages}            Polish      English

*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click On The Sign In Button
    Assert dashboard
    [Teardown]    Close Browser

Login to the system with empty fields
    Open Login Page
    Click On The Sign In Button
    Assert message
    [Teardown]    Close Browser

Login to the system with invalid password
    Open login Page
    Type in email
    Type in invalid password
    Click On The Sign In Button
    Assert invalid password message
    [Teardown]    Close Browser

Change language
    Open Login Page
    Click on the language dropdown
    FOR   ${LANGUAGEDROPDOWN}   IN  @{languages}
    Exit For Loop IF    "${LANGUAGEDROPDOWN}" == "${POLISH}"
    END
    Select "Polski"
    Assert title in polish
    [Teardown]    Close Browser

Check header of the box
    Open Login Page
    Assert header
    [Teardown]    Close Browser

*** Keywords ***
Open login page
    Open Browser        ${LOGIN URL}        ${BROWSER}
    Title Should Be    Scouts panel - sign in
Type in email
    Input Text      ${EMAILINPUT}   user07@getnada.com
Type in password
    Input Text      ${PASSWORDINPUT}   Test-1234
Type in invalid password
    Input Text      ${PASSWORDINPUT}   Rest
Click On The Sign In Button
    Click Element       ${SIGNINBUTTON}
Assert dashboard
    Wait Until Element Is Visible       ${PAGELOGO}
    Title Should Be      Scouts panel
    Capture Page Screenshot     screenshot_${TEST NAME}.png
Click on the language dropdown
    Click Element       ${LANGUAGEDROPDOWN}
Select "Polski"
    Click Element       ${POLISH}
Assert title in polish
    Wait Until Element Is Visible    ${LANGUAGEDROPDOWN}
    Title Should Be    Scouts panel - zaloguj
    Capture Page Screenshot    screenshot_${TEST NAME}.png
Assert message
    Wait Until Element Is Visible     ${FAIlMESSAGE}
    Element Text Should Be    ${FAIlMESSAGE}   Please provide your username or your e-mail.
    Capture Page Screenshot    screenshot_${TEST NAME}.png
Assert invalid password message
    Wait Until Element Is Visible     ${FAIlMESSAGE}
    Element Text Should Be    ${FAIlMESSAGE}   Identifier or password invalid.
    Capture Page Screenshot    screenshot_${TEST NAME}.png
Assert header
    Wait Until Element Is Visible       ${HEADEROFBOX}
    Element Text Should Be    ${HEADEROFBOX}       Scouts Panel


