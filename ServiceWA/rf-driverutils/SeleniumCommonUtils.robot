*** Settings ***
Library     String
Library    SeleniumLibrary    timeout=30
Library    OperatingSystem
Resource   ../rf-utilities/PropertyUtilities.robot
Library    Process
Library         ../rf-utilities/ExtentReportListener.py
Resource        ../rf-utilities/ExtentUtilityListener.robot
Resource        ../rf-utilities/ExtentUtilityListener.robot
Resource        ../rf-utilities/DataUtility.robot
#Resource    ../rf-PageObjectLibrary/HomeAndSignInPage.robot
Library     os
Library     Collections

*** Variables ***
${ApplimationURL}    http://liidaveqa.com
${AcceptAllCookies}     xpath=//button[contains(text(),'Accept All Cookies')]


${ContinueButton}       //[@id='continue']
${RETRY COUNT}    6x
${RETRY WAIT}     15x
#${AcceptAllCookies}     id=onetrust-accept-btn-handler
${ACCEPT_ALL_COOKIES}   //button[contains(text(), 'Accept All Cookies')]

*** Keywords ***
Launch Web Application
    [Arguments]   ${AppURL}
    ${ExecutionPlatform}=          Set Variable  %{EXECUTION_PLATFORM}
    ${URL}=     Set Variable    %{APP_URL}
    &{prop}=    Load Config Properties Data
    Set Environment Variable            EXECUTION_PLATFORM                    ${ExecutionPlatform}
    Log to Console  URL->${URL} on Browser->%{BROWSER}
    Write Extent Test Steps          Launched Web Application URL:%{APP_URL}           Pass            False
    Write Extent Test Steps          Browser : %{BROWSER}           Pass            False
#    Write Extent Test Steps     Browser : %{BROWSER}   Pass    False
    Log To Console    Browser : %{BROWSER}
    Log to console  Application URL : %{APP_URL}
#    Write Extent Test Steps          App URL : %{APP_URL}                 Pass            False
#    Write Extent Test Steps          Browser : %{BROWSER}                 Pass            False
    Open Browser  %{APP_URL}  chrome  options=add_argument("--ignore-certificate-errors")
    Maximize Browser Window
    Log to console  Maximized the Browser
    SeleniumCommonUtils.Accept Cookies

#
#Initial Test Set Up
#    [Arguments]   ${SheetName}   ${TestCaseID}  ${FunctionalityName}
#    &{TestData}=   Load Test Data From File    %{TEST_DATA_FILE}   ${SheetName}   ${TestCaseID}
#    Set Global Variable    &{TestData}
#    Log to console  Test Case Name: ${TestData.TestcaseName}
#    Log to console  Test Case ID: ${TestData.TCID}
#    Set Environment Variable    TCID    ${TestData.TCID}
#    Pass Execution If    "${TestData.Execute}" != "Y"    Test Skipped    SKIP
#    Extent TestCaseHeader                 ${TestData.TestcaseName}-${TestData.Role}        ${TestData.TCID}      ${FunctionalityName}-%{TEST_ENV}
#    SeleniumLibrary.Login to HeatCraftHub using the Role    ${TestData.Role}
#Initial Test Set Up with Filter
#    [Arguments]   ${SheetName}   ${TestCaseID}  ${FunctionalityName}
#    &{TestData}=   Load Test Data From File   %{TEST_DATA_FILE}   ${SheetName}   ${TestCaseID}
#    Set Global Variable    &{TestData}
#    Log to console  Test Case Name: ${TestData.TestcaseName}
#    Log to console  Test Case ID: ${TestData.TCID}
#    Set Environment Variable    TCID    ${TestData.TCID}
##    Pass Execution If    "${TestData.Execute}" != "Y"    Test Skipped    SKIP
#    &{Load Prop}=      Read Properties  ${PROPERTY FILE PATH}
#    Pass Execution If  "${TestData.Filter}" != "${Load Prop}[ExecutionFilter]"       Test Skipped    SKIP
#    Pass Execution If  "${TestData.Execute}" != "Y"      Test Skipped    SKIP
#    Extent TestCaseHeader                 ${TestData.TestcaseName}-${TestData.Role}        ${TestData.TCID}      ${FunctionalityName}-%{TEST_ENV}
#    Login to HeatCraftHub using the Role    ${TestData.Role}

Click Web Button
    [Documentation]    Wrapper Keyword for Click Element with Retry included
    [Arguments]    ${Element}   ${ElementName}
#    Sleep   3s
    SeleniumLibrary.Scroll Element Into View    ${Element}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Element Should Be Enabled    ${Element}
    Log To Console    WebButtonStatus:${SUCCESS STATUS}
    IF    ${SUCCESS STATUS} != True
        SeleniumLibrary.Wait Until Element Is Enabled       ${Element}
    END
    SeleniumLibrary.Click Button  ${Element}
    Log to console  ${SUCCESS STATUS}:Click Element:${ElementName}
#    IF  ${SUCCESS_FLAG} == False
#        Write Extent Test Steps     ${SUCCESS_FLAG}: Click Element:${ElementName}   Fail    True
#    ELSE
#        Write Extent Test Steps     ${SUCCESS_FLAG}: Click Element:${ElementName}   Pass    True
#    END
#    Write Extent Test Steps     ${SUCCESS STATUS}:Click Element:${ElementName}  Pass    False
#    Write Extent Test Steps        Clicked on ${ElementName}	         Pass       True
#    Log to console    ${SUCCESS STATUS}: Click Element:${ElementName}

Click Web Element
    [Documentation]    Wrapper Keyword for Click Element with Retry included
    [Arguments]    ${Element}   ${ElementName}
    ${SUCCESS_FLAG}=    Run Keyword and Return Status   SeleniumLibrary.Scroll Element Into View    ${Element}
    ${SUCCESS_FLAG}=    Run Keyword and Return Status   Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    SeleniumLibrary.Click Element    ${Element}
    Log To Console    Element:${Element} Success:${SUCCESS_FLAG}
    IF  ${SUCCESS_FLAG} == False
        Write Extent Test Steps     ${SUCCESS_FLAG}: Click Element:${ElementName}   Fail    True
    ELSE
        Write Extent Test Steps     ${SUCCESS_FLAG}: Click Element:${ElementName}   Pass    True
    END
    RETURN    ${SUCCESS_FLAG}
Click Web Element for Negative and Positive Validation
    [Documentation]    Wrapper Keyword for Click Element with Retry included
    [Arguments]    ${Element}   ${ElementName}
    ${SUCCESS_FLAG}=    Run Keyword and Return Status   SeleniumLibrary.Scroll Element Into View    ${Element}
    Write Extent Test Steps          ${SUCCESS_FLAG}: Click Element:${ElementName}   Pass    False
    ${SuccessFlag}=     Run Keyword and Return Status   Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    SeleniumLibrary.Click Element    ${Element}
    RETURN    ${SuccessFlag}

Click Web Element1
    [Documentation]    Wrapper Keyword for Click Element with Retry included
    [Arguments]    ${Element}   ${ElementName}
    SeleniumLibrary.Click Element    ${Element}
#    Sleep   3s

Send Keys
    [Documentation]    Wrapper Keyword for Click Element with Retry included
    [Arguments]    ${Element}   ${ElementText}   ${ElementName}     ${TakeScreenShot}
    Log To Console    ID: ${Element}
    Run Keyword And Return Status    SeleniumLibrary.Clear Element Text      ${Element}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Wait Until Page Contains Element    ${Element}
#    Log To Console    SendKeysStatus:${SUCCESS STATUS}
#    IF    ${SUCCESS STATUS} != True
#        Write Extent Test Steps          Failed to find Element:${ElementName}::${Element}  Fail    True
#    END

    Run Keyword And Return Status    SeleniumLibrary.Element Should Be Enabled    ${Element}
    Run Keyword And Return Status    SeleniumLibrary.Scroll Element Into View    ${Element}
    ${Success Flag}=    Run Keyword and Return Status   Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    SeleniumLibrary.Input Text    ${Element}    ${ElementText}
    Log To Console    SendKeysStatus:${Success Flag}
#   Check Status     ${Success Flag}     Entered ${ElementName} as ${ElementText}    ${TakeScreenShot}
#    Write Extent Test Steps          Entered ${ElementName} as ${ElementText}           ${Success Flag}            ${TakeScreenShot}
#    Sleep   3s
    RETURN   ${Success Flag}


#Select from Drop Down List
#    [Arguments]     ${DropDownListID}   ${ListValue}    ${ListName}
#    Log To Console    DropDownListID : ${DropDownListID}

Select Web Element
    [Documentation]    Wrapper Keyword for Click Element with Retry included
    [Arguments]    ${Element}   ${ElementName}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Wait Until Page Contains Element    ${Element}
    Log To Console    SelectWebElementStatus:${SUCCESS STATUS}
    IF    ${SUCCESS STATUS} != True
        Write Extent Test Steps          Failed to Click on WebElement : ${ElementName} :: ${Element}           Fail            True
    END
#    Wait Until Element Is Visible    ${Element}
    SeleniumLibrary.Element Should Be Enabled    ${Element}
    SeleniumLibrary.Scroll Element Into View    ${Element}
    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    SeleniumLibrary.Click Element    ${Element}
    Write Extent Test Steps          Selected ${ElementName}           Pass            True

Validate Element Visibility
    [Documentation]    Wrapper Keyword for Validate Element Visibility
    [Arguments]    ${Element}   ${ElementName}
#    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Element Should Be Visible    ${Element}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Page Should Contain Element    ${Element}
    Log To Console    ElementVisibilityStatus ${ElementName}:${SUCCESS STATUS}:${Element}
#    Check Status    ${SUCCESS STATUS}   ${ElementName}      False
    RETURN    ${SUCCESS STATUS}

Validate Element Visibility Status
    [Documentation]    Wrapper Keyword for Validate Element Visibility
    [Arguments]    ${Element}   ${ElementDescription}   ${VisibilityStatus}    ${ScreenshotFlag}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Page Should Contain Element    ${Element}
    Log To Console    ElementVisibilityStatus ${ElementDescription}:${SUCCESS STATUS}:${Element}
#    Check Status    ${SUCCESS STATUS}   ${ElementName}      False
     IF    ${SUCCESS STATUS} == ${VisibilityStatus}
        IF    ${VisibilityStatus} == True
            ${SUCCESS_FLAG}=    Run Keyword and Return Status   SeleniumLibrary.Scroll Element Into View    ${Element}
            Check Status    True      WebElement Visible: ${ElementDescription} :: ${Element}    ${ScreenshotFlag}
        ELSE
            Check Status    True      WebElement Not Visible as expected: ${ElementDescription} :: ${Element}      ${ScreenshotFlag}
       END
     ELSE
        IF    ${VisibilityStatus} == True
            Check Status    False          WebElement NOT Visible: ${ElementDescription} :: ${Element}      True
        ELSE
            Check Status    False         WebElement Visible not as expected: ${ElementDescription} :: ${Element}      True
       END
    END

Validate Element Visibility Status2
    [Documentation]    Wrapper Keyword for Validate Element Visibility
    [Arguments]    ${Element}   ${ElementDescription}   ${VisibilityStatus}    ${ScreenshotFlag}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Element Should Be Visible    ${Element}
    Log To Console    ElementVisibilityStatus ${ElementDescription}:${SUCCESS STATUS}:${Element}
#    Check Status    ${SUCCESS STATUS}   ${ElementName}      False
     IF    ${SUCCESS STATUS} == ${VisibilityStatus}
        IF    ${VisibilityStatus} == True
            Check Status    True      WebElement Visible: ${ElementDescription} :: ${Element}    ${ScreenshotFlag}
        ELSE
            Check Status    True      WebElement Not Visible as expected: ${ElementDescription} :: ${Element}      ${ScreenshotFlag}
       END
     ELSE
        IF    ${VisibilityStatus} == True
            Check Status    False          WebElement NOT Visible: ${ElementDescription} :: ${Element}      True
        ELSE
            Check Status    False         WebElement Visible not as expected: ${ElementDescription} :: ${Element}      True
       END
    END




Close TestCase
    [Documentation]    Wrapper keyword to close a testcase
#    Close Test Case
#    Sign Out From Hub
    Close Browser
    Log to console  TestCase Teardown

#    IF  '${PIPELINE_EXECUTION}' == 'false'
#        Run Process                    java                    -jar                      ${EXECDIR}/NodeExtentRunner.jar
#    END


Close Application
    [Documentation]    Wrapper keyword to close application
#    Close Application
    Close All Browsers
    Close Extent Report
    Log to console  Dir: ${EXECDIR}
    sleep               1
    ${PIPELINE_EXECUTION}       Convert To Lower Case    %{PIPELINE_EXECUTION}
    Log To Console    PipeLineExecution: ${PIPELINE_EXECUTION}
#    IF  '${PIPELINE_EXECUTION}' == 'false'
#        Run Process                    java                    -jar                      ${EXECDIR}/NodeExtentRunner.jar
#    END

#Sign Out From Hub
#    Navigate to Heatcraft Home Page
#    Accounts Menu Navigation     My Account      Sign Out
#    Log to Console  Signed out Successfully

Check Status
    [Documentation]     Checking success status
    [Arguments]     ${Status}      ${ElementDetails}    ${ScreenshotFlag}
    IF      '${Status}'=='True'
            Write Extent Test Steps          Success: ${ElementDetails}        Pass        ${ScreenshotFlag}
    ELSE
            Write Extent Test Steps          Fail: ${ElementDetails}        Fail        True
    END
Check Status with Scroll
    [Documentation]     Checking success status - Scrolling to the element to capture the exact screenshot
    [Arguments]     ${Status}      ${ElementDetails}    ${ScreenshotFlag}   ${ScrollElement}
    ${Success}=     Run Keyword and Return Status   SeleniumLibrary.scroll element into view    ${ScrollElement}
    IF      '${Status}'=='True'
            Write Extent Test Steps          Success: ${ElementDetails}        Pass        ${ScreenshotFlag}
    ELSE
            Write Extent Test Steps          Fail: ${ElementDetails}        Fail        True
    END

Wait for Element Visibility
    [Arguments]     ${Element}      ${ElementName}
     ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.wait until element is visible    ${Element}  20s
     Log To Console    Wait for Element Visibility ${ElementName}:${Element}:${SUCCESS STATUS}
#    Check Status    ${SUCCESS STATUS}   ${ElementName}      False
    RETURN   ${SUCCESS STATUS}
Wait for Element Enablement
    [Arguments]     ${Element}      ${ElementName}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.wait until element is enabled    ${Element}
    Log To Console    Wait for Element Enablement ${ElementName}:${SUCCESS STATUS}
    RETURN   ${SUCCESS STATUS}
Wait for Element to be Present in Page
    [Arguments]     ${Element}      ${ElementName}
       ${SUCCESS STATUS}=     Run Keyword And Return Status    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    SeleniumLibrary.wait until page contains element    ${Element}
    Log To Console    Wait for Element to be Present in Page ${ElementName}:${SUCCESS STATUS}
    RETURN   ${SUCCESS STATUS}
Wait for Element to be Removed from Page
    [Arguments]     ${Element}      ${ElementName}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    SeleniumLibrary.wait until page does not contain element     ${Element}
    Log To Console    Wait for Element to be Removed from Page ${ElementName}:${SUCCESS STATUS}
    RETURN   ${SUCCESS STATUS}
Mouse Over Element
    [Arguments]     ${Element}      ${ElementName}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.mouse over   ${Element}
    Log To Console    Mouse Over Element ${ElementName}:${SUCCESS STATUS}
    RETURN   ${SUCCESS STATUS}
Scroll to an Element
    [Arguments]     ${Element}      ${ElementName}
       ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.scroll element into view   ${Element}
    Log To Console    Scroll Element to View ${ElementName}:${SUCCESS STATUS}
    RETURN   ${SUCCESS STATUS}
Clear TextBox Values
    [Arguments]     ${Element}      ${ElementName}
       ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.clear element text    ${Element}
    Log To Console    Clear Element Text ${ElementName}:${SUCCESS STATUS}
    RETURN   ${SUCCESS STATUS}
Check Checkbox Selection
    [Arguments]     ${Element}      ${ElementName}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.checkbox should be selected    ${Element}
    Log To Console    Select Checkbox ${ElementName}:${SUCCESS STATUS}
#    Check Status   ${SUCCESS STATUS}     Select Checkbox ${ElementName}     False
    RETURN   ${SUCCESS STATUS}
Click an Element
    [Arguments]     ${Element}      ${ElementName}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Click Element    ${Element}
    Log To Console    click element ${ElementName}:${SUCCESS STATUS}
#    Check Status   ${SUCCESS STATUS}     Select Checkbox ${ElementName}     False
    RETURN   ${SUCCESS STATUS}

Input a Value to TextBox
    [Arguments]     ${Element}      ${Value}    ${ElementName}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Input Text  ${Element}   ${Value}
    Log To Console    Enter Text ${ElementName}:${SUCCESS STATUS}
#    Check Status   ${SUCCESS STATUS}     Select Checkbox ${ElementName}     False
    RETURN   ${SUCCESS STATUS}

JS Click Web Element with Xpath
    [Arguments]    ${XpathLocator}    ${ElementDescription}
    ${Success Flag}=    Run Keyword and Return Status   Execute JavaScript    (document.evaluate('${XpathLocator}',document.body,null,9,null).singleNodeValue.click());
#    Check Status    ${Success Flag}     ${Element}      False
#    Execute Javascript    arguments[0].click();     ARGUMENTS     ${MenuItemWithID}
##    ${element_xpath}=       Replace String      ${MenuItem}        \"  \\\"
#    Execute JavaScript  document.evaluate("${element_xpath}", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).click();
    Log to Console   JS Click Web Element with Xpath ${ElementDescription}:  ${Success Flag}
    RETURN   ${Success Flag}
JS Click Web Element with ID
    [Arguments]      ${ID}   ${ElementDescription}
    [Documentation]     Click element using javascript while passing location using id
    ${Success Flag}=    Run Keyword and Return Status   Execute JavaScript    document.getElementById("${ID}").click();
    Log to Console      JS Click Web Element with ID ${ElementDescription}:${Success Flag}:${ID}
    Write Extent Test Steps     ${Success Flag}: Click Element:${ElementDescription}   Pass    False
#   Check Status    ${Success Flag}     JS Click ${ElementDescription}      False
    RETURN   ${Success Flag}
JS Click pseudo Element with CSS path
    [Arguments]      ${css_path}   ${pseudo}    ${ElementDescription}
    #${pseudo} can be "before" or "after"
    [Documentation]     Click element using javascript while passing location using id
    #((JavascriptExecutor)driver).executeScript("document.querySelector(arguments[0],':before').click();",cssPath);
    ${Success Flag}=    Run Keyword and Return Status   Execute JavaScript    document.querySelector('${css_path}','${pseudo}').click();
    Log to Console      JS Click pseudo Element with CSS ${ElementDescription}:${Success Flag}:${css_path}
    Write Extent Test Steps     ${Success Flag}: Click Element:${ElementDescription}   Pass    False
    Check Status    ${Success Flag}     JS Click ${ElementDescription}      False
    RETURN   ${Success Flag}

Get Element Attribute from an element
    [Arguments]    ${Element}   ${Attribute}    ${ElementDescription}
    ${Value}    Set Variable   ${EMPTY}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Page Should Contain Element    ${Element}
    Log To Console    Element Present ${ElementDescription}:${SUCCESS STATUS}
    IF   ${SUCCESS STATUS} == True
           ${Value}=   SeleniumLibrary.get element attribute    ${Element}   ${Attribute}
           Log to console   Attributevalue:${Value}
    ELSE
          Check Status    ${SUCCESS STATUS}   Get Element Attribute ${Element}    True
    END
    RETURN    ${Value}

Get Element Count from an element
    [Arguments]    ${Element}      ${ElementDescription}
#    ${Count}    Set Variable   0
#    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Page Should Contain Element    ${Element}
#    Log To Console    Element Present ${ElementDescription}:${SUCCESS STATUS}
#    IF   ${SUCCESS STATUS} == True
           ${Count}=   SeleniumLibrary.get element count    ${Element}
           Log to console   Element Count:${Count}
#    ELSE
#            Log to Console   No element ${Element}  found
##          Check Status    ${SUCCESS STATUS}   Get Element Count ${Element}    True
#    END
    RETURN    ${Count}

Get Text Value from an element
    [Arguments]    ${Element}      ${ElementDescription}
    ${Value}    Set Variable   ${EMPTY}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Page Should Contain Element    ${Element}
    Log To Console    Element Present ${ElementDescription}:${SUCCESS STATUS}
    IF   ${SUCCESS STATUS} == True
            ${Value}=    SeleniumLibrary.Get Text    ${Element}
           Log to console   ${ElementDescription}:${Element}:Text:${Value}
#    ELSE
#          Check Status    ${SUCCESS STATUS}   Get Text ${ElementDescription}    True
    END
    log to console    Stripped Value: ${Value.strip()}
    RETURN    ${Value.strip()}
Press Keys to an Element
    [Arguments]     ${Element}  ${Key}    ${ElementName}
       ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Press Keys   ${Element}  ${Key}
    Log To Console    Press Keys ${ElementName}:${SUCCESS STATUS}
    RETURN   ${SUCCESS STATUS}


Get Value from an element
    [Arguments]    ${Element}      ${ElementDescription}
    ${Value}    Set Variable   ${EMPTY}
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Page Should Contain Element    ${Element}
    Log To Console    Element Present ${ElementDescription}: ${Element} :${SUCCESS STATUS}
    IF   ${SUCCESS STATUS} == True
           ${Value}=   SeleniumLibrary.get value    ${Element}
    ELSE
          Check Status  ${SUCCESS STATUS}   Get Value ${Element}    True
    END
    RETURN    ${Value}

#Scroll Loop Click
#    [Arguments]    ${locator}
#    FOR    ${index}    IN RANGE    1    10
#        Sleep    0.5s
#        ${isElementVisible} =    Run Keyword and Return Status    Click Element    ${locator}
#        Run Keyword If    '${isElementVisible}'!='True'    Wait Until Keyword Succeeds    6s    2s    Scroll To Element    ${locator}
#        Log    ${isElementVisible}
#        Exit For Loop If    '${isElementVisible}'=='True'A
#    END
#    Wait for Element Visibility    ${locator}
Validate Element is not present
    [Arguments]    ${Element}     ${ElementDescription}
    ${Status}=     Run Keyword And Return Status    SeleniumLibrary.Page Should Not Contain Element    ${Element}
    log to console    ${ElementDescription} Not Present:${Status}
    Check Status     ${Status}      ${ElementDescription} Not Present     True
    RETURN    ${Status}
Validate by using get text method
    [Arguments]    ${exp}      ${Element}     ${ElementDescription}     ${MessageDescription}
    ${actual}=     Get Text Value from an element	    ${Element}     ${ElementDescription}
    #${actual}=    SeleniumLibrary.get text     ${Element}
    ${Status}=    run keyword and return status       should be equal     ${actual}      ${exp}    ignore_case=True
    log to console    ${MessageDescription}:Actual value:${actual}::Exp value:${exp}: Staus:${Status}
    Check Status with Scroll     ${Status}      ${MessageDescription}- Expected:${exp} Actual-${actual}     True    ${Element}
    RETURN    ${Status}
Validate by using get text method with should contain
    [Arguments]    ${exp}      ${Element}     ${ElementDescription}     ${MessageDescription}
    ${actual}=     Get Text Value from an element	  ${Element}    ${ElementDescription}
    #${actual}=    SeleniumLibrary.get text     ${Element}
    log to console    Actual:${actual}
    ${Status}=    run keyword and return status       should contain        ${actual}       ${exp}      ignore_case=True
    log to console    :${MessageDescription}:Actual value:${actual}::Exp value:${exp}:Staus:${Status}
    Check Status with Scroll     ${Status}      ${MessageDescription}:Actual value:${actual}::Exp value:${exp}     True     ${Element}
    RETURN    ${Status}
Validate by using get element attribute method
    [Arguments]    ${exp}    ${Element}    ${Attribute}    ${ElementDescription}     ${MessageDescription}
    ${actual}=     Get Element Attribute from an element	    ${Element}     ${Attribute}    ${ElementDescription}
    #${actual}=    SeleniumLibrary.get element attribute     ${Element}     ${Attribute}
    ${Status}=    run keyword and return status       should be equal        ${actual}       ${exp}
     log to console    :${MessageDescription}:Actual value:${actual}::Exp value:${exp}:Staus:${Status}
    Check Status with Scroll     ${Status}      ${MessageDescription}:Actual value:${actual}::Exp value:${exp}     True     ${Element}
    RETURN    ${Status}
Validate by using get element attribute method with should contain
    [Arguments]    ${exp}    ${Element}    ${Attribute}    ${ElementDescription}     ${MessageDescription}
    ${actual}=     Get Element Attribute from an element	    ${Element}     ${Attribute}    ${ElementDescription}
    #${actual}=    SeleniumLibrary.get element attribute     ${Element}     ${Attribute}
    ${Status}=    run keyword and return status       should contain        ${actual}       ${exp}
     log to console    :${MessageDescription}:Actual value:${actual}::Exp value:${exp}:Staus:${Status}
    Check Status with Scroll     ${Status}      ${MessageDescription}:Actual value:${actual}::Exp value:${exp}     True     ${Element}
     RETURN    ${Status}

Validate by using get element attribute method with should not contain
    [Arguments]    ${exp}    ${Element}    ${Attribute}    ${ElementDescription}     ${MessageDescription}
    ${actual}=     Get Element Attribute from an element	    ${Element}     ${Attribute}    ${ElementDescription}
    #${actual}=    SeleniumLibrary.get element attribute     ${Element}     ${Attribute}
    ${Status}=    run keyword and return status       should not contain        ${actual}       ${exp}
     log to console    :${MessageDescription}:Actual value:${actual}::Exp value:${exp}:Staus:${Status}
    Check Status with Scroll     ${Status}      ${MessageDescription}: Value not to be present:${exp}     True     ${Element}
     RETURN    ${Status}

Validate by using get value method
    [Arguments]    ${exp}      ${Element}     ${ElementDescription}     ${MessageDescription}
    ${actual}=    Get Value from an element	    ${Element}     ${ElementDescription}
    #${actual}=    SeleniumLibrary.get value     ${Element}
    ${Status}=    run keyword and return status       should be equal        ${actual}       ${exp}
     log to console    :${MessageDescription}:Actual value:${actual}::Exp value:${exp}:Staus:${Status}
    Check Status with Scroll     ${Status}      ${MessageDescription}:Actual value:${actual}::Exp value:${exp}     True     ${Element}
     RETURN    ${Status}

Validate by using get value method should not be equal
    [Arguments]    ${exp}      ${Element}     ${ElementDescription}     ${MessageDescription}
    ${actual}=    Get Value from an element	    ${Element}     ${ElementDescription}
    #${actual}=    SeleniumLibrary.get value     ${Element}
    ${Status}=    run keyword and return status       should not be equal        ${actual}       ${exp}
     log to console    :${MessageDescription}:Actual value:${actual}::Exp value:${exp}:Staus:${Status}
    Check Status with Scroll     ${Status}      ${MessageDescription}:Actual value:${actual}::Exp value:${exp}     True     ${Element}
     RETURN    ${Status}
Validate by using get text method with should not be empty
    [Arguments]    ${Element}     ${ElementDescription}     ${MessageDescription}
    ${actual}=     Get Text Value from an element	    ${Element}     ${ElementDescription}
    #${actual}=    SeleniumLibrary.get text     ${Element}
    ${Status}=    run keyword and return status      should not be empty        ${actual}
    log to console    :${MessageDescription}:Actual value:${actual}::Exp value:Should not be empty:Staus:${Status}
    Check Status with Scroll     ${Status}      ${MessageDescription}:Actual value:${actual}::Exp value:Should not be empty    True     ${Element}
    RETURN    ${Status}

Validate by using get value method with should not be empty
    [Arguments]    ${Element}     ${ElementDescription}     ${MessageDescription}
    ${actual}=     Get Value from an element	    ${Element}     ${ElementDescription}
    #${actual}=    SeleniumLibrary.get text     ${Element}
    ${Status}=    run keyword and return status      should not be empty        ${actual}
    log to console    :${MessageDescription}:Actual value:${actual}::Exp value:Should not be empty:Staus:${Status}
    Check Status with Scroll     ${Status}      ${MessageDescription}:Actual value:${actual}::Exp value:Should not be empty    True     ${Element}
    RETURN    ${Status}

Accept Cookies
    [Documentation]    Wrapper keyword to Accept Cookies
    Log to Console  Inside Selenium-Common Accept Cookies
    SeleniumLibrary.Wait Until Element Is Visible    //button[contains(.,'Accept Cookies')]
    Click Web Button        //button[contains(.,'Accept Cookies')]      Accept Cookies
    Write Extent Test Steps          Clicked on Accept Cookies           Pass            True


Convert Currency To Number
    [Documentation]    Keyword to convert currency to number
    ...    Input format - $n,nnn,nnn
    ...    Output format - nnnnnnn
    [Arguments]    ${Currency Value}
    ${Number Value}    Remove String    ${Currency Value}    $    ,    ${SPACE}
    ${Number Value}    Convert To Number    ${Number Value}
    RETURN    ${Number Value}


Wait For Element Present
    [Documentation]    Wrapper Keyword for to validate the given element is present
    [Arguments]    ${Element}
    SeleniumLibrary.Wait Until Page Contains Element    ${Element}
    SeleniumLibrary.Wait Until Element Is Visible    ${Element}
    SeleniumLibrary.Element Should Be Enabled    ${Element}


Validate the text in the alert window
    [Arguments]     ${Text}
    SeleniumLibrary.Wait Until Page Contains     ${Text}
    Log To Console  Validated the text '${Text}' in popup

Get The Count Of Given Webelement List
    [Documentation]  Wrapper keyword to get the count of the given webelement list
    [Arguments]  ${Element}
    @{list_element}=   SeleniumLibrary.Get Webelements    ${Element}
    ${count}=   Get length    ${list_element}
    RETURN    ${count}

Wait For Element Not Present
    [Documentation]    Wrapper Keyword for to validate the given element is not present
    [Arguments]    ${Element}
    SeleniumLibrary.Wait Until Page Does Not Contain Element    ${Element}


Convert Two List Into Dictionary
    [Documentation]  keyword wrapper to convert the two list into dictionary
    [Arguments]     ${LIST1}       ${LIST2}
    &{Dict Data}    Create Dictionary
    log to console      *********************************************************************************
    FOR    ${key}    ${value}    IN ZIP    ${LIST1}    ${LIST2}
#      Set To Dictionary  ${Dict Data}  ${LIST1}  ${LIST2}
#      Log to console  Values ${Dict Data} --> ${LIST1} -- ${LIST2}

        Set To Dictionary  ${Dict Data}   ${Key}   ${Value}
        Log to console  ${Dict Data} -->  ${Key} -- ${Value}

        log to console      =============================================================================
    END
#    Log to console  Keys: ${Key}
#    Log to console  Values: ${Value}
#    Log to Console      Value1:${Dict Data.'Unit Install Date'}
    log to console      *********************************************************************************
    RETURN  &{Dict Data}

Write Test Details
    [Arguments]     ${TestCaseId}      ${TestCaseHeader}    ${Execute}  ${TestCaseTag}
    Log to console  Test Case Name: ${TestCaseHeader}
    Log to console  Test Case ID: ${TestCaseId}
    Set Environment Variable    TCID    ${TestCaseId}
    Pass Execution If    "${Execute}" != "Y"    Test Skipped    SKIP
    Extent TestCaseHeader                 ${TestCaseHeader}          ${TestCaseId}      ${TestCaseTag}

Upload File
    [Arguments]     ${UploadButton}     ${FileName}
    ${UploadPath}   Set Variable    ${CURDIR}\\..\\rf-data\\file-upload\\${FileName}
    Log to Console      FilePath:${CURDIR}
    Log to Console      FilePath:${UploadPath}
    ${Success}=     Run Keyword and Return Status   Choose File     ${UploadButton}     ${UploadPath}
    Log to Console      UploadFile:${Success}
    sleep    2s
    RETURN    ${Success}

Wait for Spinner To be Removed
#    ${Spinner}  Set Variable   //div[@class='spinner']
    [Arguments]     ${Spinner}   ${SpinnerName}
#    ${SuccessFlag}=     Run Keyword and Return Status   Wait Until Keyword Succeeds  ${RETRY COUNT}  ${RETRY WAIT}    Wait for Element to be Removed from Page   ${Spinner}  Spinner
    ${SuccessFlag}=     Wait for Element to be Removed from Page   ${Spinner}  Spinner
    RETURN  ${SuccessFlag}

Validate Values in a DropDown
    [Arguments]     ${DropDownValuesLocator}   ${Desc}      @{ExpectedDropDownValues}
    ${ActualDropDownValues} =     Get List from Set of Options    ${DropDownValuesLocator}      ${Desc}
    ${Status}=  Compare Two List    ${Desc}   ${ExpectedDropDownValues}   ${ActualDropDownValues}
    Check Status    ${Status}   ${Desc}-${ExpectedDropDownValues}   True

Validate Given Value Present in a DropDown
    [Arguments]     ${DropDownValuesLocator}   ${ExpectedValue}     ${Description}
    @{ActualDropDownValues}=     Get List from Set of Options    ${DropDownValuesLocator}      ${Description}
    Log to console  Drodown value list:@{ActualDropDownValues}
    Log to console  Drodown value:${ActualDropDownValues}[0]
    ${Status}=    run keyword and return status     Should Contain    ${ActualDropDownValues}[0]   ${ExpectedValue}
    Log to console  Status:${Status}
    Check Status    ${Status}   ${Description}-${ExpectedValue}   True

Validate the presence of given value in a DropDown
    [Arguments]     ${DropDownValuesLocator}   ${ExpectedValue}     ${PresentStatus}     ${Description}
    @{ActualDropDownValues}=     Get List from Set of Options    ${DropDownValuesLocator}      ${Description}
    Log to console  Drodown value list:@{ActualDropDownValues}
    Log to console  Expected value:${ExpectedValue}

    IF    ${PresentStatus} == True
        ${Status}=    run keyword and return status     List Should Contain Value    ${ActualDropDownValues}    ${ExpectedValue}
        ${msg}=     Set Variable    "Should present"
    ELSE
        ${Status}=    run keyword and return status     List Should Not Contain Value    ${ActualDropDownValues}    ${ExpectedValue}
        ${msg}=     Set Variable    "Should not present"
    END
    Log to console  Status:${Status} ${msg}
    Check Status    ${Status}   ${Description}-${ExpectedValue}-${msg}  True

Validate Given list of values equals to Dropdown values
    [Arguments]     ${DropDownValuesLocator}   ${ExpectedValue}     ${Description}
    @{ActualDropDownValues}=     Get List from Set of Options    ${DropDownValuesLocator}      ${Description}
    Log to console  Drodown value list:@{ActualDropDownValues}
    ${Status}=    run keyword and return status     Lists Should Be Equal    ${ActualDropDownValues}[0]   ${ExpectedValue}
    Log to console  Status:${Status}
    Check Status    ${Status}   ${Description}-${ExpectedValue}   True
Get List from Set of Options
    [Arguments]     ${Options}      ${Desc}
    ${ListCount}=    Get The Count Of Given Webelement List  ${Options}
    Log to Console   Count of ${Desc} Options :${ListCount}
    @{SelectedList}     Create List
    FOR   ${Counter}    IN RANGE    1   ${ListCount+1}
        ${OpenBrace}  Set Variable    [
        ${ClosingBrace}     Set Variable    ]
        ${SelectedListValue}    Set Variable    ${Options}${OpenBrace}${Counter}${ClosingBrace}
        ${Value}=    Get Text Value from an element     ${SelectedListValue}    ${Desc}:${Counter}Value
        Log to Console      locator:${SelectedListValue}:value:${Value}
        Append To List    ${SelectedList}    ${Value.strip()}
    END
    Log to Console  Selected List:@{SelectedList}
    RETURN    @{SelectedList}

Get List from Set of Options with Text
    [Arguments]     ${Options}      ${Desc}
#    ${QuickLinksMenu}    Set Variable    //section[@id='quickLinksSection']//ul/li
    ${ListCount}=    Get The Count Of Given Webelement List  ${Options}
    Log to Console   Count of ${Desc} Options :${ListCount}
    @{SelectedList}     Create List
    FOR   ${Counter}    IN RANGE    1   ${ListCount+1}
        ${OpenBrace}  Set Variable    [
        ${ClosingBrace}     Set Variable    ]
        ${SelectedListValue}    Set Variable    ${Options}${OpenBrace}${Counter}${ClosingBrace}
        ${Value}=    Get Text Value from an element     ${SelectedListValue}    ${Desc}:${Counter} Value
        Log to Console      locator:${SelectedListValue}:value:${Value}
        Append To List    ${SelectedList}    ${Value.strip()}
    END
    Log to Console  Selected List:@{SelectedList}
    RETURN    @{SelectedList}

Compare Two List
    [Arguments]     ${Desc}   ${ExpList}   ${ActList}
    log to console     Inside CompareTwoList,actList-${ActList}
    log to console     Inside CompareTwoList,expList-${ExpList}
    Sort List   ${ExpList}
    Sort List   ${ActList}
     log to console     Sorted actList - ${ActList}
    log to console     Sorted expList - ${ExpList}
    ${Status}=    run keyword and return status       Lists Should Be Equal        ${ExpList}       ${ActList}
    log to console   Compare ${Desc} : ${Status}
#    Check Status     ${Status}     ${Desc}:${ExpList}    True
    RETURN    ${Status}

Wait for Spinner to be Removed with high Waits
    ${Spinner}  Set Variable    //div[@class='spinner']
    ${RETRY_COUNT}   Set Variable   6x
    ${RETRY_WAIT}     Set Variable  20s
    sleep   15s
    ${SUCCESS_FLAG}=    Run Keyword and Return Status   Wait Until Keyword Succeeds    ${RETRY_COUNT}    ${RETRY_WAIT}    SeleniumLibrary.wait until page does not contain element    ${Spinner}
    IF   ${SUCCESS_FLAG} == False
        sleep  15s
        ${SUCCESS_FLAG}=    Run Keyword and Return Status   Wait Until Keyword Succeeds    ${RETRY_COUNT}    ${RETRY_WAIT}    SeleniumLibrary.wait until page does not contain element    ${Spinner}
    END
    RETURN   ${SUCCESS_FLAG}
Validate Element Checked Status using JS
    [Arguments]      ${ID}      ${Desc}
    ${Status}=  SeleniumLibrary.execute javascript      window.document.getElementById("${ID}").checked;
    Log to Console  ${Desc} Checked:${Status}
    RETURN   ${Status}
JS Scroll By ID
    [Arguments]      ${ID}
    ${Success}=     Run Keyword and Return Status      SeleniumLibrary.execute javascript      window.document.getElementById("${ID}").scrollIntoView(true);
    RETURN    ${Success}

JS Vertical Scroll
    [Arguments]      ${X}   ${Y}
    ${Success}=     Run Keyword and Return Status      SeleniumLibrary.execute javascript      window.scrollTo(${X},${Y});
    RETURN    ${Success}

Validate Non Visibility of Element
    [Documentation]    Wrapper Keyword for Check Visibility of Element
    [Arguments]    ${Element}   ${ElementName}
#    ${SUCCESS STATUS}  Convert to Boolean   True
    ${SUCCESS STATUS}=     Run Keyword And Return Status    SeleniumLibrary.Wait until element is Visible   ${Element}
    IF  ${SUCCESS STATUS} == False
        ${SUCCESS STATUS}  Convert to Boolean   True
    ELSE
        ${SUCCESS STATUS}  Convert to Boolean   False
    END
    Log To Console    Non Visibility of Element ${ElementName}:${SUCCESS STATUS}:${Element}
    Check Status    ${SUCCESS STATUS}   ${ElementName}      True
    RETURN    ${SUCCESS STATUS}

Validate element is disabled
     [Arguments]    ${Element}     ${ElementDescription}
    ${Status}=     Run Keyword And Return Status    SeleniumLibrary.Element should be disabled    ${Element}
    log to console    ${ElementDescription} Disabled:${Status}
    Check Status     ${Status}      ${ElementDescription} Disabled     True
    RETURN    ${Status}

Launch Application for Download options
    [Documentation]     verifies user can successfully download a file
    [Tags]  Smoke
    &{prop}=    Load Config Properties Data
    Log To Console    "Browser : %{BROWSER}"
    Log to console  Application URL is %{APP_URL}
    Log to console  Test Type is %{TEST_TYPE}
    # create unique folder
    ${now}    Get Time    epoch
    ${download directory}    Join Path    ${OUTPUT DIR}    downloads
    Log to Console  OUTPUTDIR:${OUTPUT DIR}
    Log to Console  downloaddirectory:${download directory}
    Create Directory    ${download directory}
    ${chrome options}=  Evaluate   sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    ${prefs}  Create Dictionary
    ...   download.default_directory=${download directory}
    Set Global Variable     ${download directory}
    ${Initial-Files-Count}=     Get Count of Files in Directory
    Set Global Variable      ${Initial-Files-Count}
    Call Method    ${chrome options}   add_experimental_option   prefs   ${prefs}
    Create Webdriver    Chrome  chrome_options=${chrome options}
    Goto    %{APP_URL}
    Maximize Browser Window
    Log to console  Maximized the Browser

Launch Application for Quotes template
    [Documentation]     verifies user can successfully download a file
    [Tags]  Smoke
    &{prop}=    PropertyUtilities.Load Config Properties Data
    Log To Console    "Browser : %{BROWSER}"
    Log to console  Application URL is %{APP_URL}
    Log To Console  Test Type is:  %{TEST_TYPE}
    Open Browser  %{APP_URL}  %{BROWSER}  options=add_argument("--ignore-certificate-errors")
    Maximize Browser Window
    Log to console  Maximized the Browser

Verify PDF format Download
#    [Arguments]         ${directory}
    sleep   6s
    ${directory}       Set Variable    ${download directory}
    ${files}    List Files In Directory    ${directory}
    Log to Console    Files in directory:${directory}:${files}
    ${SuccessFlag}=     Run Keyword and Return status   Length Should Be    ${files}    1
    Log to Console     Verify PDF format Download: ${SuccessFlag}
    Check Status    ${SuccessFlag}     Verify PDF format Download:${files}   True

Verify PDF format Download with multiple files
#    [Arguments]         ${directory}
#    [Arguments]     ${filename}
     sleep   6s
     ${directory}       Set Variable    ${download directory}
    ${files}    List Files In Directory    ${directory}
    Log to Console    Files in directory:${directory}:${files}
    Log to Console   InitialCount of Files:${Initial-Files-Count}

     ${current-files-count}=       Get Count of Files in Directory
     Log to Console   Current count of Files:${current-files-count}
     ${new-files-count}=    Evaluate   ${current-files-count} - ${Initial-Files-Count}
     Log to Console   Added count of Files:${new-files-count}
      ${SuccessFlag}=   Run Keyword and Return Status   Should Be Equal As Numbers    ${new-files-count}    1
      ${Initial-Files-Count}=    Evaluate    ${Initial-Files-Count} + 1
      Log to Console   No:of files now:${Initial-Files-Count}
      Set Global Variable    ${Initial-Files-Count}

      ${lastModifiedFile} =   Get From List   ${files}    0
      ${time1}=  OperatingSystem.Get Modified Time       ${directory}//${lastModifiedFile}    epoch
        FOR    ${file}    IN    @{files}
            ${time}    Get Modified Time   ${directory}//${file}    epoch
             ${lastModifiedFile}    Set Variable If    ${time1} < ${time}    ${file}    ${lastModifiedfile}
             ${time1}    Set Variable If    ${time1} < ${time}    ${time}    ${time1}
        END


#    ${SuccessFlag}=     Run Keyword and Return status   Length Should Be    ${files}    1
    Log to Console     Verify PDF format Download: ${SuccessFlag}
    Check Status    ${SuccessFlag}     Verify PDF format Download:${files}   True
    ${fileSize}=    Get File Size   ${download directory}//${lastModifiedFile}
    Log to Console      File size ${fileSize}
    IF    ${fileSize} > 0
        Check Status    True     Verify PDF format Download Size:${fileSize}   True
    ELSE
         Check Status    False    Verify PDF format Download Size:${fileSize}   True
    END
    RETURN    ${SuccessFlag}

Get Count of Files in Directory
    ${directory}       Set Variable    ${download directory}
    ${files}    List Files In Directory    ${directory}
    ${count-files}=     Get Length    ${files}
    Log to Console    Files in directory:${directory}:${files}:${count-files}

    RETURN   ${count-files}

Compare Two Dictionaries
    [Arguments]     ${Desc}     ${ExpectedDictionary}      ${ActualDictionary}
    @{Keys}=    Get Dictionary Keys     ${ExpectedDictionary}
    Log to Console      Keys:${Keys}
    FOR   ${Header}  IN    @{Keys}
        ${Status}=  Run Keyword and Return Status   Should Be Equal As Strings  ${ExpectedDictionary.${Header}}      ${ActualDictionary.${Header}}
        Check Status    ${Status}   ${Header}:ExpValue-${ExpectedDictionary.${Header}} ActValue-${ActualDictionary.${Header}}   True
    END

Close Application for Download options
    [Documentation]    Wrapper keyword to close application
    Close All Browsers
    ${directory}       Set Variable    ${download directory}
#   ${directory}   Set Variable    ${CURDIR}\\..\\ExtentUtilities\\RobotReports\\downloads
#   Remove Directory    ${CURDIR}\\..\\ExtentUtilities\\RobotLogs\\downloads   recursive=true
    Remove Directory   ${directory}    recursive=true
    Close Extent Report
    Log to console  Dir: ${EXECDIR}
    sleep   1s
    ${PIPELINE_EXECUTION}       Convert To Lower Case    %{PIPELINE_EXECUTION}
    Log To Console    PipeLineExecution: ${PIPELINE_EXECUTION}

Select The Given Option From the UnOrderedList
    [Arguments]    ${DropdownElement}   ${ElementDescription}   ${ULElement}    ${ValueToBeSelected}
    #Scroll to an element   ${ScrollToElement}   ${ElementDescription}
    ${StatusForClick}=    run keyword and return status    Click an Element    ${DropdownElement}       ${ElementDescription}
    sleep    4s
    ${ULElementlocator}=   catenate    ${ULElement}/li[contains(text(),'${ValueToBeSelected}')]
    log to console    ulelement:${ULElementlocator}
    ${StatusForClick}=    run keyword and return status    Click an Element    ${ULElementlocator}       ${ElementDescription}
    Check Status    ${StatusForClick}    ${ElementDescription}    False
    sleep   5s
    ${SelectStatus}=    Validate by using get text method     ${ValueToBeSelected}     ${DropdownElement}     ${ElementDescription}     ${ElementDescription}:${ValueToBeSelected}
    log to console    Select ${ElementDescription}:${SelectStatus}
    Check Status     ${SelectStatus}      '${ElementDescription}' selected as ${ValueToBeSelected}    True
Select The Given Option From the UnOrderedList with li element
    [Arguments]    ${DropdownElement}   ${ElementDescription}   ${ULElement}    ${ValueToBeSelected}
    #Scroll to an element   ${ScrollToElement}   ${ElementDescription}
    ${StatusForClick}=    run keyword and return status    Click an Element    ${DropdownElement}       ${ElementDescription}
    sleep    4s
    #${ULElementlocator}=   catenate    ${ULElement}/li[text()='${ValueToBeSelected}']
    log to console    ulelement:${ULElement}
    ${StatusForClick}=    run keyword and return status    Click an Element    ${ULElement}       ${ElementDescription}
    Check Status    ${StatusForClick}    ${ElementDescription}    False

Compare two list of Dictionary
    [Arguments]    ${ExpectedList}    ${ActualList}
    FOR     ${Exp_Dict_data}   ${Actual_Dict_data}    IN    @{ExpectedList}    @{ActualList}
        ${status}=      run keyword and return status    dictionaries should be equal     ${Exp_Dict_data}    ${Actual_Dict_data}
        log to console    dictionary status:${status}-Exp:${Exp_Dict_data}-Act:${Actual_Dict_data}
        Check Status    ${status}   Expected:${Exp_Dict_data} Actual:${Actual_Dict_data}     True
    END
Validate the given webelement list in expected size
    [Arguments]    ${webElementList}    ${expectedSize}     ${ElementDescription}
    ${Status}=   run keyword and return status       SeleniumLibrary.page should contain element     ${webElementList}   limit=${expectedSize}
    log to console    ${Status}
    Check Status    ${Status}    ${ElementDescription} ExpectedSize:${expectedSize}   False

Enter a value in DropDown
    [Arguments]     ${DropDown}     ${DropDownValueField}   ${Desc}     ${Value}
    Click an Element    ${DropDown}     ${Desc}-DropDown
    ${Status}=      Click an Element    ${DropDownValueField}   ${Desc}-DropDownValue-${Value}
    Check Status    ${Status}   ${Desc}-DropDownValue-${Value}    True
    sleep  2s

Upload a File with Button
    [Arguments]     ${Button}   ${FileName}
#    ${AttachmentButton}     Set Variable       //button[@id='btnAddDocument']/i
    ${UploadPath}   Set Variable    ${CURDIR}\\..\\rf-data\\file-upload\\${FileName}
#    Select From List By Value       adjustmentReason_inovoice_0_lineitem_0     Invoice not to PO
#    sleep    3s

    Click Web Element   ${Button}     AttachmentButton
#    Press Special Key   ESC

    ${InputUploadButton}    Set Variable    //input[@type='file']
    ${Counter}=     Get The Count Of Given Webelement List  ${InputUploadButton}
    Log to Console      InputFileCounter: ${Counter}
    ${NORMAL_PATH_UPLOAD_FILE_NAME}    Normalize Path      ${UploadPath}
    FOR   ${X}  IN RANGE   1    ${Counter+1}
        ${Status}=  Run Keyword and Return Status   Choose File     (//input[@type='file'])[${X}]     ${NORMAL_PATH_UPLOAD_FILE_NAME}
        IF  ${Status}==True
            Log to Console    Upload successful
            ${X}    Evaluate   ${Counter}+1
        END
        Log to Console   FileUpload${X}
    END
    sleep  4s
#    Press Special Key   ESC
    Check Status    ${Status}    Trying to Upload Attachment-${FileName}     True

Test Initialization
    [Arguments]    ${SheetName}     ${TCID}     ${FeatureName}
    &{TestData}=   Load Test Data From File   TestData.xlsx   ${SheetName}   ${TCID}
    #Log to console  Test Case Name: ${TestData.TestcaseName}
    #Log to console  Test Case ID: ${TestData.TCID}
    Set Environment Variable    TCID    ${TestData.TCID}
    Pass Execution If    "${TestData.Execute}" != "Y"    Test Skipped    SKIP
    Extent TestCaseHeader       ${TestData.TestcaseName}        ${TestData.TCID}      ${FeatureName}
    RETURN      &{TestData}


Refresh Page
    Execute Javascript    window.location.reload(true);

Date Diff
	[Arguments]		${DueDate}	${ReceiveDate}
	${DateFormat}	Set Variable	%m-%d-%Y %I:%M:%S %p
	${epoch_r}= 	Evaluate    datetime.datetime.strptime("${ReceiveDate}", "${DateFormat}").timestamp()		modules=datetime
	${epoch_d}= 	Evaluate    datetime.datetime.strptime("${DueDate}", "${DateFormat}").timestamp()		modules=datetime
	${difference}=	Evaluate	${epoch_d} - ${epoch_r}
	RETURN  ${difference}


DownLoad File format
    [Arguments]         ${directory}    ${file_format}   
    Sleep  60s
    ${files}    List Files In Directory    ${directory}     ${file_format}
     Log to Console     FilePathexpath:${directory}
     Log to Console   Files:${files}
    ${file-count} =     Get Length    ${files}
    ${file_status} =    run keyword and return status      Should Be True     ${file-count} >= 1
    RETURN   ${file_status}


Upload File Place Order
    [Arguments]     ${UploadButton}     ${FileName}
    ${p2} =     Join Path     ${CURDIR}/../rf-data/file-upload/${FileName}
    ${UploadPath}   Set Variable   ${p2}
    Log to Console      FilePathexpath:${CURDIR}
    Log to Console      FilePath:${UploadPath}
    ${Success}=     Run Keyword and Return Status   Choose File     ${UploadButton}     ${UploadPath}
    Log to Console      UploadFile:${Success}
    sleep    2s
    RETURN    ${Success}

Enter Date
    [Arguments]     ${DateField}    ${Date}    ${OutsideElement}    ${Desc}
    Log to Console   Inside Enter Date,${Date}
    ${DateSplit}=    Split String    ${Date.strip()}    \/
    ${dd}=      Set Variable    ${DateSplit}[0]
    ${mm}=  Set Variable    ${DateSplit}[1]
    ${yyyy}=    Set Variable    ${DateSplit}[2]
    ${ModifiedDate}=    Set Variable    ${dd}\/${mm}\/${yyyy}
    Log to Console   Date to be entered:${ModifiedDate}:
    Click an Element    ${DateField}    ${Desc}
    Press Keys to an Element      ${DateField}    ${EMPTY}     ENTER
    Run Keyword And Return Status    SeleniumLibrary.Clear Element Text      ${DateField}
    ${Status}=  Run Keyword and Return status   Press Keys to an Element      ${DateField}    ${ModifiedDate}     Date
    Press Keys to an Element      ${DateField}    ${EMPTY}     ENTER
    Click an Element    ${OutsideElement}     OutsideElement
    Check Status   ${Status}    Entered ${Desc}     False

Validate the given two text are same
    [Arguments]    ${expected}      ${actual}   ${textDescription}
    ${Status}=  Run Keyword and Return Status   Should Be Equal As Strings      ${expected}     ${actual}
    Check Status    ${Status}    Expected ${textDescription}:${expected} Actual ${textDescription}:${actual}      True

Refresh Page Until Page Contains Element
    [Arguments]  ${Element}
#    Reload Page
#    Wait for Spinner To be Removed
    ${Reload}=  Run Keyword And Return Status  SeleniumLibrary.Page Should Contain Element  ${Element}
    FOR  ${cntr}   IN RANGE  0  15
        IF    ${Reload} != ${TRUE}
            Reload Page
            Wait for Spinner To be Removed
            sleep  1s
            ${Reload}=  Run Keyword And Return Status  SeleniumLibrary.Page Should Contain Element  ${Element}
        END
    END

Validate Column Name and Column Value
    [Arguments]     ${ExpColumnName}     ${ColumnHeaderLocator}  ${ExpColumnValue}     ${ColumnValueLocator}
    sleep    1s
    Wait for Element Visibility     ${ColumnHeaderLocator}        ${ColumnHeaderLocator}
    ${ActColumnName}=    SeleniumLibrary.get text     ${ColumnHeaderLocator}
    ${ActColumnValue}=    SeleniumLibrary.get text     ${ColumnValueLocator}
    ${Status}=    run keyword and return status    should be equal    ${ActColumnName}   ${ExpColumnName}
    log to console     ActColumnName:${ActColumnName}:ExpColumnName:${ExpColumnName}:${Status}
    Check Status     ${Status}     Validate Column Name ${ExpColumnName}     True
    ${Status1}=    run keyword and return status    should be equal    ${ActColumnValue}       ${ExpColumnValue}
     log to console     ActColumnValue:${ActColumnValue}:ExpColumnValue:${ExpColumnValue}:${Status1}
    Check Status     ${Status1}      Validate Column Value ${ExpColumnValue}      True

Get CSS Property Value
    [Documentation]
    ...    Get the CSS property value of an Element.
    ...
    ...    This keyword retrieves the CSS property value of an element. The element
    ...    is retrieved using the locator.
    ...
    ...    Arguments:
    ...    - locator           (string)    any Selenium Library supported locator xpath/css/id etc.
    ...    - property_name     (string)    the name of the css property for which the value is returned.
    ...
    ...    Returns             (string)    returns the string value of the given css attribute or fails.
    ...
    [Arguments]    ${locator}    ${attribute name}
    ${css}=         SeleniumLibrary.Get WebElement    ${locator}
    ${prop_val}=    Call Method       ${css}    value_of_css_property    ${attribute name}
    RETURN     ${prop_val}
