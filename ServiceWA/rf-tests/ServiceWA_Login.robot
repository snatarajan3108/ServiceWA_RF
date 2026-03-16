*** Settings ***
Documentation  These test cases used for checking Login Options by using ServiceWA Android app

Resource  ../rf-driverutils/AppiumCommon.robot
Resource  ../Resources/Common.robot  # necessary for Setup & Teardown
 # necessary for lower level keywords in test cases
Library   ../rf-utilities/ExtentReportListener.py
Resource  ../rf-utilities/ExtentUtilityListener.robot
Resource    ../rf-pageobjects/SignInScreen.robot

#Test Setup      Launch Mobile Application     MobileConfig.xlsx   AppiumConfig

Suite Setup     Extent Report Creation
Suite Teardown  Common.Close Application

#*** Variables ***
#
*** Test Cases ***

#Stability_TC_01_Mobile Before login Steps
#        Log to Console  *************************************** User to perform Login & logout from  Mobile app ***************************************
#        [Tags]  Login001       Smoke      Regression
#         &{prop}=    Load Config Properties Data
#         &{TestData}=   Load Test Data From File   TestData.xlsx   ServiceWA  Login001
#        log to console      Login001
#        Set Environment Variable            TCID                    ${TestData.TestcaseID}
#        #Skip If    "${TestData.Execute}" != "Y"    Test Not Selected for Execution
#        Extent TestCaseHeader                 ${TEST NAME}        ${TestData.TestcaseID}          ServiceWA Application
##        Log   DeviceName-> %{DEVICE_NAME}
#        # Common.Launch Application    $File Path    $Sheet Name    $App Name
#        Log      Launching Application
#        Common.Launch Application     MobileConfig.xlsx   AppiumConfig  ${prop.App_URL}
#        SignInScreen.Before login to App    #username@servicewa.com    myPassword

Stability_TC_02_Mobile Validation of login
        Log to Console  *************************************** User to perform Login & logout from  Mobile app ***************************************
        [Tags]  Login001       Smoke      Regression
         &{prop}=    Load Config Properties Data
         &{TestData}=   Load Test Data From File   TestData.xlsx   ServiceWA  Login001
        log to console      Login001
        Set Environment Variable            TCID                    ${TestData.TestcaseID}
        #Skip If    "${TestData.Execute}" != "Y"    Test Not Selected for Execution
        Extent TestCaseHeader                 ${TEST NAME}        ${TestData.TestcaseID}          ServiceWA Application
#        Log   DeviceName-> %{DEVICE_NAME}
        # Common.Launch Application    $File Path    $Sheet Name    $App Name
        Log      Launching Application
        Common.Launch Application     MobileConfig.xlsx   AppiumConfig  ${prop.App_URL}
        SignInScreen.Before login to App
        SignInScreen.Login to the App    username@servicewa.com    myPassword



#Stability_TC_02_Mobile App_Validation of login and logout
#
#        Log to Console  *************************************** User to perform Login & logout from  Mobile app ***************************************
#        [Tags]  Login001       Smoke      Regression
#         &{prop}=    Load Config Properties Data
#         &{TestData}=   Load Test Data From File   TestData.xlsx   ServiceWA  Login001
#        log to console      Login001
#        Set Environment Variable            TCID                    ${TestData.TestcaseID}
#        #Skip If    "${TestData.Execute}" != "Y"    Test Not Selected for Execution
#        Extent TestCaseHeader                 ${TEST NAME}        ${TestData.TestcaseID}          iComfort Application
#        Log   DeviceName-> %{DEVICE_NAME}
#        # Common.Launch Application    $File Path    $Sheet Name    $App Name
#        Log      Launching Application
#        Common.Launch Application     MobileConfig.xlsx   AppiumConfig  ${prop.App_URL}
##       SignInScreen.Set ios xpathvalues to variables
##        SignInScreen.Login to the App    username@servicewa.com    myPassword

