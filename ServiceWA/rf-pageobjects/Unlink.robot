*** Settings ***
Library    AppiumLibrary
Resource    ../rf-data/password.robot
Library    ../rf-utilities/ExtentReportListener.py
Resource    ../rf-utilities/ExtentUtilityListener.robot
Resource    ../rf-utilities/ExtentUtilityListener.robot
Resource    ../Resources/Common.robot
Resource  ../rf-driverutils/AppiumCommon.robot


*** Variables ***
#Android
${LinkableServices}    ///android.view.View[@content-desc="Linkable services"]
${FishCatchWA}        //android.view.View[@content-desc="FishCatchWA"]
${Next}    //android.widget.Button[@content-desc="Next"]
${IAgree}    //android.widget.Button[@content-desc="I Agree"]
${BackToServiceWA}    //android.widget.ImageView[@content-desc="ServiceWA"]
${Linked}    //android.view.View[@content-desc="Linked"]

#IOS
${ios_LinkableServices}    //XCUIElementTypeStaticText[@name="Linkable services"]
${ios_FishCatchWA}        //XCUIElementTypeOther[@name="FishCatchWA"]
${ios_Next}    //XCUIElementTypeButton[@name="Next"]
${ios_IAgree}    //XCUIElementTypeButton[@name="I Agree"]
#${ios_BackToServiceWA}    //XCUIElementTypeImage[@name="ServiceWA"]
#${ios_BackToServiceWA}    //XCUIElementTypeImage[@label="ServiceWA"]
#${ios_BackToServiceWA}    //XCUIElementTypeImage[@name="ServiceWA" or @label="ServiceWA"]
${ios_BackToServiceWA}    accessibility_id=ServiceWA
#${ios_BackToServiceWA}    //XCUIElementTypeApplication[@name="service double you ay"]/following-sibling::*[XCUIElementTypeImage[@name="ServiceWA"]]
${ios_Linked}    //XCUIElementTypeStaticText[@name="Linked"]

*** Keywords ***
Link to the FishCatchWA
    [Documentation]    link the FishCatchWA Mobile Application through Discovery
##     [Arguments]    ${User Name}    ${Password}
#
#    Log        Inside ~ Login to the App
#    Sleep    10    Wait for all context to be available
#    ${contexts}    Get Contexts
#    Log        Contexts:-${contexts}
#    ${context}      Get Current Context
#    ${STATUS}       Evaluate   "WEBVIEW" in """${context}"""
#
#    Log        Context: ${context}
#    Log        Status : ${STATUS}

    Log to console      Device OS : %{Device OS}
    IF  "%{Device OS}" == "iOS"
        Set iosLinkServiceWA xpathvalues to variables
    ELSE
        Log To Console    Executing in Android
    END
    Swipe     0    495    0    150
     Common.Wait for Element Visibility    ${LinkableServices}   LinkableServices Button
     Common.Click Button    ${LinkableServices}    LinkableServices

    Common.Wait for Element Visibility    ${FishCatchWA}   FishCatchWA Button
    ${FishCatchWA_Visible} =   Run Keyword And Return Status  AppiumLibrary.Element Should Be Visible    ${FishCatchWA}
    Log        FishCatchWA Button Visibility : ${FishCatchWA_Visible}
    Common.Click Button    ${FishCatchWA}    FishCatchWAButton

    Common.Wait for Element Visibility    ${Next}   Next Button
    Common.Click Button    ${Next}    Next

        Swipe     0    495    0    150
            Swipe     0    495    0    150
                Swipe     0    495    0    150
                    Swipe     0    495    0    150

#    AppiumCommon.Swipe up screen Range     ${IAgree}
     Common.Wait for Element Visibility    ${IAgree}   IAgree Button
     Common.Element Should Be Enabled   ${IAgree}
     Common.Click Button    ${IAgree}    IAgree

#    Sleep    10s
    Swipe     495    0    150    0
    Swipe     495    0    150    0
#   AppiumLibrary.Wait until page contains     ${BackToServiceWA}    timeout=60s
#   AppiumCommon.Wait for Element Present    ${BackToServiceWA}
    Common.Wait for Element Visibility    ${BackToServiceWA}   BackToServiceWA Button
    Common.Element Should Be Enabled   ${BackToServiceWA}
#   Common.Scroll To Given Element  ${BackToServiceWA}
    Common.Click Button     ${BackToServiceWA}    BackButton

     AppiumLibrary.Element Should Be Visible  ${FishCatchWA}
     Common.Wait for Element Visibility    ${FishCatchWA}
     Common.Wait for Element Visibility    ${Linked}

     Element Name Should Be    ${FishCatchWA}   expected=FishCatchWA
     Element Name Should Be    ${Linked}   expected=Linked


#     Common.Wait for Element Visibility    ${FishCatchWA}   FishCatchWA Button
#    ${FishCatchWA_Visible} =   Run Keyword And Return Status  AppiumLibrary.Element Should Be Visible    ${FishCatchWA}
#    Log        FishCatchWA Button Visibility : ${FishCatchWA_Visible}
#    Common.Click Button    ${FishCatchWA}    FishCatchWAButton


##    Common.Click And Verify Element  ${BackToServiceWA}     ${FishCatchWA}
##    Common.Click Mobile Element    ${BackToServiceWA}
##    AppiumCommon.Click Mobile Element      ${BackToServiceWA}
#     Common.Wait for Element Visibility    ${BackToServiceWA}   BackToServiceWA Button
###   Common.Click Element With Details   ${BackToServiceWA}    BackToServiceWA
#     Common.Element Should Be Enabled   ${BackToServiceWA}
#     Common.Click Element     ${BackToServiceWA}



Set iosLinkServiceWA xpathvalues to variables
    Log To Console    *** overriding the Android keyword values to iOS ***
    Set Suite Variable      ${LinkableServices}    ${ios_LinkableServices}
    Set Suite Variable      ${FishCatchWA}    ${ios_FishCatchWA}
    Set Suite Variable      ${Next}    ${ios_Next}
    Set Suite Variable      ${IAgree}    ${ios_IAgree}
    Set Suite Variable      ${BackToServiceWA}    ${ios_BackToServiceWA}
    Set Suite Variable      ${Linked}    ${ios_Linked}

#Methodservice
#    &{linkeServicelist}
#    ...    FishCatchWA=Next%%%I Agree
#    ...    FuelWatch=Next%%%I Agree%%%Accept location services

