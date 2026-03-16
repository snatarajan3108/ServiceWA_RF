*** Settings ***
Documentation  These test cases used for checking Login Options by using ServiceWA app

Resource  ../rf-driverutils/AppiumCommon.robot
Resource  ../Resources/Common.robot  # necessary for Setup & Teardown
 # necessary for lower level keywords in test cases
Library   ../rf-utilities/ExtentReportListener.py
Resource  ../rf-utilities/ExtentUtilityListener.robot
Resource    ../rf-pageobjects/SignInScreen.robot
Resource    ../rf-pageobjects/LinkableService.robot

#Test Setup      Launch Mobile Application     MobileConfig.xlsx   AppiumConfig

Suite Setup     Extent Report Creation
Suite Teardown  Common.Close Application


*** Test Cases ***
Stability_TC_01_Mobile validate_ Linkable service FishCatchWA
        Log to Console  *************************************** User to Linkable service FishCatchWA from  Mobile app ***************************************
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
        SignInScreen.Before login to App    #username@servicewa.com    myPassword
        LinkableService.Link To The FishCatchWA




