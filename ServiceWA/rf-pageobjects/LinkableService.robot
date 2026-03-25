*** Settings ***
Library    AppiumLibrary
Resource    ../rf-data/password.robot
Library    ../rf-utilities/ExtentReportListener.py
Resource    ../rf-utilities/ExtentUtilityListener.robot
Resource    ../rf-utilities/ExtentUtilityListener.robot
Resource    ../Resources/Common.robot
Resource  ../rf-driverutils/AppiumCommon.robot
Resource    ../rf-pageobjects/SignInScreen.robot


*** Variables ***
#Android
#Common indentiFier Details
${LinkableServices}    ///android.view.View[@content-desc="Linkable services"]
${Next}    //android.widget.Button[@content-desc="Next"]
${IAgree}    //android.widget.Button[@content-desc="I Agree"]
${Linked}    //android.view.View[@content-desc="Linked"]
# FishCatchWA
${FishCatchWA}        //android.view.View[@content-desc="FishCatchWA"]
${BackToServiceWA}    //android.widget.ImageView[@content-desc="ServiceWA"]
# FuelWatch,SharkSmart, Online licence search,Weather stations,Unclaimed money,Learnlog
${FuelWatch}    //android.view.View[@content-desc="FuelWatch"]
${AcceptLocationServices}    //android.widget.Button[@content-desc="Accept location services"]
${FuelWatchBackToServiceWA}    //android.widget.Button[@content-desc="Back to ServiceWA"]
${SharkSmart}    //android.view.View[@content-desc="FuelWatch"]
${AcknowledgeAndContinue}    //android.view.View[@content-desc="FuelWatch"]
${OnlineLicenceSearch}    //XCUIElementTypeOther[@name="Online licence search"]
${Continue}    //XCUIElementTypeButton[@name="Continue"]
${WeatherStations}    //XCUIElementTypeOther[@name="Weather stations"]
${UnclaimedMoney}    //XCUIElementTypeOther[@name="Unclaimed money"]
${Offers}    //XCUIElementTypeOther[@name="Offers"]
${Discovery}     //XCUIElementTypeStaticText[@name="Discovery"]
${Learn&Log}     //XCUIElementTypeOther[@name="Learn&Log"]

# IOS
#***Common IndentiFier details ***
${ios_Next}    //XCUIElementTypeButton[@name="Next"]
${ios_IAgree}    //XCUIElementTypeButton[@name="I Agree"]
${ios_Linked}    //XCUIElementTypeStaticText[@name="Linked"]
${ios_LinkableServices}    //XCUIElementTypeStaticText[@name="Linkable services"]
#FishCatch
${ios_FishCatchWA}        //XCUIElementTypeOther[@name="FishCatchWA"]
#${ios_BackToServiceWA}    //XCUIElementTypeImage[@name="ServiceWA"]
#${ios_BackToServiceWA}    //XCUIElementTypeImage[@label="ServiceWA"]
#${ios_BackToServiceWA}    //XCUIElementTypeImage[@name="ServiceWA" or @label="ServiceWA"]
${ios_BackToServiceWA}    accessibility_id=ServiceWA
#${ios_BackToServiceWA}    //XCUIElementTypeApplication[@name="service double you ay"]/following-sibling::*[XCUIElementTypeImage[@name="ServiceWA"]]
# FuelWatch,SharkSmart, Online licence search,Weather stations,Unclaimed money,Offers
${ios_FuelWatch}    //XCUIElementTypeOther[@name="FuelWatch"]
${ios_SharkSmart}    //XCUIElementTypeOther[@name="SharkSmart"]
${ios_AcceptLocationServices}    //XCUIElementTypeButton[@name="Accept location services"]
${ios_FuelWatchBackToServiceWA}    //XCUIElementTypeButton[@name="Back to ServiceWA"]
${ios_AcknowledgeAndContinue}    //XCUIElementTypeButton[@name="Acknowledge and continue"]
${ios_OnlineLicenceSearch}    //XCUIElementTypeOther[@name="Online licence search"]
${ios_Continue}    //XCUIElementTypeButton[@name="Continue"]
${ios_WeatherStations}    //XCUIElementTypeOther[@name="Weather stations"]
${ios_UnclaimedMoney}    //XCUIElementTypeOther[@name="Unclaimed money"]
${ios_Offers}    //XCUIElementTypeOther[@name="Offers"]
${ios_Discovery}     //XCUIElementTypeStaticText[@name="Discovery"]
${ios_Learn&Log}     //XCUIElementTypeOther[@name="Learn&Log"]


*** Keywords ***
Link to the FishCatchWA
    [Documentation]    link the FishCatchWA Mobile Application through Discovery
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
     
    Sleep    10s

#   AppiumLibrary.Wait until page contains     ${BackToServiceWA}    timeout=60s
#   AppiumCommon.Wait for Element Present    ${BackToServiceWA}
    Common.Wait for Element Visibility    ${BackToServiceWA}   BackToServiceWA Button
    Common.Element Should Be Enabled   ${BackToServiceWA}
    Common.Click Element    ${BackToServiceWA}
#    Common.Click Button     ${BackToServiceWA}    BackButton

     AppiumLibrary.Element Should Be Visible  ${FishCatchWA}
     Common.Wait for Element Visibility    ${FishCatchWA}
     Common.Wait for Element Visibility    ${Linked}

     Element Name Should Be    ${FishCatchWA}   expected=FishCatchWA
     Element Name Should Be    ${Linked}   expected=Linked

Link to the FuelWatch
    [Documentation]    link the FuelWatch Mobile Application through Discovery
    Log to console      Device OS : %{Device OS}
    IF  "%{Device OS}" == "iOS"
        Set iosLinkServiceWA xpathvalues to variables
    ELSE
        Log To Console    Executing in Android
    END
    Swipe     0    495    0    150
     Common.Wait for Element Visibility    ${LinkableServices}    LinkableServices Button
     Common.Click Button    ${LinkableServices}    LinkableServices

    Common.Wait for Element Visibility    ${FuelWatch}   FuelWatch Button
    ${FuelWatch_Visible} =   Run Keyword And Return Status  AppiumLibrary.Element Should Be Visible    ${FuelWatch}
    Log        FuelWatch Button Visibility : ${FuelWatch_Visible}
    Common.Click Button     ${FuelWatch}    FuelWatch Button

    Common.Wait for Element Visibility    ${Next}   Next Button
    Common.Click Button    ${Next}    Next

        Swipe     0    495    0    150
            Swipe     0    495    0    150
                Swipe     0    495    0    150
                    Swipe     0    495    0    150

#     AppiumCommon.Swipe up screen Range     ${IAgree}
     Common.Wait for Element Visibility    ${IAgree}   IAgree Button
     Common.Element Should Be Enabled   ${IAgree}
     Common.Click Button    ${IAgree}    IAgree
     
     
    Common.Wait for Element Visibility    ${AcceptLocationServices}   AcceptLocationService Button
    Common.Element Should Be Enabled   ${AcceptLocationServices}
    Common.Click Button   ${AcceptLocationServices}    AcceptLocationService
     Sleep   3s
    Common.Wait for Element Visibility    ${FuelWatchBackToServiceWA}    FuelWatchBackToServiceWA Button
    Common.Element Should Be Enabled   ${FuelWatchBackToServiceWA}
    Common.Click Button     ${FuelWatchBackToServiceWA}    BackButton

    Common.Wait for Element Visibility    ${FuelWatch}    FuelWatch Button
    Common.Element Should Be Enabled   ${FuelWatch}
    Common.Wait for Element Visibility    ${Linked}    Linked Button

    Element Name Should Be     ${FuelWatch}   expected=FuelWatch
    Element Name Should Be    ${Linked}   expected=Linked

Link to the SharkSmart
    [Documentation]    link the SharkSmart Mobile Application through Discovery
    Log to console      Device OS : %{Device OS}
    IF  "%{Device OS}" == "iOS"
        Set iosLinkServiceWA xpathvalues to variables
    ELSE
        Log To Console    Executing in Android
    END
    Swipe     0    495    0    150
     Common.Wait for Element Visibility    ${LinkableServices}   LinkableServices Button
     Common.Click Button    ${LinkableServices}    LinkableServices

    Common.Wait for Element Visibility    ${SharkSmart}   SharkSmart Button
    ${FuelWatch_Visible} =   Run Keyword And Return Status  AppiumLibrary.Element Should Be Visible    ${SharkSmart}
    Log        SharkSmart Button Visibility : ${FuelWatch_Visible}
    Common.Click Button     ${SharkSmart}    SharkSmart Button

    Common.Wait for Element Visibility    ${AcknowledgeAndContinue}   AcknowledgeAndContinue Button
    Common.Click Button    ${AcknowledgeAndContinue}    AcknowledgeAndContinue

    Common.Wait for Element Visibility    ${Next}   Next Button
    Common.Click Button    ${Next}    Next

        Swipe     0    495    0    150
            Swipe     0    495    0    150
                Swipe     0    495    0    150
                    Swipe     0    495    0    150

#     AppiumCommon.Swipe up screen Range     ${IAgree}
     Common.Wait for Element Visibility    ${IAgree}   IAgree Button
     Common.Element Should Be Enabled   ${IAgree}
     Common.Click Button    ${IAgree}    IAgree

    Common.Wait for Element Visibility    ${FuelWatchBackToServiceWA}    FuelWatchBackToServiceWA Button
    Common.Element Should Be Enabled   ${FuelWatchBackToServiceWA}
    Common.Click Button     ${FuelWatchBackToServiceWA}    BackButton

     Common.Wait for Element Visibility    ${SharkSmart}    SharkSmart Button
      Common.Element Should Be Enabled   ${SharkSmart}
      Common.Wait for Element Visibility    ${Linked}    Linked Button

     Element Name Should Be     ${SharkSmart}   expected=SharkSmart
     Element Name Should Be    ${Linked}   expected=Linked

Link to the OnlineLicenceSearch
    [Documentation]    link the SharkSmart Mobile Application through Discovery
    Log to console      Device OS : %{Device OS}
    IF  "%{Device OS}" == "iOS"
        Set iosLinkServiceWA xpathvalues to variables
    ELSE
        Log To Console    Executing in Android
    END
    Swipe     0    495    0    150
     Common.Wait for Element Visibility    ${LinkableServices}   LinkableServices Button
     Common.Click Button    ${LinkableServices}    LinkableServices

    Common.Wait for Element Visibility    ${OnlineLicenceSearch}   SharkSmart Button
    ${FuelWatch_Visible} =   Run Keyword And Return Status  AppiumLibrary.Element Should Be Visible    ${OnlineLicenceSearch}
    Log        SharkSmart Button Visibility : ${FuelWatch_Visible}
    Common.Click Button     ${OnlineLicenceSearch}    SharkSmart Button

    Common.Wait for Element Visibility    ${Continue}   Continue Button
    Common.Click Button    ${Continue}    Continue

        Swipe     0    495    0    150
            Swipe     0    495    0    150
                Swipe     0    495    0    150
                    Swipe     0    495    0    150

#     AppiumCommon.Swipe up screen Range     ${IAgree}
     Common.Wait for Element Visibility    ${IAgree}   IAgree Button
     Common.Element Should Be Enabled   ${IAgree}
     Common.Click Button    ${IAgree}    IAgree

    Common.Wait for Element Visibility    ${FuelWatchBackToServiceWA}    FuelWatchBackToServiceWA Button
    Common.Element Should Be Enabled   ${FuelWatchBackToServiceWA}
    Common.Click Button     ${FuelWatchBackToServiceWA}    BackButton

     Common.Wait for Element Visibility     ${OnlineLicenceSearch}    Online licence search Button
      Common.Element Should Be Enabled    ${OnlineLicenceSearch}
      Common.Wait for Element Visibility    ${Linked}    Linked Button

     Element Name Should Be      ${OnlineLicenceSearch}   expected=Online licence search
     Element Name Should Be    ${Linked}   expected=Linked

Link to the WeatherStations
    [Documentation]    link the WeatherStation Mobile Application through Discovery
    Log to console      Device OS : %{Device OS}
    IF  "%{Device OS}" == "iOS"
        Set iosLinkServiceWA xpathvalues to variables
    ELSE
        Log To Console    Executing in Android
    END
    Swipe     0    495    0    150
     Common.Wait for Element Visibility    ${LinkableServices}    LinkableServices Button
     Common.Click Button    ${LinkableServices}    LinkableServices

    Common.Wait for Element Visibility    ${WeatherStations}   WeatherStations Button
    ${FuelWatch_Visible} =   Run Keyword And Return Status  AppiumLibrary.Element Should Be Visible    ${WeatherStations}
    Log        FuelWatch Button Visibility : ${FuelWatch_Visible}
    Common.Click Button     ${WeatherStations}    WeatherStations Button

    Common.Wait for Element Visibility    ${Next}   Next Button
    Common.Click Button    ${Next}    Next

        Swipe     0    495    0    150
            Swipe     0    495    0    150
                Swipe     0    495    0    150
                    Swipe     0    495    0    150

#     AppiumCommon.Swipe up screen Range     ${IAgree}
     Common.Wait for Element Visibility    ${IAgree}   IAgree Button
     Common.Element Should Be Enabled   ${IAgree}
     Common.Click Button    ${IAgree}    IAgree


     Common.Wait for Element Visibility    ${AcceptLocationServices}      AcceptLocationService Button
     Common.Element Should Be Enabled   ${AcceptLocationServices}
     Common.Click Button   ${AcceptLocationServices}    AcceptLocationService
     Sleep   3s
     Common.Wait for Element Visibility    ${FuelWatchBackToServiceWA}    FuelWatchBackToServiceWA Button
     Common.Element Should Be Enabled   ${FuelWatchBackToServiceWA}
     Common.Click Button     ${FuelWatchBackToServiceWA}    BackButton
    
     Common.Wait for Element Visibility    ${WeatherStations}    WeatherStations Button
     Common.Element Should Be Enabled   ${WeatherStations}
     Common.Wait for Element Visibility    ${Linked}    Linked Button

     Element Name Should Be     ${WeatherStations}   expected=Weather stations
     Element Name Should Be    ${Linked}   expected=Linked

Link to the UnclaimedMoney
    [Documentation]    link the WeatherStation Mobile Application through Discovery
    Log to console      Device OS : %{Device OS}
    IF  "%{Device OS}" == "iOS"
        Set iosLinkServiceWA xpathvalues to variables
    ELSE
        Log To Console    Executing in Android
    END
    Swipe     0    495    0    150
     Common.Wait for Element Visibility    ${LinkableServices}    LinkableServices Button
     Common.Click Button    ${LinkableServices}    LinkableServices

    Common.Wait for Element Visibility    ${UnclaimedMoney}       UnclaimedMoney Button
    ${FuelWatch_Visible} =   Run Keyword And Return Status  AppiumLibrary.Element Should Be Visible    ${UnclaimedMoney}
    Log        FuelWatch Button Visibility : ${FuelWatch_Visible}
    Common.Click Button     ${UnclaimedMoney}    UnclaimedMoney Button

     Element Name Should Be     ${UnclaimedMoney}   expected=Unclaimed money
     Swipe     0    495    0    150
     Element Name Should Be    ${Linked}   expected=Linked

Link to the Offers
    [Documentation]    link the offer Mobile Application through Discovery
    Log to console      Device OS : %{Device OS}
    IF  "%{Device OS}" == "iOS"
        Set iosLinkServiceWA xpathvalues to variables
    ELSE
        Log To Console    Executing in Android
    END
    Swipe     0    495    0    150

    Common.Wait for Element Visibility    ${LinkableServices}    LinkableServices Button
    Common.Click Button    ${LinkableServices}    LinkableServices

    Common.Wait for Element Visibility    ${Offers}        UnclaimedMoney Button
    ${FuelWatch_Visible} =   Run Keyword And Return Status  AppiumLibrary.Element Should Be Visible   ${Offers}
    Log        FuelWatch Button Visibility : ${FuelWatch_Visible}
    Common.Click Button     ${Offers}    UnclaimedMoney Button

     Common.Wait for Element Visibility    ${Continue}   Continue Button
    Common.Click Button    ${Continue}    Continue

    Swipe     0    495    0    150
            Swipe     0    495    0    150


     Common.Wait for Element Visibility    ${Discovery}  Discovery Button
    ${FuelWatch_Visible} =   Run Keyword And Return Status  AppiumLibrary.Element Should Be Visible    ${Discovery}
    Log        Discovery Button Visibility : ${FuelWatch_Visible}
    Common.Click Button     ${Discovery}    Discovery Button

     Common.Wait for Element Visibility    ${LinkableServices}   LinkableServices Button
     Common.Click Button    ${LinkableServices}    LinkableServices

     Element Name Should Be      ${Offers}   expected=Offers
     Element Name Should Be    ${Linked}   expected=Linked

Link to the LearnAndLog
    [Documentation]    link the offer Mobile Application through Discovery
    Log to console      Device OS : %{Device OS}
    IF  "%{Device OS}" == "iOS"
        Set iosLinkServiceWA xpathvalues to variables
    ELSE
        Log To Console    Executing in Android
    END
    Swipe     0    495    0    150

    Common.Wait for Element Visibility    ${LinkableServices}    Learn&Log Button
    Common.Click Button    ${LinkableServices}    Learn&Log

    Common.Wait for Element Visibility    ${Learn&Log}        Learn&Log Button
    ${FuelWatch_Visible} =   Run Keyword And Return Status  AppiumLibrary.Element Should Be Visible   ${Learn&Log}
    Log        Learn&Log Button Visibility : ${FuelWatch_Visible}
    Common.Click Button     ${Learn&Log}    Learn&Log Button

     Common.Wait for Element Visibility    ${Continue}   Continue Button
    Common.Click Button    ${Continue}    Continue

    Swipe     0    495    0    150
            Swipe     0    495    0    150

    Swipe     0    495    0    150
            Swipe     0    495    0    150

     Common.Wait for Element Visibility    ${IAgree}   IAgree Button
     Common.Element Should Be Enabled   ${IAgree}
     Common.Click Button    ${IAgree}    IAgree
     SignInScreen.Login to the App

Set iosLinkServiceWA xpathvalues to variables
    Log To Console    *** overriding the Android keyword values to iOS ***
    Set Suite Variable      ${LinkableServices}    ${ios_LinkableServices}
    Set Suite Variable      ${FishCatchWA}    ${ios_FishCatchWA}
    Set Suite Variable      ${Next}    ${ios_Next}
    Set Suite Variable      ${IAgree}    ${ios_IAgree}
    Set Suite Variable      ${BackToServiceWA}    ${ios_BackToServiceWA}
    Set Suite Variable      ${FuelWatch}     ${ios_FuelWatch}
    Set Suite Variable      ${AcceptLocationServices}    ${ios_AcceptLocationServices}
    Set Suite Variable      ${FuelWatchBackToServiceWA}    ${ios_FuelWatchBackToServiceWA}
    Set Suite Variable      ${Linked}    ${ios_Linked}
    Set Suite Variable      ${SharkSmart}   ${ios_SharkSmart}
    Set Suite Variable      ${AcknowledgeAndContinue}    ${ios_AcknowledgeAndContinue}
    Set Suite Variable      ${OnlineLicenceSearch}    ${ios_OnlineLicenceSearch}
    Set Suite Variable      ${Continue}    ${ios_Continue}
    Set Suite Variable      ${WeatherStations}    ${ios_WeatherStations}
    Set Suite Variable      ${UnclaimedMoney}    ${ios_UnclaimedMoney}
    Set Suite Variable      ${Discovery}     ${ios_Discovery}
    Set Suite Variable      ${Offers}     ${ios_Offers}
    Set Suite Variable      ${Learn&Log}    ${ios_Learn&Log} 

