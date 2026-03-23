*** Settings ***
Library    AppiumLibrary
Resource    ../rf-data/password.robot
Library    ../rf-utilities/ExtentReportListener.py
Resource    ../rf-utilities/ExtentUtilityListener.robot
Resource    ../rf-utilities/ExtentUtilityListener.robot
Resource    ../Resources/Common.robot
#Resource    ../rf-pageobjects/HomeScreen.robot
Resource  ../rf-driverutils/AppiumCommon.robot

*** Variables ***
# Android

${GotIt}        //android.widget.Button[@content-desc="Got it"]
${Done}        //android.widget.Button[@content-desc="Done"]
${Ok}        //android.widget.Button[@content-desc="Ok"]
#${AllowPopup}        //android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_button"]
${AllowPopup}        //*[@resource-id="com.android.permission controller:id/permission_allow_button"]
${Continue}        //android.widget.Button[@content-desc="Continue"]
#${GoToSettings}        //android.widget.Button[@accessibility id="Go to settings"]
${GoToSettings}        //android.widget.Button[@content-desc="Go to settings"]
${LoginToServiceWA}        //android.widget.Button[@content-desc="Log in to ServiceWA"]
${IAgree}        //android.widget.Button[@content-desc="I Agree"]
#Dont require Next as we are skipping the setup assistance
${NextLoginCreateDigitalID}        //android.widget.Button[@content-desc="Next"]
${ReadyToBegin}        //android.widget.Button[@content-desc="I’m ready to begin"]
${ContinueWithDigitalID}        //android.widget.TextView[@text="Continue with Digital ID"]
#${GovpassimageContinuewithDigitalID}        //android.view.View[@content-desc="gov-pass-image Continue with Digital ID"]//android.widget.TextView[@text="Continue with Digital ID"]
${SkipSetup}        //android.widget.Button[@content-desc="Skip setup assistance"]
${myID}        //android.widget.TextView[@text="myID"]
#${RememberMyChoice}        //android.widget.CheckBox[@text="Remember my choice (Not recommended for shared devices)"]
${SelectMyID}        //android.widget.Button[@text="Select myID "]
${EnterMyIDEmail}        //android.widget.EditText[@resource-id="emailInputText"]
${GetCode}        //android.widget.Button[@resource-id="getCodeButton"]
#${VerifyEmail}        //XCUIElementTypeStaticText[@name="Email"]
${Consent}        //android.widget.Button[@text="Consent"]
${SecondConsent}        //android.widget.Button[@resource-id="kc-login"]
${SkipForNow}        //android.widget.Button[@content-desc="Skip for now"]
${YesSkip}        //android.widget.Button[@content-desc="Yes, skip"]
${LogOut}        //android.widget.Button[@content-desc="Log out"]
${Close}        //android.widget.Button[@content-desc="Close"]
${Confirm}        //android.view.View[@content-desc="Inbox"]
${Home}        //android.view.View[@content-desc="Home"]
${Discovery}    //android.view.View[@content-desc="Discovery"]
${Passes}       //android.view.View[@content-desc="Passes"]
${Inbox}        //android.view.View[@content-desc="Inbox"]

#${Inbox}    accessibility id=Inbox

# ios
${ios_GotIt}        //XCUIElementTypeButton[@name="Got it"]
${ios_Done}        //XCUIElementTypeButton[@name="Done"]
${ios_Ok}        //XCUIElementTypeButton[@name="Ok"]
${ios_AllowPopup}    //XCUIElementTypeButton[@name="Allow"]
#${ios_AllowPopup}    accessibility id:Allow
#${ios_Continue}        Continue
${ios_Continue}        //XCUIElementTypeButton[@name="Continue"]
${ios_GoToSettings}    //XCUIElementTypeButton[@name="Go to settings"]
${ios_LoginToServiceWA}        //XCUIElementTypeButton[@name="Log in to ServiceWA"]
${ios_IAgree}        //XCUIElementTypeButton[@name="I Agree"]
#Dont require Next as we are skipping the setup assistance
${ios_NextLoginCreateDigitalID}        //XCUIElementTypeButton[@name="Next"]
${ios_ReadyToBegin}        //XCUIElementTypeButton[@name="I’m ready to begin"]
${ios_ContinueWithDigitalID}        //XCUIElementTypeLink[@name="gov-pass-image Continue with Digital ID"]
${ios_SkipSetup}        //XCUIElementTypeButton[@name="Skip for now"]
${ios_myID}        //XCUIElementTypeStaticText[@name="myID"]
#${ios_RememberMyChoice}        (//XCUIElementTypeSwitch[@name="Remember my choice (Not recommended for shared devices)"])[2]
${ios_SelectMyID}        //XCUIElementTypeButton[@name="Select myID"]
${ios_EnterMyIDEmail}       //XCUIElementTypeTextField
#${ios_EnterMyIDEmail}    //XCUIElementTypeTextField[@name="myID email"]
#${ios_EnterMyIDEmail}    //XCUIElementTypeTextField[@label=""]
#//XCUIElementTypeTextField[@name="myID email"]
${ios_GetCode}        //XCUIElementTypeButton[@name="Get code"]
${ios_VerifyEmail}        //XCUIElementTypeStaticText[@name="Email"]
${ios_Consent}        //XCUIElementTypeButton[@name="Consent"]
${ios_SkipForNow}        //XCUIElementTypeButton[@name="Skip for now"]
${ios_YesSkip}        //XCUIElementTypeButton[@name="Yes, skip"]
${ios_LogOut}        //XCUIElementTypeButton[@name="Log out"]
${ios_Confirm}    //XCUIElementTypeButton[@name="Confirm"]
${ios_Close}        //XCUIElementTypeButton[@name="Close"]
${ios_Home}        //XCUIElementTypeStaticText[@name="Home"]
${ios_Discovery}    //XCUIElementTypeStaticText[@name="Discovery"]
${ios_Passes}       //XCUIElementTypeStaticText[@name="Passes"]
${ios_Inbox}        //XCUIElementTypeStaticText[@name="Inbox"]


*** Keywords ***
Verify page loaded
    IF  "%{EXECUTION_PLATFORM}" == "Mobile"
        AppiumLibrary.Wait until page contains      email
    ELSE
        SeleniumLibrary.Wait until page contains      email
    END


Enter email
    Common.Enter Text   ${LOGIN-EMAIL}      ${USER_DETAILS}[username]   LoginID
#    Input Text      ${LOGIN-EMAIL}      ${USER_DETAILS}[username]
#    Log To Console    Entered Login ID: ${USER_DETAILS}[username]
#    Write Extent Test Steps          Entered Login ID: ${USER_DETAILS}[username]                 Pass            True
#    Write Extent Test Steps          Entered Login ID: ${USER_DETAILS}[username]                  Pass            True

Enter Password
    Common.Enter Text   ${LOGIN-PASSWORD-FIELD}     ${USER_DETAILS}[password]   Password
#    Input Text    ${LOGIN-PASSWORD-FIELD}     ${USER_DETAILS}[password]
#    Log To Console    Entered Password
#    Write Extent Test Steps          Entered Password: ${USER_DETAILS}[password]                 Pass            True
#    Write Extent Test Steps          Entered Password                 Pass            True


Tap SignIn
    Common.Click Element    ${SIGNIN-BUTTON}
    Log To Console    Tapped on SingIn Button
    Write Extent Test Steps          Tapped on SignIn Button                 Pass            True

#Login to the App
Before login to App
    [Documentation]    Keyword to Login to Mobile Application through Shopping Cart
#    [Arguments]    ${User Name}    ${Password}
    
    Log        Inside ~ Login to the App
    Sleep    10    Wait for all context to be available
    ${contexts}    Get Contexts
    Log        Contexts:-${contexts}
    ${context}      Get Current Context
    ${STATUS}       Evaluate   "WEBVIEW" in """${context}"""

    Log        Context: ${context}
    Log        Status : ${STATUS}

    Log to console      Device OS : %{Device OS}
    IF  "%{Device OS}" == "iOS"
        Set iosServiceWA xpathvalues to variables
    ELSE
        Log To Console    Executing in Android
    END

#    AppiumCommon.Scroll Down And Click    ${GotIt}
      Swipe     0    495    0    150
            Swipe     0    495    0    150
                Swipe     0    495    0    150
                    Swipe     0    495    0    150
    Common.Wait for Element Visibility    ${GotIt}   GotIt Button
    ${GotItButton_Visible} =   Run Keyword And Return Status  AppiumLibrary.Element Should Be Visible    ${GotIt}
    Log        GotIt Button Visibility : ${GotItButton_Visible}
    Common.Click Button    ${GotIt}    GotItButton

    Common.Wait for Element Visibility    ${Done}   Done Button
    Common.Click Button    ${Done}    Done
    
    AppiumCommon.Click OK If Present     ${Ok}    ${Continue}    timeout=2s

Login to the App

     [Documentation]    Login to ServiceWA Mobile App
#     [Arguments]    ${User Name}    ${Password}
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
#
#    Log to console      Device OS : %{Device OS}
#    IF  "%{Device OS}" == "iOS"
#        Set iosServiceWA xpathvalues to variables
#    ELSE
#        Log To Console    Executing in Android
#    END
#    Swipe     0    495    0    150
#    Common.Scroll To Given Element  ${GoToSettings}
    Common.Wait for Element Visibility    ${GoToSettings}   Settings Icon
    Common.Click Button    ${GoToSettings}    GoToSettings

    Common.Wait for Element Visibility    ${LoginToServiceWA}   LoginToServiceWA Button
    Common.Click Button    ${LoginToServiceWA}    LoginToServiceWA
    Swipe     0    495    0    150
            Swipe     0    495    0    150
                Swipe     0    495    0    150
                    Swipe     0    495    0    150

#   Common.Scroll To Given Element   ${IAgree}
    Common.Wait for Element Visibility    ${IAgree}   IAgree Button
    Common.Element Should Be Enabled   ${IAgree}
    Common.Click Button    ${IAgree}    IAgree


    Common.Wait for Element Visibility    ${NextLoginCreateDigitalID}   Next Button
    Common.Element Should Be Enabled   ${NextLoginCreateDigitalID}
    Common.Click Button    ${NextLoginCreateDigitalID}    Next

    Common.Wait for Element Visibility    ${ReadyToBegin}   ReadyToBegin Button
    Common.Element Should Be Enabled   ${ReadyToBegin}
    Common.Click Button    ${ReadyToBegin}    ReadyToBegin

    Common.Wait for Element Visibility    ${ContinueWithDigitalID}   ContinueWithDigitalID Link
    Common.Element Should Be Enabled   ${ContinueWithDigitalID}
#    Common.Click Button    ${ContinueWithDigitalID}    ContinueWithDigitalID
     Common.Click Mobile Element   ${ContinueWithDigitalID}


      Swipe     0    495    0    150
            Swipe     0    495    0    150
                Swipe     0    495    0    150
                    Swipe     0    495    0    150

    Common.Wait for Element Visibility    ${SelectMyID}   SelectMyID Button
    Common.Element Should Be Enabled   ${SelectMyID}
    Common.Click Button    ${SelectMyID}    SelectMyID

#     Wait Until Page Contains Element    ${EnterMyIDEmail}
#     Common.Element Should Be Enabled   ${EnterMyIDEmail}
#     Input Text    ${EnterMyIDEmail}     TRANCHETWOABV@TestWapol.com.au
     
#     Common.Enter Text     ${EnterMyIDEmail}  TRANCHETWOABV@TestWapol.com.au  EmailID
     Sleep    10s
     AppiumCommon.Wait for Element Present    ${EnterMyIDEmail}
     Common.Click Element    ${EnterMyIDEmail}
     AppiumLibrary.Input Text     ${EnterMyIDEmail}   TRANCHETWOABV@TestWapol.com.au
     log     ${EnterMyIDEmail}
#     AppiumLibrary.Input Text    id=0A000000-0000-0000-A905-000000000000    TRANCHETWOABV@TestWapol.com.au

    Common.Wait for Element Visibility    ${GetCode}    SGetCode Button
    Common.Element Should Be Enabled   ${GetCode}
    Common.Click Button    ${GetCode}     GetCode

        Swipe     0    495    0    150
            Swipe     0    495    0    150
                Swipe     0    495    0    150
                  Swipe     0    495    0    150

    Common.Wait for Element Visibility    ${Consent}     Consent Button
    Common.Element Should Be Enabled   ${Consent}
    Common.Click Button    ${Consent}      Consent

    Swipe     0    495    0    150
            Swipe     0    495    0    150
                Swipe     0    495    0    150
                  Swipe     0    495    0    150

    Common.Wait for Element Visibility    ${SecondConsent}    FinalConsent Button
    Common.Element Should Be Enabled   ${SecondConsent}
    Common.Click Button    ${SecondConsent}       FinalConsent

    Common.Wait for Element Visibility    ${Done}    Done Button
    Common.Element Should Be Enabled   ${Done}
    Common.Click Button    ${Done}       Done

    Common.Wait for Element Visibility    ${SkipForNow}    SkipForNow Button
    Common.Element Should Be Enabled   ${SkipForNow}
    Common.Click Button    ${SkipForNow}       SkipForNow

    Common.Wait for Element Visibility    ${YesSkip}    YesSkip Button
    Common.Element Should Be Enabled   ${YesSkip}
    Common.Click Button    ${YesSkip}       YesSkip

    Common.Wait for Element Visibility    ${LogOut}    LogOut Button
    Log to Console  Logout Element is present ${LogOut}

#    Common.Wait for Element Visibility    ${Close}    Close Button
#    Common.Element Should Be Enabled   ${Close}
#    Common.Click Button    ${Close}       Close

Check Element Locators to be use
    Log to console      Device OS : %{Device OS}
    IF  "%{Device OS}" == "iOS"
        ${LOGIN-EMAIL}=      Set Variable   //XCUIElementTypeTextField[@name="email_text_field"]
        ${LOGIN-PASSWORD-FIELD}=      Set Variable   //XCUIElementTypeTextField[@name="password_text_field"]
        ${SIGNIN-BUTTON}=        Set Variable   //XCUIElementTypeButton[@name="sign_in_button"]
        Set Suite Variable      ${LOGIN-EMAIL}      //XCUIElementTypeTextField[@name="email_text_field"]
        Set Suite Variable      ${LOGIN-PASSWORD-FIELD}      //XCUIElementTypeTextField[@name="password_text_field"]
        Set Suite Variable      ${SIGNIN-BUTTON}      //XCUIElementTypeButton[@name="sign_in_button"]

        Log to console      Using IOS Element Locators
        Log to console      LOGIN-EMAIL: ${LOGIN-EMAIL}
    END

Perform logout from Consumer Potal
    SeleniumLibrary.Wait Until Element Is Visible    ${Loggedin_User}   timeout=60s
    ${PageLoadCheck}=            Run Keyword And Return Status              SeleniumLibrary.Wait Until Page Contains Element     ${Loggedin_User}        timeout=60s
    IF      ${PageLoadCheck}==True
            Log To Console                Logged in user details isplayed
            SeleniumLibrary.Click Element    ${Loggedin_User}
            Sleep    2s
            SeleniumLibrary.Click Element    ${SignOut_Web}
            Common.Wait for Element Visibility    ${WEB_Email}    Loginfield is verified
            Write Extent Test Steps        Validated Successful Logout	         Pass       True
             ELSE
            Log To Console                  Logout Failed
            Write Extent Test Steps         Loginout Failed	         Fail       True
    END

Set iosServiceWA xpathvalues to variables
    Log To Console    *** overriding the Android keyword values to iOS ***
    Set Suite Variable   ${GotIt}    ${ios_GotIt}
    Set Suite Variable      ${Done}    ${ios_Done}
    Set Suite Variable      ${Ok}    ${ios_Ok}
    Set Suite Variable      ${AllowPopup}    ${ios_AllowPopup}
    Set Suite Variable      ${Continue}    ${ios_Continue}
    Set Suite Variable      ${GoToSettings}    ${ios_GoToSettings}
    Set Suite Variable      ${LoginToServiceWA}    ${ios_LoginToServiceWA}
    Set Suite Variable      ${IAgree}    ${ios_IAgree}
    Set Suite Variable      ${NextLoginCreateDigitalID}    ${ios_NextLoginCreateDigitalID}
    Set Suite Variable      ${ReadyToBegin}    ${ios_ReadyToBegin}
    Set Suite Variable      ${ContinueWithDigitalID}    ${ios_ContinueWithDigitalID}
    Set Suite Variable      ${SkipSetup}    ${ios_SkipSetup}
    Set Suite Variable      ${myID}    ${ios_myID}
    Set Suite Variable      ${SelectMyID}    ${ios_SelectMyID}
    Set Suite Variable      ${EnterMyIDEmail}    ${ios_EnterMyIDEmail}
    Set Suite Variable      ${GetCode}    ${ios_GetCode}
    Set Suite Variable      ${Consent}    ${ios_Consent}
    Set Suite Variable      ${SecondConsent}    ${ios_Consent}
    Set Suite Variable      ${SkipForNow}    ${ios_SkipForNow}
    Set Suite Variable      ${YesSkip}    ${ios_YesSkip}
    Set Suite Variable      ${LogOut}    ${ios_LogOut}
    Set Suite Variable      ${Close}    ${ios_Close}
    Set Suite Variable      ${Home}    ${ios_Home}
    Set Suite Variable      ${Discovery}    ${ios_Discovery}
    Set Suite Variable      ${Passes}    ${ios_Passes}
    Set Suite Variable      ${Inbox}    ${ios_Inbox}
    Set Suite Variable      ${Confirm}    ${ios_Confirm}







