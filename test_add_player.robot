*** Settings ***
Library         SeleniumLibrary
Documentation       Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}                https://scouts.futbolkolektyw.pl/en
${BROWSER}                  Chrome
${SIGNINBUTTON}             xpath = //*/button/span[1]
${EMAILINPUT}               xpath = //*[@id='login']
${PASSWORDINPUT}            xpath = //input[@type='password']
${PAGELOGO}                 xpath = //*[@title='Logo Scouts Panel']
${ADDPLAYERBUTTON}          xpath = //*/div[2]//button/span[1]
${ADDPLAYER URL}            https://scouts.futbolkolektyw.pl/en/players/add
${NAMEINPUT}                xpath = //*[@name='name']
${SURNAMEINPUT}             xpath = //*[@name='surname']
${AGEINPUT}                 xpath = //*[@name='age']
${MAINPOSITIONINPUT}        xpath = //*[@name='mainPosition']
${SUBMITBUTTON}             xpath = //*/div[3]/button[1]
${SECONDPOSITIONINPUT}      xpath = //*[@name='secondPosition']
${ADDLANGUAGEBUTTON}        xpath = //*[@aria-label='Add language']
${LANGUAGESINPUT}           xpath = //*[@name = 'languages[0]']
${CLEARBUTTON}              xpath = //*/button[2]/span[1]
${PHONEINPUT}               xpath = //*[@name='phone']
${WEIGHTINPUT}              xpath = //*[@name='weight']
${HEIGHTINPUT}              xpath = //*[@name='height']
${LEGDROPDOWN}              xpath = //*[@id='mui-component-select-leg']
${RIGHTLEG}                 xpath = //li[1]
${LEFTLEG}                  xpath = //li[2]
${CLUBINPUT}                xpath = //*[@name='club']
${LEVELINPUT}               xpath = //*[@name='level']
${DISTRICTDROPDOWN}         xpath = //*[@id='mui-component-select-district']
${OPOLE}                    xpath = //li[8]
${ACHIEVEMENTSINPUT}        xpath = //*[@name='achievements']
${ADDYOUTUBELINKBUTTON}     xpath = //*[@aria-label='Add link to Youtube']
${YOUTUBEINPUT}             xpath = //div[19]//input
${MAINPAGE}                 xpath = //*/ul[1]/div[1]
${LASTCREATEDPLAYER}        xpath = //*/div[3]/div[3]/div//a[1]/button


*** Test Cases ***
Adding player with filling required fields
    Provided precondition
    Click On The Add Player Button
    Type In Name
    Type In Surname
    Type In Age
    Type In Main Position
    Click On The Submit Button
    Assert new player in dashboard
    [Teardown]    Close Browser
Adding player with empty required fields
    Provided precondition
    Click On The Add Player Button
    Type In Name
    Type In Second Position
    Click On The Submit Button
    [Teardown]    Close Browser
Clear the form
    Provided precondition
    Click On The Add Player Button
    Click On The Add Language Button
    Type In Language
    Click On The Clear Button
    [Teardown]    Close Browser

Adding player with empty form
    Provided precondition
    Click On The Add Player Button
    Click On The Submit Button
    [Teardown]    Close Browser

Filling the Add Player form
    Provided precondition
    Click On The Add Player Button
    Type In Name
    Type In Surname
    Type In Phone
    Type In Weight
    Type In Height
    Type In Age
    Click On The Leg Dropdown
    Click On Right Leg
    Type In Club
    Type In Level
    Type In Main Position
    Type In Second Position
    Click On District Button
    Select Opole
    Type In Achivements
    Click On The Add Language Button
    Type In Language
    Click On The Add Youtube Button
    Add Link
    Click On The Submit Button
    Assert Title Of The Page
    [Teardown]    Close Browser

*** Keywords ***
Provided precondition
    Open Browser        ${LOGIN URL}        ${BROWSER}
    Maximize Browser Window
    Input Text          ${EMAILINPUT}           user07@getnada.com
    Input Text          ${PASSWORDINPUT}        Test-1234
    Click Element       xpath=//*/button/span[1]

Click On The Add Player Button
    Wait Until Element Is Visible       ${LASTCREATEDPLAYER}
    Sleep   2
    Click Element       ${ADDPLAYERBUTTON}
Type In Name
    Wait Until Element Is Visible       ${LEGDROPDOWN}
    Input Text          ${NAMEINPUT}        Manuel
Type In Surname
    Input Text          ${SURNAMEINPUT}         Nuer
Type In Age
    Input Text          ${AGEINPUT}     09291976
Type In Main Position
    Input Text           ${MAINPOSITIONINPUT}        forward
Type In Second Position
    Input Text           ${SECONDPOSITIONINPUT}        +goalkeeper
Click On The Submit Button
    Scroll Element Into View    ${SUBMITBUTTON}
    Sleep    2
    Click Element       ${SUBMITBUTTON}
    Capture Page Screenshot     screenshot_${TEST NAME}.png
Click On The Add Language Button
    Scroll Element Into View        ${ADDYOUTUBELINKBUTTON}
    Sleep    4
    Click Element       xpath = //*[@aria-label='Add language']
Type In Language
    Input Text          ${LANGUAGESINPUT}       English
Click On The Clear Button
    Click Element       ${CLEARBUTTON}
    Capture Page Screenshot     screenshot_${TEST NAME}.png
Type In Phone
    Input Text          ${PHONEINPUT}     +380952458648
Type In Weight
    Input Text          ${WEIGHTINPUT}      82
Type In Height
    Input Text          ${HEIGHTINPUT}      181
Click On The Leg Dropdown
    Click Element       ${LEGDROPDOWN}
Click On Right Leg
    Click Element       ${RIGHTLEG}
Type In Club
    Input Text          ${CLUBINPUT}        Dinamo
Type In Level
    Input Text          ${LEVELINPUT}       Master
Click On District Button
    Click Element       ${DISTRICTDROPDOWN}
Select Opole
    Click Element       ${OPOLE}
Type In Achivements
    Input Text          ${ACHIEVEMENTSINPUT}        Golden Ball
Click On The Add Youtube Button
    Scroll Element Into View        ${ADDYOUTUBELINKBUTTON}
    Sleep    4
    Click Element       ${ADDYOUTUBELINKBUTTON}
Add Link
    Input Text          ${YOUTUBEINPUT}         https://www.youtube.com/watch?v=rPoTSLYpHWI
Assert Title Of The Page
    Sleep    5
    Title Should Be     Edit player Manuel Nuer
Assert new player in dashboard
    Click Element       ${MAINPAGE}
    Wait Until Element Is Visible    ${PAGELOGO}
    Element Text Should Be    ${LASTCREATEDPLAYER}      MANUEL NUER
    Capture Page Screenshot     screenshot_${TEST NAME}.png