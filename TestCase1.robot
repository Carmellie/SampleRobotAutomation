*** Settings ***
Library  SeleniumLibrary
Library  Library/CustomLibrary1.py

Suite Setup     Open Browser  about:blank  ${BROWSER}   C:\SleekFlow\GetIphone13Report\webdriver\chromedriver.exe   # Replace ${BROWSER} with the browser of your choice
Suite Teardown  Close All Browsers

*** Variables ***
${LZ_URL}  https://www.lazada.com.my/tag/iphone-13/?_keyori=ss&catalog_redirect_tag=true&from=search_history&page=1&q=iphone%2013&sort=priceasc&spm=a2o4k.home-my.search.1.75f84065IesS6q&style=list&sugg=iphone%2013_0_1
${SP_URL}  https://shopee.com.my/search?keyword=iphone%2013&order=asc&page=0&sortBy=price
${MR_URL}  https://www.mudah.my/malaysia/all?q=iphone%2013&sortby=price_asc
${BROWSER}      chrome

*** Test Cases ***
Verify Data
    Test LAZADA
    Test MURAH
    

*** Keywords ***
Test LAZADA   
    Open Browser  ${LZ_URL}  ${BROWSER}
    ${productdiv}=  Set Variable   //div[@data-qa-locator="product-item"]
    ${count} =	Get Element Count	xpath=${productdiv}
    FOR     ${i}    IN RANGE   1   ${count+1}
        ${price}=    Get Text    xpath=//div[@data-qa-locator="product-item"][${i}]//span[@class="ooOxS"]
        ${name}=    Get Text    xpath=//div[@data-qa-locator="product-item"][${i}]//div[@class="POgr1"]/a 
        ${url}=    Get Element Attribute    xpath=//div[@data-qa-locator="product-item"][${i}]//div[@class="POgr1"]/a     href
        Log         LAZADA
        Log         ${url}
        Log         ${price} 
        Log         ${name}
        ${status}=  compare_string_has  ${name}     iphone13    iphone 13                 
        Run Keyword And Ignore Error    Should be equal    ${status}    PASS    contains string iphone13 or iphone 13
    END    
    Close Browser

   
Test MURAH    
    Open Browser  ${MR_URL}  ${BROWSER}
    Sleep   5s
    ${productdiv}=  Set Variable   //div[contains(@data-testid,"listing-ad-item-")]
    ${count} =	Get Element Count	xpath=${productdiv}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    FOR     ${i}    IN RANGE   1   ${count+1}
        ${price}=    Get Element Attribute    xpath=(//div[contains(@data-testid,"listing-ad-item-")]//*[contains(text(),"RM")])[${i}]     innerText
        ${name}=    Get Element Attribute     xpath=(//div[contains(@data-testid,"listing-ad-item-")]//a)[${i}*2]     title
        ${url}=    Get Element Attribute    xpath=(//div[contains(@data-testid,"listing-ad-item-")]//a)[${i}*2]     href
        Log         MURAH
        Log         ${url}
        Log         ${price}
        Log         ${name}
        ${status}=  compare_string_has  ${name}     iphone13    iphone 13      
        Run Keyword And Ignore Error    Should be equal    ${status}    PASS     contains string iphone13 or iphone 13
    END    
    Close Browser
