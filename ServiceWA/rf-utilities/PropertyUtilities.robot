*** Settings ***
Library     ReadConfig_Properties.py
Library    OperatingSystem


*** Variables ***
${PROPERTY FILE PATH}=      rf-config/Config.properties



*** Keywords ***
Load Config Properties Data
    [Documentation]  Keyword wrapper to load the properties file
    &{Load Prop}=      Read Properties  ${PROPERTY FILE PATH}
    Log To Console    ${Load Prop}[ConnectionURL]
    
    Set Environment Variable    MobileTestExecutionPlatform    ${Load Prop}[MobileTestExecutionPlatform]
    Set Environment Variable    ANDROID_DEVICE_NAME    ${Load Prop}[AndroidDeviceName]
    Set Environment Variable    IOS_DEVICE_NAME    ${Load Prop}[iOSDeviceName]
    Set Environment Variable    CONNECTION_URL    ${Load Prop}[ConnectionURL]
    Set Environment Variable    TEST_TYPE        ${Load Prop}[TestType]
    Set Environment Variable    USER_ACCOUNT    ${Load Prop}[UserAccount]
    Set Environment Variable    PIPELINE_EXECUTION    ${Load Prop}[PIPELINE_EXECUTION]
    Set Environment Variable    MOBILE_VIEW    ${Load Prop}[QA_URL]
    Set Environment Variable    EXECUTION_PLATFORM    ${Load Prop}[ExecutionPlatform]
    
    Set Environment Variable    APP_URL    ${Load Prop}[App_URL]
    Set Environment Variable    BROWSER    ${Load Prop}[Browser]
    Set Environment Variable    MOBILE_VIEW    ${Load Prop}[QA_URL]

    
    Set Environment Variable    CaptureScreenShotsOnlyForFailure    ${Load Prop}[CaptureScreenShotsOnlyForFailure]
    Set Environment Variable    BASE_URL    ${Load Prop}[BASE_URL]
    
    Log        Execution Platform is ${Load Prop}[OS_ExecutionPlatform]
    IF  "${Load Prop}[OS_ExecutionPlatform]" == "Android"
        Set Environment Variable    DEVICE_NAME    ${Load Prop}[AndroidDeviceName]
        Set Environment Variable    APP_PATH    ${Load Prop}[App_Path_Android]
    ELSE
        Set Environment Variable    DEVICE_NAME    ${Load Prop}[iOSDeviceName]
        Set Environment Variable    APP_PATH    ${Load Prop}[App_Path_iOS]
    END
        


    RETURN  &{Load Prop}
