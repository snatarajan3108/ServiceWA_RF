*** Settings ***
Resource    ../rf-pageobjects/SignInScreen.robot
Resource    ../rf-pageobjects/HomeScreen.robot
Library    ../rf-utilities/ExtentReportListener.py
Resource        ../rf-utilities/ExtentUtilityListener.robot

*** Keywords ***

User checks to log In
    Log   Check to see user is able to log in

User enters valid email and password
    Create ExtentNode       Login to the Application
    SignInScreen.Verify page loaded
    SignInScreen.Enter email
    SignInScreen.Enter Password
    SignInScreen.Tap SignIn
    Write Extent Test Steps          Clicking on SIGN IN Button                 Pass            True


User should successfully logs In
    HomeScreen.Verify page loaded
    
user increase temperature
    [Arguments]     ${temp}
    HomeScreen.Increase Temperature    ${temp}

user decrease temperature
    [Arguments]     ${temp}
    HomeScreen.Decrease Temperature    ${temp}

verify set temperature after increase
     HomeScreen.Verify Set by Temperature Increase

verify set temperature after decrease
    HomeScreen.Verify Set by Temperature Decrease

Validate the current mode
    [Arguments]     ${mode}
    TRY
        Log to console  Change Mode is (SET-MODE-TEXT) : ${SET-MODE-TEXT}
        HomeScreen.Verify the current mode     ${SET-MODE-TEXT}
    EXCEPT
        HomeScreen.Verify the current mode     ${mode}
    END