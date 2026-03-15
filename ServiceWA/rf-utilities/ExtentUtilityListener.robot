*** Settings ***
Library         ../rf-utilities/ExtentReportListener.py

*** Keywords ***

Write Extent Test Steps
    [Arguments]     ${TestStepDescription}                            ${TestStepStatus}                 ${ScreenshotFlag}
    ${TestCaseID}=         Set Variable                %{TCID}
    ${PathFinder}=      createUserDirectory                          ${TestCaseID}                     ${ScreenshotFlag}
    Log to console      EXECUTION_PLATFORM : %{EXECUTION_PLATFORM}
    Log to console      ScreenshotFlag : ${ScreenshotFlag}
    Log to console      CaptureScreenShotsOnlyForFailure : %{CaptureScreenShotsOnlyForFailure}

    IF  "%{CaptureScreenShotsOnlyForFailure}" == "True"
        IF  "${TestStepStatus}" == "Pass"
            Log to console  ~~TrueOne~~
            ${ScreenshotFlag}    Set Variable    False
        END
    END

    IF  '${ScreenshotFlag}'!='None'
        Log to console      Inside IF
        ${TestStepsFileName}=       Set Variable                PassedStep.jpg
        Sleep      1
        IF  "${ScreenshotFlag}" == "True"
            IF  "%{EXECUTION_PLATFORM}" == "Mobile"
                AppiumLibrary.Capture Page Screenshot                 ${PathFinder}/${TestStepsFileName}
            ELSE
                SeleniumLibrary.Capture Page Screenshot                 ${PathFinder}/${TestStepsFileName}
            END
            Extent TestCaseSteps                    ${TestStepDescription}                     ${TestStepStatus}             ${PathFinder}/${TestStepsFileName}
        ELSE
            Extent TestCaseSteps                    ${TestStepDescription}                     ${TestStepStatus}             None
        END
    ELSE
        Log to console      Inside ELSE
        Extent TestCaseSteps                    ${TestStepDescription}                     ${TestStepStatus}             None
    END

Write Extent Test Steps On Fail
    [Arguments]     ${TestStepDescription}             ${TestCaseID}                ${TestStepStatus}                 ${ScreenshotFlag}
    ${PathFinder}=      createUserDirectory                          ${TestCaseID}                     ${ScreenshotFlag}
    IF            '${PathFinder}'!='None'
          ${TestStepsFileName}=       Set Variable                FailedStep.jpg
          Sleep      1
          IF  "%{EXECUTION_PLATFORM}" == "Mobile"
            AppiumLibrary.Capture Page Screenshot                 ${PathFinder}/${TestStepsFileName}
          ELSE
            SeleniumLibrary.Capture Page Screenshot                 ${PathFinder}/${TestStepsFileName}
          END
          Extent TestCaseSteps                    ${TestStepDescription}                     ${TestStepStatus}             ${PathFinder}/${TestStepsFileName}
    ELSE
          Extent TestCaseSteps                    ${TestStepDescription}                     ${TestStepStatus}             None
    END


Validate Final Test Step For Extent
    [Arguments]             ${CurrentTestCaseStatus}                 ${Message}                 ${TAGS}
    Log to console  ** Validating the Final Test Step and write to reports **
    Run Keyword If Test Failed                        Write Extent Test Steps On Fail                         ${Message}                    ${TAGS}                  ${CurrentTestCaseStatus}                    True
    Log to console  ~~ Write Skipped Test Details ~~
    Run Keyword If  '${CurrentTestCaseStatus}' == 'SKIP'    log    Test Case ${TAGS} Has Been Skipped
    Log to Console  ~~ Closing the application ~~
    Common.Close Application
    Log to Console  ***** Closed the application *****