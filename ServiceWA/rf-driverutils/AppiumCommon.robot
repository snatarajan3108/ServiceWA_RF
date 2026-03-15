*** Settings ***
Library    String
Library    AppiumLibrary    timeout=30
#Library     SeleniumLibrary
Library    OperatingSystem
Resource        ../rf-utilities/DataUtility.robot
Resource        ../rf-utilities/PropertyUtilities.robot
Library         ../rf-utilities/ExtentReportListener.py
Resource        ../rf-utilities/ExtentUtilityListener.robot
#Library         ../rf-driverutils/AppiumEnhanceLibrary.py
Library    SeleniumLibrary
#Library         ../rf-utilities/AbhiTest.py
Resource        ../Resources/Common.robot

*** Variables ***
# GENERAL
${RETRY COUNT}    6x
${RETRY WAIT}     5s
*** Variables ***

# HOME PAGE
${ACCEPT COOKIES}               xpath=//button[@id="onetrust-accept-btn-handler"]

${Perfecto_Webdriver_Url}       https://lennoxintl-public.perfectomobile.com/nexperience/perfectomobile/wd/hub
${Security_Token}               eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJkMjczZGY5ZS0xNDQ5LTRmZDgtOTQ1Ni03MDM0ZjIxMjhhZTEifQ.eyJpYXQiOjE2MzY1MjAxMjIsImp0aSI6IjAzNDhmZDEyLTA1OWMtNGYwOS05ZjQzLTBhMzIyMTBjYWU2NyIsImlzcyI6Imh0dHBzOi8vYXV0aDUucGVyZmVjdG9tb2JpbGUuY29tL2F1dGgvcmVhbG1zL2xlbm5veGludGwtcHVibGljLXBlcmZlY3RvbW9iaWxlLWNvbSIsImF1ZCI6Imh0dHBzOi8vYXV0aDUucGVyZmVjdG9tb2JpbGUuY29tL2F1dGgvcmVhbG1zL2xlbm5veGludGwtcHVibGljLXBlcmZlY3RvbW9iaWxlLWNvbSIsInN1YiI6IjE2MDYwN2YzLTZmZTAtNDI4Mi04ZWRjLWYzYWIwM2Q3Njg0NyIsInR5cCI6Ik9mZmxpbmUiLCJhenAiOiJvZmZsaW5lLXRva2VuLWdlbmVyYXRvciIsIm5vbmNlIjoiMTk4NzU2YmQtZmQ3Yy00YWMzLTk5ODgtNmFjZTYxNGE5N2ZjIiwic2Vzc2lvbl9zdGF0ZSI6ImUzOTA1ZGNjLTM0ZmItNDY1OS1iZGU5LWQyOGRmNGQxZjFlNyIsInNjb3BlIjoib3BlbmlkIGVtYWlsIG9mZmxpbmVfYWNjZXNzIHByb2ZpbGUifQ.khyPtbRXGTUncTX4B5KMPtUfgRhFabnmPuoz5qHvA2o
${Device_Id}                    RFCN70BLFRE
${Bundle_Id}                    com.lennox.DaveNet.apk
#DaveNet.ipa
${App}                          PRIVATE:com.lennox.DaveNet_3.83.04.apk

#Browser Stack
${USERNAME}    sundarnatarajan_iqyk45    #Can specify BrowserStack Username directly instead of Environment variable.
${ACCESS_KEY}    wtYGx3ewdxiUVMBvSFX8    #Can specify BrowserStack Accesskey directly instead of Environment variable.
${REMOTE_URL}    http://${USERNAME}:${ACCESS_KEY}@hub-cloud.browserstack.com/wd/hub
${EnableLocation}    //android.widget.Button[@resource-id="permission_allow_foreground_only_button"]

#PRIVATE:DaveNet.ipa

*** Keywords ***
Launch Mobile Applications
    [Documentation]    Keyword to Launch Application based on execution location, device type and required capablities
    [Arguments]  ${File Path}   ${Sheet Name}
    Log to console  Mobile Platform : %{MobileTestExecutionPlatform}
    IF  "%{MobileTestExecutionPlatform}" == "BrowserStack"
        Log to console  ~~~>Execution is platform is BrowserStack
        Launch Mobile Application on BrowserStack     MobileConfig.xlsx   AppiumConfig
    ELSE
        Log to console  ~~~>Execution platform is SauceLabs
        Launch Mobile Application     MobileConfig.xlsx   AppiumConfig
    END

Launch Mobile Application on BrowserStack
    [Documentation]    Keyword to Launch Application based on execution location, device type and required capablities
    [Arguments]  ${File Path}   ${Sheet Name}

    Set Global Variable    ${LOGIN STATUS}    False
    Log to Console  Inside~Launch Mobile Application 1
	Log to Console  Device Name : %{DEVICE_NAME}
	Log to Console  App Path : %{APP_PATH}
#	Log to Console  MOBILE_DEVICE_GROUP : %{MOBILE_DEVICE_GROUP}


	${DevName}=          Set Variable  %{DEVICE_NAME}
	#${DevGroup}=          Set Variable  %{MOBILE_DEVICE_GROUP}

    &{prop}=    Load Config Properties Data
    Log To Console    Loaded Properties Data
    ${App Path}=        Set Variable  %{APP_PATH}
    ${orientation}=        Set Variable  ${prop.Orientation}

    #Set Environment Variable    MOBILE_DEVICE_GROUP     ${DevGroup}
    Set Environment Variable    DEVICE_NAME    ${DevName}

    &{App Config}=  Load Server Config Data  ${File Path}   ${Sheet Name}
    ${Device}=          Set Variable  ${App Config.Device_Name}
    ${Device Type}=     Set Variable  ${App Config.Device_Type}
    ${OS}=              Set Variable  ${App Config.Device_OS}
    ${OS Version}=      Set Variable  ${App Config.OS_version}
    ${Port}=            Set Variable  ${App Config.Appium_port}

    Set Environment Variable    L_DeviceName    ${Device}
    Set Environment Variable    L_OS    ${OS}
    Set Environment Variable    L_OS_Version    ${OS Version}
    Set Environment Variable    L_AppPath    %{APP_PATH}
    Set Environment Variable    L_Orientation    ${prop.Orientation}

    Log to Console  Inside~Launch Mobile Application 2
	Log to Console  Device Name : %{DEVICE_NAME}
	#Log to Console  MOBILE_DEVICE_GROUP : %{MOBILE_DEVICE_GROUP}

    Set Environment Variable    Device OS    ${OS}
    Set Environment Variable    Device Type    ${Device Type}
    Set Environment Variable    OS Version    ${OS Version}
    Set Environment Variable    App Environment    ${prop.App_Environment}
    set Environment Variable    App Version        ${prop.App_Version}
    set Environment Variable    Device_Orientation        ${prop.Orientation}

    Log To Console  Mobile View :> %{MOBILE_VIEW}

    ${URL}    Set Variable If    "${Port}" == "0000"    %{CONNECTION_URL}    http://localhost:${Port}/wd/hub

    Log      Launching Mobile App

    Run Keyword If    "%{MOBILE_VIEW}" == "NA" and "${OS}" == "iOS" and "${Port}" == "0000"        Open Application    ${URL}    platformName=${OS}    platformVersion=${OS Version}    deviceName=${Device}    app=${App Path}    autoDismissAlerts=true    orientation=${orientation}    name=${TEST NAME}  cacheId=${Device}  newCommandTimeout=180
#    Run Keyword If    "%{MOBILE_VIEW}" == "NA" and "${OS}" == "Android" and "${Port}" == "0000"    Open Application    ${URL}    platformName=${OS}    platformVersion=${OS Version}    deviceName=${Device}    app=${App Path}    autoGrantPermissions=true     name=${TEST NAME}  cacheId=${Device}     newCommandTimeout=180   orientation=${orientation}
    Run Keyword If    "%{MOBILE_VIEW}" == "NA" and "${OS}" == "Android" and "${Port}" == "0000"    Open Application    ${REMOTE_URL}    app=${App Path}   name=${TEST NAME}    build=RobotFramework    platformName=${OS}    os_version=${OS Version}    deviceName=${Device}   autoGrantPermissions=false   autoDismissAlerts=true   interactiveDebugging=true

    Log To Console  Launched Mobile App

#    AppiumLibrary.Click Element     ${EnableLocation}
    Log to console      **** Clicked on Enable Location while using the app ***

    Sleep    10    Wait for all context to be available
    ${contexts}    Get Contexts
    Log To console    Contexts:-${contexts}
    Run Keyword If    "${OS}" == "Android" and "${OS Version}" == "Chrome"   Switch To Context    ${contexts}[0]
    
    Log        Contexts:-${contexts}
    ${context}      Get Current Context
    ${STATUS}       Evaluate   "WEBVIEW" in """${context}"""
    
    Log        Context: ${context}
    Log        Status : ${STATUS}



Launch Browser Test
    [Documentation]    Wrapper keyword to Launch Chrome Browser in Developer Mode
     [Arguments]  ${File Path}   ${Sheet Name}
#    [Arguments]    ${Msg}               ${Flag}=False
#    InitialSetup
    Log To Console    Launching Chrome Browser in Developer Mode
#    Open Browser  %{APP_URL}  %{BROWSER_TYPE}  options=add_argument("--ignore-certificate-errors")
#    Log To console  Enabling View
#    Open Browser    %{APP_URL}   browser=chrome  desired_capabilities=${desired_capabilities}
    Open Browser  https://liidaveqa.com  Chrome  options=add_argument("--ignore-certificate-errors")
    Maximize Browser Window
    Log to console  Maximized the Browser
    Sleep   10s

Show Contexts
    [Documentation]    Print the Contexts
    Sleep    10    Wait for all context to be available
    ${contexts}    Get Contexts
    Log        Contexts:-${contexts}

    ${context}      Get Current Context
    Log        Current Context:-${context}

    ${STATUS}       Evaluate   "WEBVIEW" in """${context}"""
    Log        STATUS:-${STATUS}


Initial Setup
#    Set Environment Variable    DEVICE_NAME    Samsung Galaxy S21 5G
#    Set Environment Variable    SAUCE_URL    https://abhilashmobile:b3c3cccf-242f-4724-83b4-51842a9e9b30@ondemand.us-west-1.saucelabs.com:443/wd/hub
#    Set Environment Variable    AUTOMATION_TESTTYPE    regression
#    Set Environment Variable    USER_ACCOUNT    BHI
#    Set Environment Variable    PIPELINE_EXECUTION    False
#    Set Environment Variable    MOBILE_VIEW    https://liidaveqa.com

    &{prop}=    Load Config Properties Data
    ${App Path}=        Set Variable  ${prop.App_Path}
    IF  "%{MobileTestExecutionPlatform}" == "BrowserStack"
        ${App Path}=        Set Variable  ${prop.App_Path_BS}
    ELSE
        ${App Path}=        Set Variable  ${prop.App_Path_SL}
    END
    ${orientation}=        Set Variable  ${prop.Orientation}

    &{App Config}=  Load Server Config Data    $File Name    $Sheet Name
    ${Device}=          Set Variable  ${App Config.Device_Name}
    ${Device Type}=     Set Variable  ${App Config.Device_Type}
    ${OS}=              Set Variable  ${App Config.Device_OS}
    ${OS Version}=      Set Variable  ${App Config.OS_version}
    ${Port}=            Set Variable  ${App Config.Appium_port}

    Set Environment Variable    Device OS    ${OS}
    Set Environment Variable    Device Type    ${Device Type}
    Set Environment Variable    OS Version    ${OS Version}
    Set Environment Variable    App Environment    ${prop.App_Environment}
    set Environment Variable    App Version        ${prop.App_Version}
    set Environment Variable    Device_Orientation        ${prop.Orientation}
    Log To Console  Mobile View :> %{MOBILE_VIEW}


Accept Cookies
    [Documentation]    Wrapper keyword to Accept Cookies
    [Arguments]    ${Msg}               ${Flag}=False
    ${ACCEPT_COOKIES_Visible} =   Run Keyword And Return Status  AppiumLibrary.Element Should Be Visible    ${ACCEPT COOKIES}
    Log to console    Is Accept Cookies Available?: ${ACCEPT_COOKIES_Visible}
    Write Extent Test Steps     Is Accept Cookies Available?: ${ACCEPT_COOKIES_Visible}            Pass                 ${Flag}

    IF          ${ACCEPT_COOKIES_Visible}==True
        ${text}     AppiumLibrary.Get Text    ${ACCEPT COOKIES}
        Click Mobile Element    ${ACCEPT COOKIES}
        Sleep   1
        Refresh The Current Screen
        AppiumLibrary.Wait Until Page Does Not Contain    ${text}
        Log to console    Accepted Cookies is '${Msg}'
        Write Extent Test Steps   Accepted Cookies is '${Msg}'                 Pass                 ${Flag}
    END

Close Mobile Application
    [Documentation]    Wrapper keyword to close application
    AppiumLibrary.Close Application
#    Close Extent Report
    sleep               1
#    ${PIPELINE_EXECUTION}       Convert To Lower Case    %{PIPELINE_EXECUTION}
#    IF  '${PIPELINE_EXECUTION}' == 'false'
#        Run Process                    java                    -jar                      ${EXECDIR}/LennoxPROs/ExtentUtilities/NodeExtentRunner.jar
#    END

Convert Currency To Number
    [Documentation]    Keyword to convert currency to number
    ...    Input format - $n,nnn,nnn
    ...    Output format - nnnnnnn
    [Arguments]    ${Currency Value}
    ${Number Value}    Remove String    ${Currency Value}    $    ,    ${SPACE}
    ${Number Value}    Convert To Number    ${Number Value}
    RETURN    ${Number Value}

Click Mobile Element
    [Documentation]    Wrapper Keyword for Click Element with Retry included
    [Arguments]    ${Element}
    ${context}      Get Current Context
    ${STATUS}       Evaluate   "WEBVIEW" in """${context}"""
    Run Keyword If  ${STATUS}       Validate Document Ready State

    AppiumLibrary.Wait Until Page Contains Element    ${Element}
    AppiumLibrary.Element Should Be Enabled    ${Element}
#    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    Click Element    ${Element}
    ${MSG}      Run Keyword And Ignore Error   Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    AppiumLibrary.Click Element    ${Element}

    ${STATUS}   Run Keyword And Return Status  Should Contain   ${MSG}[1]   ElementClickInterceptedException
    IF  '${MSG}[0]'=='FAIL' and ${STATUS}
#        Approach One
#        Scroll Element Into View And Click  ${Element}
#        Approach two
        Scroll To Given Element  ${Element}
        AppiumLibrary.Click Element  ${Element}
    ELSE IF  '${MSG}[0]'=='FAIL' and not ${STATUS}
        Fail  ${MSG}[1]
    END
    Run Keyword If  ${STATUS}       Validate Document Ready State



Select Mobile List Option
    [Documentation]    Wrapper Keyword for Select an option from List with Retry included
    [Arguments]    ${Select Element}    ${Option Element}
#    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    Click Element    ${Select Element}
    Click Mobile Element    ${Select Element}
    Sleep   2s
    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    AppiumLibrary.Click Element    ${Option Element}

    IF      "%{Device OS}" == "Android" and "%{Device Type}" == "Mobile" and "%{OS Version}" > "9"
             AppiumLibrary.Click Element At Coordinates  100   100
    END


Select Mobile Radio Button
    [Documentation]    Wrapper Keyword for Click on a radio button with Retry included
    [Arguments]    ${Element}
    Validate Document Ready State
    AppiumLibrary.Wait Until Page Contains Element    ${Element}
    Click Mobile Element    ${Element}
#    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    Click Element    ${Element}

Get Mobile Text
    [Documentation]    Wrapper Keyword to get text from an Element with Retry included
    [Arguments]    ${Element}
    Validate Document Ready State
    AppiumLibrary.Wait Until Page Contains Element    ${Element}
    ${Text}    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    AppiumLibrary.Get Text    ${Element}
    RETURN    ${Text}

Input Mobile Text
    [Documentation]    Wrapper Keyword to input text to an Element with Retry included
    [Arguments]    ${Element}    ${Text}
    ${context}      Get Current Context
    ${STATUS}       Evaluate   "WEBVIEW" in """${context}"""
    Run Keyword If  ${STATUS}       Validate Document Ready State

    AppiumLibrary.Wait Until Page Contains Element    ${Element}
    Run Keyword If  ${STATUS}       Clear Mobile Text       ${Element}
    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    AppiumLibrary.Input Text    ${Element}    ${Text}
    IF  "%{Device OS}" == "Android"
        Hide Keyboard
    END

Clear Mobile Text
    [Documentation]    Wrapper Keyword to clear text from an Element with Retry included
    [Arguments]    ${Element}
    Validate Document Ready State
    AppiumLibrary.Wait Until Page Contains Element    ${Element}
    AppiumLibrary.Wait Until Element Is Visible    ${Element}
    Sleep   2s
    ${Value}    AppiumLibrary.Get Element Attribute    ${Element}    value
#    IF  "${Value}" != "${EMPTY}"
        FOR    ${Index}    IN RANGE    1    5

            Click Mobile Element    ${Element}
            Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    Clear Text    ${Element}
            ${Value}    AppiumLibrary.Get Element Attribute    ${Element}    value
            Exit For Loop If    "${Value}" == "${EMPTY}"
        END
#    END
    Hide Keyboard



Verify Element Change

    # Assume 'my_element_locator' is the ID or XPath of the element
    Wait Until Element Is Visible    ${ElementLinked}
    Element Text Should Be           my_element_locator    texr1

Wait For Element Present
    [Documentation]    Wrapper Keyword for to validate the given element is present
    [Arguments]    ${Element}
    Validate Document Ready State
    AppiumLibrary.Wait Until Page Contains Element    ${Element}
    AppiumLibrary.Wait Until Element Is Visible    ${Element}
    ${STATUS}=     Run Keyword And Return Status    AppiumLibrary.Element Should Be Enabled    ${Element}
    RETURN    ${STATUS}


Validate the text in the alert window
    [Arguments]     ${Text}
    Validate Document Ready State
    AppiumLibrary.Wait Until Page Contains     ${Text}
    Log To Console     Validated the text '${Text}' in popup
    Write Extent Test Steps      Validated the text ${Text} in popup                 Pass                   True

Get The Count Of Given Webelement List
    [Documentation]  Wrapper keyword to get the count of the given webelement list
    [Arguments]  ${Element}
    #Validate Document Ready State
    @{list_element}=   AppiumLibrary.Get Webelements    ${Element}
    ${count}=   Get length    ${list_element}
    RETURN    ${count}

Wait For Element Not Present
    [Documentation]    Wrapper Keyword for to validate the given element is not present
    [Arguments]    ${Element}
    Validate Document Ready State
    ${STATUS}=      Run Keyword And Return Status       AppiumLibrary.Wait Until Page Does Not Contain Element    ${Element}

Scroll Element Into View And Click
    [Documentation]  Wrapper keyword to scroll to given element and click on that element
    [Arguments]  ${element}
    Validate Document Ready State
    Execute Script   window.scrollTo(0, -document.body.scrollHeight)
    Swipe     0    495    0    50
    FOR  ${X}   IN RANGE   0   60
        ${Status}    Run Keyword And Return Status   AppiumLibrary.Click Element   ${element}
        IF  not ${Status}
            Swipe     0    495    0    50
        ELSE IF  ${Status}
            Exit For Loop
            Scroll Up   ${element}
        END
        IF  not ${Status} and ${X} == 59
            Fail  Given element locator ${element} not in 60 seconds
        END
        Sleep  1s
    END

Click Enabled Element
     [Arguments]     ${EnableElement}
    # Wait for the element to be enabled (timeout in seconds)
    Wait Until Element Is Enabled    ${EnableElement}    timeout=10
    Click Element    ${EnableElement}

Scroll Element Into View
    [Documentation]  Wrapper keyword to scroll to given element and click on that element
    [Arguments]  ${element}
#    Validate Document Ready State
    Execute Script   window.scrollTo(0, -document.body.scrollHeight)
    Swipe     0    495    0    50
    FOR  ${X}   IN RANGE   0   60
        ${Status}    Run Keyword And Return Status   AppiumLibrary.Element Should Be Visible   ${element}
        IF  not ${Status}
#            Swipe     0    495    0    50
            Swipe Up Screen
        ELSE IF  ${Status}
            Exit For Loop
            Scroll Up   ${element}
        END
        IF  not ${Status} and ${X} == 59
            Fail  Given element locator ${element} not in 60 seconds
        END
        Sleep  1s
    END

Refresh The Current Screen
    [Documentation]  Wrapper to refersh the Screen
    Execute Script    window.location.reload(true);
    Validate Document Ready State
    Write Extent Test Steps   Done Page Refresh                Pass                  False

Swipe up screen Range
    [Arguments]     ${SwipElement}
       FOR       ${counter}  IN RANGE    1 10
     ${Isvisible}=    Common.Element Should Be Enabled   ${SwipElement}
         IF       '${Isvisible}' ==     'True'
                    AppiumCommon.Swipe Up Screen
         Exit For Loop
         ELSE
             AppiumCommon.Swipe Up Screen
         END
     END

Swipe Up Screen
    [Documentation]  wrapper keyword to swipe the screen
    Swipe     0    495    0    150

Swipe Screen Upwards
    # Swipe from bottom (80%) to top (20%) of the screen, staying in the middle horizontally (50%)
    Swipe By Percent    50    80    0    20    1000
#    Swipe By Percent    50    80    50    20    1000

Swipe Down Screen
    [Documentation]  wrapper keyword to swipe the screen
    Swipe     495    0    150    0

Validate The Application Home Screen And Launch App
    [Documentation]  Keyword wrapper to validate and launch The application
    ${status}=  Run Keyword And Return Status  AppiumLibrary.Wait Until Element Is Visible    xpath=//p[contains(text(),"Quick Order")]
    IF  not ${status}
        Log To Console   Re-launching The Application
        ${ClOSED_STATUS}=  Run Keyword And Return Status   AppiumLibrary.Close Application
        Launch Mobile Application     MobileConfig.xlsx   AppiumConfig
    ELSE
        Log To Console  Already application is in home screen
    END

Validate The Given Text Present in the screen
    [Arguments]     ${Text}     ${msg}=None
    Validate Document Ready State
    AppiumLibrary.Wait Until Page Contains     ${Text}
    IF  '${msg}'!='None'
        ${New_msg}      Set Variable  Validated given ${msg}: '${Text}' is present in the screen, as expected
    ELSE
        ${New_msg}      Set Variable    Validated the text '${Text}' is present in the screen, as expected
    END
    Log To Console      ${New_msg}
    Write Extent Test Steps   ${New_msg}                 Pass                  True

Validate The Given Text Not Present in the screen
    [Arguments]     ${Text}     ${msg}=None
    Validate Document Ready State
    AppiumLibrary.Wait Until Page Does Not Contain   ${Text}
    IF  '${msg}'!='None'
        ${New_msg}      Set Variable  Validated given ${msg}: '${Text}' is not present in the screen, as expected
    ELSE
        ${New_msg}      Set Variable    Validated the text '${Text}' in not present in the screen, as expected
    END
    Log To Console      ${New_msg}
    Write Extent Test Steps   ${New_msg}                 Pass                  True

Validate The List Of Text Data In The Screen
    [Documentation]  Validate The List Of Text Data In The Screen
    [Arguments]  @{LIST TEXT}
    Validate Document Ready State
    FOR  ${TEXT}  IN  @{LIST TEXT}
        AppiumLibrary.Wait Until Page Contains  ${TEXT}
        Log To Console  Validated text is: '${TEXT}'
 #       Write Extent Test Steps   Validated text is ${TEXT}                 Pass                    True
    END
    Write Extent Test Steps   Validated text is ${TEXT}                 Pass                   True

Validate The List Of Text Data And Assign Description In The Screen
    [Documentation]  Validate The List Of Text Data In The Screen
    [Arguments]  ${VALIDATION TEXT}       ${MESSAGE}
    Validate Document Ready State
    ${CNT}  Get Length  ${MESSAGE}
    FOR    ${index}    ${TEXT}    IN ENUMERATE  @{VALIDATION TEXT}
        AppiumLibrary.Wait Until Page Contains  ${TEXT}
        IF  ${index}>${CNT}-1
                ${BASE_TEXT}    Set Variable     message
        ELSE
            ${BASE_TEXT}    Strip String    ${MESSAGE}[${index}]
            ${BASE_TEXT}    Set Variable  ${BASE_TEXT}
        END
        Log To Console  Validated ${BASE_TEXT} is: '${TEXT}'
        Write Extent Test Steps   Validated ${BASE_TEXT} is ${TEXT}                 Pass                    True
    END

Validate The Given Two Strings Are Equal In The Screen
    [Arguments]     ${STRING_1}     ${STRING_2}
    Should Be Equal As Strings    ${STRING_1}     ${STRING_2}
    Log To Console  Validated the string1 is '${STRING_1}' and String2 is '${STRING_2}' are equal
    Write Extent Test Steps   Validated the string1 is ${STRING_1} and String2 is ${STRING_2} are equal                 Pass                  True

Validate The Given Two Strings Are Not Equal In The Screen
    [Arguments]     ${STRING_1}     ${STRING_2}
    Should Not Be Equal As Strings    ${STRING_1}     ${STRING_2}
    Log To Console  Validated the string1 is '${STRING_1}' and String2 is '${STRING_2}' are not equal
    Write Extent Test Steps   Validated the string1 is ${STRING_1} and String2 is ${STRING_2} are not equal                 Pass                  True

Validate Document Ready State
    [Documentation]  keyword wrapper to validate the ready state
    FOR  ${X}   IN RANGE   0   120
        ${PageLoadStatus}=  Execute Script  return document.readyState
        IF  '${PageLoadStatus}' == 'complete'
            Exit For Loop
        END
        Sleep  1s
    END

Get And Validate The Page Title OF The Current Screen
    [Documentation]     keyword wrapper to Validate the page title
    [Arguments]  ${EXPECTED TITLE}
    Validate Document Ready State
    FOR  ${X}   IN RANGE   0   90
        ${PageTitle}=  Execute Script  return document.title
        ${ACTUAL TITLE}    Strip String  ${PageTitle}
        IF      "${ACTUAL TITLE}" == "${EXPECTED TITLE}"
                Exit For Loop
        END
        Sleep  1s
    END
    Should Be Equal As Strings    ${EXPECTED TITLE}     ${ACTUAL TITLE}
    Validate Document Ready State
    Log To Console  Validated Page tile is "${ACTUAL TITLE}"
#    Write Extent Test Steps     ${ACTUAL TITLE}     Pass                  True

Get The Back Ground Color Of The Given Element
    [Documentation]  keyword wrapper to get the background color of the given element
    [Arguments]  ${ELEMENT LOCATOR}
    Log To Console      ${ELEMENT LOCATOR}
    ${DOC ELEMENT}=       Set Variable            document.evaluate("${ELEMENT LOCATOR}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue
    ${Background Color}=         Execute script          return window.getComputedStyle(${DOC ELEMENT},null).getPropertyValue('background-color');

    RETURN  ${Background Color}

Get The Font Size Of The Given Element
    [Documentation]  keyword wrapper to get the font size of the given element
    [Arguments]  ${ELEMENT LOCATOR}
    Log To Console      ${ELEMENT LOCATOR}
    ${DOC ELEMENT}=       Set Variable            document.evaluate("${ELEMENT LOCATOR}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue
    ${FONT SIZE}=         Execute script          return window.getComputedStyle(${DOC ELEMENT},null).getPropertyValue('font-size');

    RETURN  ${FONT SIZE}

Get The Text For The Given Element
    [Documentation]  keyword wrapper to get the text for the given element
    [Arguments]  ${ELEMENT LOCATOR}
    ${DOC ELEMENT}=      Execute Script                  return document.evaluate("${ELEMENT LOCATOR}", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).textContent;
	${TEXT}=       Execute Script                  return document.evaluate('${DOC ELEMENT}', document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0).textContent;
	RETURN  ${TEXT}

Validate The Given Texts are Matched
    [Documentation]  keyword wrapper to validate the text are matched
    [Arguments]  ${ACTUAL VALUE}    ${EXPECTED VALUE}   ${MESSAGE}
    IF      '${ACTUAL VALUE}' == '${EXPECTED VALUE}'
            Log To Console          ${MESSAGE}, actual value: '${ACTUAL VALUE}' and expected value: '${EXPECTED VALUE}' are Matched
            Write Extent Test Steps     ${MESSAGE}, actual value: '${ACTUAL VALUE}' and expected value: '${EXPECTED VALUE}' are Matched               Pass           True
    ELSE
        Fail    ${MESSAGE}, actual value: '${ACTUAL VALUE}' and expected value: '${EXPECTED VALUE}' are not Matched
    END

Validate The Given Texts Are Not Matched
    [Documentation]  keyword wrapper to validate the text are not matched
    [Arguments]  ${ACTUAL VALUE}    ${EXPECTED VALUE}   ${MESSAGE}
    IF      '${ACTUAL VALUE}' != '${EXPECTED VALUE}'
            Log To Console          ${MESSAGE}, actual value: '${ACTUAL VALUE}' and expected value: '${EXPECTED VALUE}' are not Matched as expected
            Write Extent Test Steps     ${MESSAGE}, actual value: '${ACTUAL VALUE}' and expected value: '${EXPECTED VALUE}' are not Matched as expected               Pass           True
    ELSE
        Fail    ${MESSAGE}, actual value: '${ACTUAL VALUE}' and expected value: '${EXPECTED VALUE}' are Matched, but shoudn't match
    END

Select Mobile List Option One
    [Documentation]    Wrapper Keyword for Select an option from List with Retry included
    [Arguments]    ${Select Element}    ${Option Element}
    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    AppiumLibrary.Click Element    ${Select Element}
    Click Mobile Element    ${Select Element}
    Sleep   2s
    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    AppiumLibrary.Click Element    ${Option Element}

    IF      "%{Device OS}" == "Android" and "%{Device Type}" == "Mobile" and "%{OS Version}" > "9"
             AppiumLibrary.Click Element At Coordinates  100   100
    END

Validate Element Exists Upon Clicking
    [Documentation]  Keyword to validate whether the element is present or not
    [Arguments]    ${ElementXPath}   ${ElementDescription}   ${ClickedElement}
    Log To Console      Received Paramaters:-${ElementXPath}--${ElementDescription}--${ClickedElement}
    ${Value}=   Run Keyword And Return Status   AppiumLibrary.wait until page contains element       ${ElementXPath}
    Log To Console      Keyword Status : ${Value}
    ${User}=          Set Variable  AuthenticatedUser

    IF     "%{USER_LOGIN}" == "None"
        ${User}=          Set Variable  UnAuthenticatedUser
    END

    IF      "${Value}" == "True"
        Log To Console      PASSED ~ ${ElementDescription} is visible for the ${User}
        Write Extent Test Steps    ${ElementDescription} is displayed upon clicking on ${ClickedElement} for the ${User}      Pass     True
    ELSE
        Log To Console      FAILED ~ ${ElementDescription} is not visible for the ${User}
        Write Extent Test Steps    ${ElementDescription} is not displayed upon clicking on ${ClickedElement} for the ${User}      Fail     True
    END

Validate Element Exists
    [Documentation]  Keyword to validate whether the element is present or not
    [Arguments]    ${ElementXPath}   ${ElementDescription}
    Log To Console      Received Paramaters:-${ElementXPath}--${ElementDescription}
    ${Value}=   Run Keyword And Return Status   AppiumLibrary.wait until page contains element       ${ElementXPath}
    Log To Console      Keyword Status : ${Value}
    ${User}=          Set Variable  AuthenticatedUser

    IF     "%{USER_LOGIN}" == "None"
        ${User}=          Set Variable  UnAuthenticatedUser
    END

    IF      "${Value}" == "True"
        Log To Console      PASSED ~ ${ElementDescription} is visible for the ${User}
        Write Extent Test Steps    ${ElementDescription} is displayed for the ${User}      Pass     True
    ELSE
        Log To Console      FAILED ~ ${ElementDescription} is not visible for the ${User}
        Write Extent Test Steps    ${ElementDescription} is not displayed for the ${User}      Fail     True
    END


Check Status and Write Results
    [Documentation]  Keyword wrapper to check the status and to write the results to report
    [Arguments]     ${Status}       ${Description}
    IF  ${Status}
        Log to console      PASSED:${Description}
        Write Extent Test Steps         Validated successfully that ${Description} is displayed      Pass        False
    ELSE
        Log to console      FAILED:${Description}
        Write Extent Test Steps         ${Description} is not displayed      Fail        False
    END


Check Element Exists
    [Documentation]  Keyword wrapper to check whether a given element exists or not
    [Arguments]     ${Element}       ${Description}=The given element
#    ${STATUSTEXT}=        Run Keyword And Return Status           Wait Until Page Contains Element            ${Element}
    ${STATUSTEXT}=        Run Keyword And Return Status           Wait For Element Present            ${Element}
    Check Status and Write Results      ${STATUSTEXT}       ${Description}


Validate Element Text
    [Documentation]  Keyword wrapper to check whether a given element is displaying the expected text
    [Arguments]     ${Element}       ${ExpectedMessage}
    ${ErrorMsg}     AppiumLibrary.Get Text    ${Element}
    Log to Console      Validating the error message, Actual is : ${ErrorMsg} and Expected is : ${ExpectedMessage}
    Write Extent Test Steps         Validating the error message, Actual is : ${ErrorMsg} and Expected is : ${ExpectedMessage}  Pass        False
    IF  "${ErrorMsg}" == "${ExpectedMessage}"
        Log to console      PASSED:${ErrorMsg} is displayed as expected
        Write Extent Test Steps         Validated successfully that ${ExpectedMessage} is displayed      Pass        True
    ELSE
        Log to console      FAILED:Error message is displayed as ${ErrorMsg} instead of ${ExpectedMessage}
        Write Extent Test Steps         Failed to validate the message. It is not displayed as ${ExpectedMessage}      Fail        True
    END

Write Results
    [Documentation]  Keyword wrapper to check the status and to write the results to report
    [Arguments]     ${Status}       ${Description}
    IF  ${Status}
        Write Pass Results  ${Description}
    ELSE
        Log to console      FAILED: ${Description}
        Write Extent Test Steps         ${Description}      Fail        False
    END

Write Pass Results
    [Documentation]  Keyword wrapper to check the status and to write the results to report
    [Arguments]     ${Description}
        Log to console      PASSED: ${Description}
        Write Extent Test Steps         ${Description}      Pass        True
