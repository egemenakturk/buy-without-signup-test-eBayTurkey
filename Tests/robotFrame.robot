
*** Settings ***

Documentation                       Open Main Page
Library                             Selenium2Library
Suite Setup     run keywords
...             Go to homepage  AND
...             Disable all popups

Suite Teardown  Close All Browsers

*** Variables ***

${BROWSER}          chrome
${HOMEPAGE}         https://www.gittigidiyor.com
${MAILADRESS}       ***************@gmail.com
${NAME}             user111
${LASTNAME}         user222
${PHONE1}           ***
${PHONE2}           *******
${HOMEADRESS}       ********************************************

*** Keywords ***

Go to homepage
    open browser              ${HOMEPAGE}   ${BROWSER}

Search and click
    [Arguments]     ${searchkey}
    Input Text      id=search_word  ${searchkey}
    Click Button    header_find_button
    wait until page contains     ${searchkey}

Go to product
    Wait Until Page Contains Element    css=.image-container
    ${product_image}  Get WebElements    css=.image-container
    ${phone_name}     Get Text    css=.product-title.bold-opt
    Click Element   ${product_image[0]}
    Wait Until Page Contains    ${phone_name}

Add to basket
    Wait Until Page Contains Element     css=.product-page
    ${price}         Get Text    css=.price-css
    #${color_toggle}  Get WebElements    css=.product-page
    Click Element    css=.retail-select
    Click Element    RtImg_399077_option
    Click Button     add-to-basket
    Click Element    css=.gg-ui-button.gg-ui-btn-default.plr5
    Wait Until Page Contains    ${price}
    Click Element    css=.gg-d-24.gg-ui-btn.gg-ui-btn-blue.btn-pay
    Wait Until Page Contains    Üye olmadan devam etmek istiyorum

Disable all popups
    add cookie    SFTBA    abtfs_A150   domain=.gittigidiyor.com
    add cookie    abtest    APS3%2CHCT2%2CSBF3    domain=.gittigidiyor.com
    add cookie    wis_l_ignorelb    1   domain=.gittigidiyor.com
    add cookie    notifyer    {“notificationStatus”:“granted”}    domain=.gittigidiyor.com
    add cookie    ggPolicyBoxIsHidden    true    domain=.gittigidiyor.com
    ${All_cookies_1}  get cookies
    log  ${All_cookies_1}  console=no
    Go To    https://www.gittigidiyor.com/

Continue without sign in
    Click Button    notmember
    Input Text      id=FormLoginEmail  ${MAILADRESS}
    Click Button    loginForm
    Wait Until Page Contains    Genel Toplam

Fill areas and continue
    ${deliveryinfo}  Get WebElements    css=.gg-ui-txt.gg-input
    Input Text    ${deliveryinfo[0]}    ${NAME}
    Input Text    ${deliveryinfo[1]}    ${LASTNAME}
    Input Text    ${deliveryinfo[2]}    ${PHONE1}
    Input Text    ${deliveryinfo[3]}    ${PHONE2}
    Input Text    css=.gg-textarea.gg-ui-textarea  ${HOMEADRESS}
    Click Element     CitySelect
    Select From List  xpath=//select[@id="CitySelect"]  34
    Click Element    District
    Select From List  xpath=//select[@id="District"]    Kadıköy
    Click Button    post-address-form
    Wait Until Page Contains    Kart Numarası


*** Test Cases ***
Search keyword and check results
    Search and click       cep telefonu

Find product and check results
    Go to product

Choose color, add to basket and complete shopping
    Add to basket

Continue to buy without sign in
    Continue without sign in

Fill delivery adress info and continue
    Fill areas and continue
