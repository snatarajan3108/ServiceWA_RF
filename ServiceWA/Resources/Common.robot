*** Settings ***
Library    String
Library    AppiumLibrary    timeout=30
Library    OperatingSystem
Resource        ../rf-utilities/DataUtility.robot
Resource         ../rf-utilities/PropertyUtilities.robot
Library         ../rf-utilities/ExtentReportListener.py
Resource        ../rf-utilities/ExtentUtilityListener.robot
Resource        ../rf-utilities/ExtentUtilityListener.robot
Resource        ../rf-driverutils/SeleniumCommonUtils.robot
Resource    ../rf-driverutils/AppiumCommon.robot

*** Variables ***
${SAUCE URL}      https://sundarmobile:b3c3cccf-242f-4724-83b4-51842a9e9b30@ondemand.us-west-1.saucelabs.com:443/wd/hub
${RETRY COUNT}    6x
${RETRY WAIT}     5s


*** Keywords ***
Begin Mobile Test
   open application    http://localhost:4723/wd/hub
       ...    deviceName=emulator-5554
       ...    appPackage=com.lennox.ic3.mobile.droid
       ...    appActivity=com.krasamo.lx_ic3_mobile.login.LMLoginActivity
       ...    platformName=Android
       ...    automationName=UIAutomator2
       ...    autoGrantPermissions=true
End Mobile Test
   close application

#Newly added

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
    Wait for Element    ${Element}
    AppiumLibrary.Wait Until Element Is Visible    ${Element}
    log     ${Element}
    Element Should Be Enabled    ${Element}
    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    Click Element    ${Element}

Select Mobile List Option
    [Documentation]    Wrapper Keyword for Select an option from List with Retry included
    [Arguments]    ${Select Element}    ${Option Element}
    Wait for Element    ${Select Element}
    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    Click Element    ${Select Element}
    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    Click Element    ${Option Element}

Select Mobile Radio Button
    [Documentation]    Wrapper Keyword for Click on a radio button with Retry included
    [Arguments]    ${Element}
   Wait for Element    ${Element}
    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    Click Element    ${Element}

Get Mobile Text
    [Documentation]    Wrapper Keyword to get text from an Element with Retry included
    [Arguments]    ${Element}
    Wait for Element    ${Element}
    ${Text}    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    Get Text    ${Element}
    RETURN    ${Text}

Get Text
    [Documentation]    Wrapper Keyword to get text from an Element with Retry included
    [Arguments]    ${Element}
    IF  "%{EXECUTION_PLATFORM}" == "Mobile"
        ${Text} =   AppiumLibrary.Get Text   ${Element}
    ELSE
        ${Text} =   SeleniumLibrary.Get Text   ${Element}
    END
    RETURN    ${Text}

Input Mobile Text
    [Documentation]    Wrapper Keyword to input text to an Element with Retry included
    [Arguments]    ${Element}    ${Text}
#    Wait for Element    ${Element}
    Wait for Element  ${Element}
    Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    ${Element}    ${Text}

Clear Mobile Text
    [Documentation]    Wrapper Keyword to clear text from an Element with Retry included
    [Arguments]    ${Element}
    Wait for Element    ${Element}
    AppiumLibrary.Wait Until Element Is Visible    ${Element}
    FOR    ${Index}    IN RANGE    1    15
        Click Mobile Element    ${Element}
        Wait Until Keyword Succeeds    ${RETRY COUNT}    ${RETRY WAIT}    Clear Text    ${Element}
        ${Value}    AppiumLibrary.Get Element Attribute    ${Element}    value
        Exit For Loop If    "${Value}" == "${EMPTY}"
    END


#Common Methods for Web and Mobile
Launch Application
    [Documentation]    Keyword to Launch Application based on execution location, device type and required capablities
    [Arguments]  ${File Path}   ${Sheet Name}   ${App Name}
#    Log to console  AppName: ${App Name}
    Log        Inside Launch Application
    Log        Platform: %{EXECUTION_PLATFORM}

    IF  "%{EXECUTION_PLATFORM}" == "Mobile"
        Import Library  AppiumLibrary    timeout=90
        Log  Appium Library Loaded
        Launch Mobile Application on BrowserStack     MobileConfig.xlsx   AppiumConfig
        Log  Launched Mobile Application
    END

Wait for Element Visibility
    [Arguments]     ${Element}      ${ElementName}

    IF  "%{EXECUTION_PLATFORM}" == "Mobile"
        ${STATUS}=     Run Keyword And Return Status    AppiumCommon.Wait For Element Present    ${Element}
    ELSE
        ${STATUS}=     Run Keyword And Return Status    SeleniumCommonUtils.Wait for Element Visibility    ${Element}  30s
    END
    Log        Visibility Status of ${ElementName} is ${STATUS} 

    IF  "${STATUS}" == "True"
        Write Extent Test Steps          ${ElementName} is visible         Pass            True
    ELSE
        Write Extent Test Steps          ${ElementName} is not visible          Fail            True
    END
    RETURN   ${STATUS}




Enter Username Into App
    [Arguments]  ${ElementIdentifier}
    Common.Wait for Element Visibility    ${ElementIdentifier}    UserNameTextbox
    AppiumLibrary.Input Text   ${ElementIdentifier}  TRANCHETWOABV@TestWapol.com.au

Enter Credentials
     [Arguments]  ${USER_ID_FIELD}      # Enters the user ID and password into the respective fields
    Wait Until Page Contains Element    ${USER_ID_FIELD}    timeout=10s    # Wait for the element to be visible
    Input Text    ${USER_ID_FIELD}


Wait for Element
    [Documentation]    Keyword to Launch Application based on execution location, device type and required capablities
    [Arguments]  ${ElementIdentifier}
    Log to Console      Inside -> Wait for Element
    Log to Console      EXECUTION_PLATFORM : %{EXECUTION_PLATFORM}
    IF  "%{EXECUTION_PLATFORM}" == "Mobile"
        TRY
            AppiumLibrary.Wait Until Page Contains Element      ${ElementIdentifier}       timeout=30s
        EXCEPT
            Write Extent Test Steps     Exception Occurred; Element didn't appear. ${ElementIdentifier}          Fail            True
        END
    ELSE
        Log to console      Calling Selenium Library
        TRY
            SeleniumLibrary.Wait Until Page Contains Element  ${ElementIdentifier}
        EXCEPT
            Write Extent Test Steps          Exception Occurred; Element didn't load. ${ElementIdentifier}          Fail            True
        END
    END
    Log to console      Done ${ElementIdentifier}


Element Should Be Enabled
    [Documentation]    Keyword to check whether the element is enabled or not
    [Arguments]  ${ElementIdentifier}
    IF  "%{EXECUTION_PLATFORM}" == "Mobile"
        AppiumLibrary.Element Should Be Enabled  ${ElementIdentifier}
    ELSE
        SeleniumLibrary.Element Should Be Enabled  ${ElementIdentifier}
    END


Scroll To Given Element
    [Documentation]    Keyword to scroll to an element
    [Arguments]  ${ElementIdentifier}
    Wait for Element      ${ElementIdentifier}
    IF  "%{EXECUTION_PLATFORM}" == "Mobile"
        AppiumCommon.Scroll Element Into View  ${ElementIdentifier}
        Log to console      Scrolling to element
    ELSE
          SeleniumLibrary.Scroll Element Into View    ${ElementIdentifier}
    END


Click Element
    [Documentation]    Keyword to click element
    [Arguments]  ${ElementIdentifier}
    IF  "%{EXECUTION_PLATFORM}" == "Mobile"
        Wait for Element    ${ElementIdentifier}
        AppiumLibrary.Click Element  ${ElementIdentifier}
    ELSE
        Wait for Element    ${ElementIdentifier}
        SeleniumLibrary.Click Element  ${ElementIdentifier}
    END


Click Element With Details
    [Documentation]    Keyword to click element
    [Arguments]  ${ElementIdentifier}   ${ElementDetails}
#    TRY
        IF  "%{EXECUTION_PLATFORM}" == "Mobile"
            Wait for Element    ${ElementIdentifier}
            AppiumLibrary.Click Element  ${ElementIdentifier}
        ELSE
            Wait for Element    ${ElementIdentifier}
            SeleniumLibrary.Click Element  ${ElementIdentifier}
        END
         Log to Console  Clicked on ${ElementDetails} Button
#        Write Extent Test Steps          Clicked on - ${ElementDetails}          Pass            True
#    EXCEPT
#        Write Extent Test Steps          Failed to Click on Element: ${ElementDetails}           Fail            True
#    END
    Sleep   4s


Long Press Mobile Element With Details
    [Documentation]    Keyword to Long press Mobile element
    [Arguments]  ${ElementIdentifier}   ${ElementDetails}
#    TRY
        IF  "%{EXECUTION_PLATFORM}" == "Mobile"
            Wait for Element    ${ElementIdentifier}
            AppiumLibrary.Long Press  ${ElementIdentifier}
        ELSE
            Wait for Element    ${ElementIdentifier}
            SeleniumLibrary.Click Element  ${ElementIdentifier}
        END
        Write Extent Test Steps          Long Press on - ${ElementDetails}          Pass            True
    Sleep   4s

Enter Text
    [Documentation]    Keyword to click element
    [Arguments]  ${ElementIdentifier}   ${ElementText}  ${ElementDetails}
    IF  "%{EXECUTION_PLATFORM}" == "Mobile"
        Wait for Element    ${ElementIdentifier}
        AppiumLibrary.Wait Until Page Contains Element  ${ElementIdentifier}
#        AppiumLibrary.Input Mobile Text       ${ElementIdentifier}   ${ElementText}
         AppiumLibrary.Input Text       ${ElementIdentifier}   ${ElementText}
    ELSE
#        Wait for Element    ${ElementIdentifier}
        SeleniumLibrary.Wait Until Page Contains Element  ${ElementIdentifier}
        SeleniumCommonUtils.Send Keys     ${ElementIdentifier}   ${ElementText}  ${ElementDetails}    True
    END
    Write Extent Test Steps          Entered ${ElementText} as ${ElementDetails}           Pass            True
    Log to console  Entered ${ElementText} as ${ElementDetails}

Click Button
    [Documentation]    Keyword to click Button
    [Arguments]  ${ElementIdentifier}   ${Details}
#    TRY
        IF  "%{EXECUTION_PLATFORM}" == "Mobile"
            Wait for Element    ${ElementIdentifier}
            AppiumLibrary.Click Element  ${ElementIdentifier}
        ELSE
            Wait for Element    ${ElementIdentifier}
            SeleniumLibrary.Click Element  ${ElementIdentifier}
        END
        Log to Console  Clicked on ${Details} Button
#        Write Extent Test Steps          Clicked on ${Details} Button           Pass            True
#    EXCEPT
#        Log to Console  Exception Occurred while clicking on ${Details} Button
#        Write Extent Test Steps          Entered ${ElementText} as ElementDetails           Fail            True
#    END

Close Application
    [Documentation]    Wrapper keyword to close application
    Log to console  Inside~ Close application %{EXECUTION_PLATFORM}
    IF  "%{EXECUTION_PLATFORM}" == "Mobile"
        Log to console  Closing Mobile Application
        AppiumLibrary.Close Application
    ELSE
        Log to console  Closing Web Application
        SeleniumLibrary.Close Browser
    END
    Log to console  *** Closed the application ***
    Close Extent Report
    Log to console  Dir: ${EXECDIR}
    sleep               1
    ${PIPELINE_EXECUTION}       Convert To Lower Case    %{PIPELINE_EXECUTION}
    Log To Console    PipeLineExecution: ${PIPELINE_EXECUTION}
    IF  '${PIPELINE_EXECUTION}' == 'false'
        Log to console      Inside ~ IF
        Start Process                    java                    -jar                      "${EXECDIR}\iComfortWebMobileEmailableReport.jar"
        ${result}=    Wait For Process    timeout=1min 30s    on_timeout=kill
        Log to console      Result: ${result}
    END

Close Apps
    [Documentation]    Wrapper keyword to close application
    Log to console  Inside~ Close application %{EXECUTION_PLATFORM}
    IF  "%{EXECUTION_PLATFORM}" == "Mobile"
        Log to console  Closing Mobile Application
        AppiumLibrary.Close Application
    ELSE
        Log to console  Closing Web Application
        SeleniumLibrary.Close Browser
    END

Clear and Send Keys to an Element
    [Documentation]     This method will clear the given element and will enter new text
    [Arguments]  ${ElementIdentifier}   ${ElementDescription}   ${cName}    ${nName}
    Log to console      Inside~Common.Clear and Send Keys to an Element
    IF  "%{EXECUTION_PLATFORM}" == "Mobile"
        Log to console      Inside~If
        AppiumLibrary.Clear Text    ${ElementIdentifier}
        AppiumLibrary.Input Text    ${ElementIdentifier}    ${nName}
        Log to console  Text cleared and entered via Mobile loop
    ELSE
        Log to console      Inside~Else
        SeleniumLibrary.Double Click Element    ${ElementIdentifier}
#        ${count}=   SeleniumLibrary.Get length    ${cName}
        ${count}=    Get Length    ${cName}
        Log to console      Count:${count} for ${cName}
        FOR     ${i}    IN RANGE    ${count}
            Log to console  i:${i}
            SeleniumLibrary.press keys    ${ElementIdentifier}  BACKSPACE
        END

        SeleniumLibrary.press keys    ${ElementIdentifier}  ${nName}
        Write Extent Test Steps     Changed the ${ElementDescription} from ${cName} to ${nName}     Pass    False

    END


Verify No Redirection On Failed Click
     [Documentation]    Attempts to click a button and verifies the page remains the same.
    # Assumes you are on the initial page and the click should fail
     [Arguments]  ${BUTTON_LOCATOR}
    ${current_activity}=    Get Current Activity    # Get the current activity name (for Appium)
    # For web/webview: ${current_url}= Get Location
    Click Element    ${BUTTON_LOCATOR}
     # Check if the activity is still the same after the click
    ${new_activity}=    Get Current Activity
    Should Be Equal    ${current_activity}    ${new_activity}    msg=Page redirection occurred unexpectedly

    # Additionally, you can check for the presence of an error message or a specific element from the original page
    Wait Until Page Contains Element    ${ERROR_MESSAGE_LOCATOR}    timeout=5s    # Wait for an error message to appear

Click And Verify No Redirection
    [Arguments]    ${locator}    ${expected_page_id}
    # Retry clicking 3 times, with 2s delay, if Keyword fails
    Wait Until Keyword Succeeds    3x    2s    Click Element    ${locator}
    # Verify we are still on the same page
    Element Should Be Visible    ${expected_page_id}    # No redirection occurred

Click And Verify Element
    [Arguments]    ${locator}    ${verification_locator}
    AppiumLibrary.Wait Until Element Is Visible  ${locator}  timeout=10s
    Common.Element Should Be Enabled  ${locator}  timeout=10s
    Click Element  ${locator}
    Wait Until Element Is Visible  ${verification_locator}  timeout=10s
    # You could also use "Element Should Be Visible" if you are confident it will appear immediately after the wait

Verify Element
    [Arguments]    ${locator}    ${verification_locator}
    AppiumLibrary.Wait Until Element Is Visible  ${locator}  timeout=10s
    Wait Until Element Is Visible  ${verification_locator}  timeout=10s
    # You could also use "Element Should Be Visible" if you are confident it will appear immediately after the wait
