
*** Settings ***

Documentation                       Open Main Page
Library                             Selenium2Library

Variables                           ../Resources/HomePage.yaml
Variables                           ../Resources/Payment.yaml
Variables                           ../Resources/ProductDetails.yaml
Variables                           ../Resources/Search.yaml
Variables                           ../Resources/ShoppingCart.yaml

Suite Setup     run keywords
...             Go to homepage  AND
...             Disable all popups

Suite Teardown  Close All Browsers

*** Variables ***

${BROWSER}          chrome
${HOMEPAGE}         https://www.gittigidiyor.com
${MAILADRESS}       akturkegemen@gmail.com
${NAME}             user111
${LASTNAME}         user222
${PHONE1}           507
${PHONE2}           7241929
${HOMEADRESS}       fahrettin kerim gökay caddesi no:145 daire:5 kat:3 kadıkoy/ıstanbul

*** Keywords ***

Go to homepage
    open browser              ${HOMEPAGE}   ${BROWSER}

Search and click
    [Arguments]     ${searchkey}
    Input Text      ${home.search_input}   ${searchkey}
    Click Button    ${home.search_button}
    wait until page contains     ${searchkey}

Go to product
    Wait Until Page Contains Element     ${SearchResult.first_product}
    ${product_image}  Get WebElements    ${SearchResult.first_product}
    ${phone_name}     Get Text    ${SearchResult.product_name}
    Click Element   ${product_image[0]}
    Wait Until Page Contains    ${phone_name}

Add to basket
    Wait Until Page Contains Element     ${ProductDtls.all_price}
    ${price}         Get Text    ${ProductDtls.all_price}
    #${color_toggle}  Get WebElements    css=.product-page
    Click Element    ${ProductDtls.variant_dropdowns}
    Click Element    RtImg_957767_option
    Click Button     ${ProductDtls.add_to_basket}
    Click Element    ${ShoppingCrt.continue_to_basket}
    Wait Until Page Contains    ${price}
    Click Element    ${ShoppingCrt.complete_shopping}
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
    Click Button    ${PaymentLogin.not_member_choice}
    Input Text      ${PaymentLogin.not_member_email}  ${MAILADRESS}
    Click Button    ${PaymentLogin.login_button}
    Wait Until Page Contains    Genel Toplam

Fill areas and continue
    ${deliveryinfo}  Get WebElements    css=.gg-ui-txt.gg-input
    Input Text    ${SelectAdress.guest_name}          ${NAME}
    Input Text    ${SelectAdress.guest_surname}       ${LASTNAME}
    Input Text    ${SelectAdress.guest_phone_area}    ${PHONE1}
    Input Text    ${SelectAdress.guest_phone}         ${PHONE2}
    Input Text    ${SelectAdress.guest_adress}  ${HOMEADRESS}
    Click Element     ${SelectAdress.guest_city}
    Select From List  ${SelectAdress.guest_city}  34
    Click Element     ${SelectAdress.guest_district}
    Select From List  ${SelectAdress.guest_district}    Kadıköy
    Click Button      ${SelectAdress.finish_fill_adress}
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
