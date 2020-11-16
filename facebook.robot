***Settings***
Library    SeleniumLibrary

***Variables***
${URL}    https://www.facebook.com
${BROWSER}    Chrome

***Test Cases***
Test search keyword and verify search result on facebook
    search URL
    search email and password
    press enter
    Check user
    Write Status
    Enter Status
    Post

***Keywords***

search URL
    ${options}=    Evaluate    sys.modules['selenium.webdriver.chrome.options'].Options()    sys
    Call Method    ${options}    add_argument    --disable-notifications
    ${driver}=     Create Webdriver    ${BROWSER}    options=${options}
    Go To   ${URL}

search email and password
    Input Text    name:email    ${email}
    Input Password    name:pass    ${password}
    
press enter
    Click Element    id:u_0_b

Check user
    Page Should Contain    Apipark Withedvorrakit

Write Status
    Click Element    xpath: //*[contains(text(), "คุณคิดอะไรอยู่ Apipark")]

Enter Status
    Wait Until Page Contains    คุณคิดอะไรอยู่ Apipark
    Press Keys    None   สวัสดี RobotFramework
    

Post
    Click Element    xpath: //div[contains(text(), "โพสต์")]
    Close Browser