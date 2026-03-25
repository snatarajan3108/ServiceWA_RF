*** Settings ***
Documentation  These test cases used for checking all the linkable Services able to link withoutLogin Options by using ServiceWA app

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
        [Tags]  LinkableService001       Smoke      Regression
         &{prop}=    Load Config Properties Data
         &{TestData}=   Load Test Data From File   TestData.xlsx   ServiceWA  Login001
        log to console      Login001
        Set Environment Variable            TCID                    ${TestData.TestcaseID}
        #Skip If    "${TestData.Execute}" != "Y"    Test Not Selected for Execution
        Extent TestCaseHeader                 ${TEST NAME}        ${TestData.TestcaseID}          ServiceWA Application
        Log   DeviceName-> %{DEVICE_NAME}
        # Common.Launch Application    $File Path    $Sheet Name    $App Name
        Log      Launching Application
        Common.Launch Application     MobileConfig.xlsx   AppiumConfig  ${prop.App_URL}
        SignInScreen.Before login to App
        LinkableService.Link To The FishCatchWA

Stability_TC_01_Mobile validate_ Linkable service FuelWatch
        Log to Console  *************************************** User to Linkable service FishCatchWA from  Mobile app ***************************************
        [Tags]  LinkableService002       Smoke      Regression
         &{prop}=    Load Config Properties Data
         &{TestData}=   Load Test Data From File   TestData.xlsx   ServiceWA  Login001
        log to console      LinkableService002
        Set Environment Variable            TCID                    ${TestData.TestcaseID}
        #Skip If    "${TestData.Execute}" != "Y"    Test Not Selected for Execution
        Extent TestCaseHeader                 ${TEST NAME}        ${TestData.TestcaseID}          ServiceWA Application
#        Log   DeviceName-> %{DEVICE_NAME}
        # Common.Launch Application    $File Path    $Sheet Name    $App Name
        Log      Launching Application
        Common.Launch Application     MobileConfig.xlsx   AppiumConfig  ${prop.App_URL}
        SignInScreen.Before login to App
        LinkableService.Link to the FuelWatch

Stability_TC_01_Mobile validate_ Linkable service SharkSmart
        Log to Console  *************************************** User to Linkable service FishCatchWA from  Mobile app ***************************************
        [Tags]  LinkableService003       Smoke      Regression
         &{prop}=    Load Config Properties Data
         &{TestData}=   Load Test Data From File   TestData.xlsx   ServiceWA  Login001
        log to console      LinkableService003
        Set Environment Variable            TCID                    ${TestData.TestcaseID}
        #Skip If    "${TestData.Execute}" != "Y"    Test Not Selected for Execution
        Extent TestCaseHeader                 ${TEST NAME}        ${TestData.TestcaseID}          ServiceWA Application
#        Log   DeviceName-> %{DEVICE_NAME}
        # Common.Launch Application    $File Path    $Sheet Name    $App Name
        Log      Launching Application
        Common.Launch Application     MobileConfig.xlsx   AppiumConfig  ${prop.App_URL}
        SignInScreen.Before login to App
        LinkableService.Link to the SharkSmart


Stability_TC_01_Mobile validate_ Linkable service OnlineLicenceSearch
        Log to Console  *************************************** User to Linkable service FishCatchWA from  Mobile app ***************************************
        [Tags]  LinkableService004       Smoke      Regression
         &{prop}=    Load Config Properties Data
         &{TestData}=   Load Test Data From File   TestData.xlsx   ServiceWA  Login001
        log to console      LinkableService004
        Set Environment Variable            TCID                    ${TestData.TestcaseID}
        #Skip If    "${TestData.Execute}" != "Y"    Test Not Selected for Execution
        Extent TestCaseHeader                 ${TEST NAME}        ${TestData.TestcaseID}          ServiceWA Application
#        Log   DeviceName-> %{DEVICE_NAME}
        # Common.Launch Application    $File Path    $Sheet Name    $App Name
        Log      Launching Application
        Common.Launch Application     MobileConfig.xlsx   AppiumConfig  ${prop.App_URL}
        SignInScreen.Before login to App
        LinkableService.Link to the OnlineLicenceSearch

Stability_TC_01_Mobile validate_ Linkable service WeatherStations
        Log to Console  *************************************** User to Linkable service FishCatchWA from  Mobile app ***************************************
        [Tags]  LinkableService005      Smoke      Regression
         &{prop}=    Load Config Properties Data
         &{TestData}=   Load Test Data From File   TestData.xlsx   ServiceWA  Login001
        log to console      LinkableService004
        Set Environment Variable            TCID                    ${TestData.TestcaseID}
        #Skip If    "${TestData.Execute}" != "Y"    Test Not Selected for Execution
        Extent TestCaseHeader                 ${TEST NAME}        ${TestData.TestcaseID}          ServiceWA Application
#        Log   DeviceName-> %{DEVICE_NAME}
        # Common.Launch Application    $File Path    $Sheet Name    $App Name
        Log      Launching Application
        Common.Launch Application     MobileConfig.xlsx   AppiumConfig  ${prop.App_URL}
        SignInScreen.Before login to App
        LinkableService.Link to the WeatherStations

Stability_TC_01_Mobile validate_ Linkable service UnclaimedMoney
        Log to Console  *************************************** User to Linkable service FishCatchWA from  Mobile app ***************************************
        [Tags]  LinkableService006      Smoke      Regression
         &{prop}=    Load Config Properties Data
         &{TestData}=   Load Test Data From File   TestData.xlsx   ServiceWA  Login001
        log to console      LinkableService006
        Set Environment Variable            TCID                    ${TestData.TestcaseID}
        #Skip If    "${TestData.Execute}" != "Y"    Test Not Selected for Execution
        Extent TestCaseHeader                 ${TEST NAME}        ${TestData.TestcaseID}          ServiceWA Application
#        Log   DeviceName-> %{DEVICE_NAME}
        # Common.Launch Application    $File Path    $Sheet Name    $App Name
        Log      Launching Application
        Common.Launch Application     MobileConfig.xlsx   AppiumConfig  ${prop.App_URL}
        SignInScreen.Before login to App
        LinkableService.Link to the UnclaimedMoney

Stability_TC_01_Mobile validate_ Linkable service Offers
        Log to Console  *************************************** User to Linkable service FishCatchWA from  Mobile app ***************************************
        [Tags]  LinkableService007      Smoke      Regression
         &{prop}=    Load Config Properties Data
         &{TestData}=   Load Test Data From File   TestData.xlsx   ServiceWA  Login001
        log to console      LinkableService007
        Set Environment Variable            TCID                    ${TestData.TestcaseID}
        #Skip If    "${TestData.Execute}" != "Y"    Test Not Selected for Execution
        Extent TestCaseHeader                 ${TEST NAME}        ${TestData.TestcaseID}          ServiceWA Application
#        Log   DeviceName-> %{DEVICE_NAME}
        # Common.Launch Application    $File Path    $Sheet Name    $App Name
        Log      Launching Application
        Common.Launch Application     MobileConfig.xlsx   AppiumConfig  ${prop.App_URL}
        SignInScreen.Before login to App
        LinkableService.Link to the Offers

#Stability_TC_01_Mobile validate_ Linkable service LearnAndLog
#        Log to Console  *************************************** User to Linkable service FishCatchWA from  Mobile app ***************************************
#        [Tags]  LinkableService008      Smoke      Regression
#         &{prop}=    Load Config Properties Data
#         &{TestData}=   Load Test Data From File   TestData.xlsx   ServiceWA  Login001
#        log to console      LinkableService008
#        Set Environment Variable            TCID                    ${TestData.TestcaseID}
#        #Skip If    "${TestData.Execute}" != "Y"    Test Not Selected for Execution
#        Extent TestCaseHeader                 ${TEST NAME}        ${TestData.TestcaseID}          ServiceWA Application
##        Log   DeviceName-> %{DEVICE_NAME}
#        # Common.Launch Application    $File Path    $Sheet Name    $App Name
#        Log      Launching Application
#        Common.Launch Application     MobileConfig.xlsx   AppiumConfig  ${prop.App_URL}
#        SignInScreen.Before login to App
##        LinkableService.Link to the Offers

#Stability_TC_01_Mobile validate_ All Linkable service for UnauthorizedUsers
#        Log to Console  *************************************** User to Linkable service FishCatchWA from  Mobile app ***************************************
#        [Tags]  LinkableService009      Smoke      Regression
#         &{prop}=    Load Config Properties Data
#         &{TestData}=   Load Test Data From File   TestData.xlsx   ServiceWA  Login001
#        log to console      LinkableService009
#        Set Environment Variable            TCID                    ${TestData.TestcaseID}
#        #Skip If    "${TestData.Execute}" != "Y"    Test Not Selected for Execution
#        Extent TestCaseHeader                 ${TEST NAME}        ${TestData.TestcaseID}          ServiceWA Application
##        Log   DeviceName-> %{DEVICE_NAME}
#        # Common.Launch Application    $File Path    $Sheet Name    $App Name
#        Log      Launching Application
#        Common.Launch Application     MobileConfig.xlsx   AppiumConfig  ${prop.App_URL}
#        SignInScreen.Before login to App
#        LinkableService.Link to the WeatherStations
#        LinkableService.Link to the OnlineLicenceSearch
#        LinkableService.Link to the SharkSmart
#        LinkableService.Link to the FuelWatch
#        LinkableService.Link to the UnclaimedMoney
#        LinkableService.Link to the Offers