*** Settings ***
Library    ExcelLibrary
Library    Collections
Library    OperatingSystem    
Library    String
Library  CollectionUtilities.py
Library         ../rf-utilities/ExtentReportListener.py
Resource        ../rf-utilities/ExtentUtilityListener.robot

*** Variables ***
${APPIUM SERVER Config}=    ${CURDIR}\\..\\rf-config
${TESTDATA FILE PATH}=    ${CURDIR}\\..\\rf-data
${USER CREDENTIAL FILE PATH}=    ${CURDIR}\\..\\rf-data\\User_Credentials.xlsx
&{USER_DATA}
${TESTDATA_REGISTRATION_FILE_PATH}=    ..\\rf-data\\smoke\\TestData.xlsx

*** Keywords ***

Load Server Config Data
	    [Documentation]  Load The Appium Server Config Data From an Excel(.xls) File
	    [Arguments]  ${File Name}  ${Sheet Name}
	    #doc_id can be any random variable
        ${doc_id}=    Generate random string    4    0123456789
	    Open Excel Document  ${APPIUM SERVER Config}\\${FileName}   ${doc_id}
	    @{COLUMN VALUE}  read_excel_column     col_num=1       sheet_name=${Sheet Name}
	    ${ROW COUNT}  Get Length  ${COLUMN VALUE}

        Log to Console  Inside~Load Server Config Data
	    Log to Console  Device Name : %{DEVICE_NAME}


	    ${DEVICE ROW NUMBER}=      Get Index From List  ${COLUMN VALUE}    %{DEVICE_NAME}
	    ${DEVICE ROW NUMBER}=   Evaluate    int(${DEVICE ROW NUMBER}) + 1

	    @{SELECTED DEVICE VALUE}  read_excel_row     row_num=${DEVICE ROW NUMBER}       sheet_name=${Sheet Name}
	    @{HEADER ROW VALUE}  read_excel_row     row_num=1       sheet_name=${Sheet Name}


	    &{Appium Config Dict}=    DataUtility.Convert Two List Into Dictionary     ${HEADER ROW VALUE}     ${SELECTED DEVICE VALUE}
	    Close Current Excel Document
	    RETURN  &{Appium Config Dict}


Load Test Data From File
	    [Documentation]  Load Test Data From an Excel(.xls) File
	    [Arguments]  ${File Name}  ${Sheet Name}    ${Row Name}
	    #doc_id can be any random variable
	    Log To Console    "Inside Load Testdata from file"
        ${doc_id}=    Generate random string    4    0123456789
        ${TEST_TYPE}=   Convert To Lower Case  %{TEST_TYPE}
	    Open Excel Document  ${TESTDATA FILE PATH}\\${TEST_TYPE}\\${FileName}   ${doc_id}
	    # Get the testcase id column number from first row
	    @{FIRST ROW COLUMN VALUE}  read_excel_row     row_num=1        sheet_name=${Sheet Name}

	    Log To Console    "Inside Load Testdata from file... 1"

	    FOR    ${index}    ${item}    IN ENUMERATE    @{FIRST ROW COLUMN VALUE}     start=1
            IF      '${item}' == 'UniqueID'
	            ${colmn_num}=     Set Variable  ${index}
	            Exit For Loop
	        END
	    END
	    ${Column_name_exist}   Run Keyword And Return Status   Evaluate  ${colmn_num} in globals()
	    IF  not ${Column_name_exist}
	        Fail  Given first row column header name 'TestcaseID' not exists in the following xls/xlsx file '${File Name}'
	    END

	    Log To Console    "Inside Load Testdata from file... 2"
#        Get The list of values for the given column 'testcaseid'
	    @{COLUMN VALUE}  read_excel_column     col_num=${colmn_num}        sheet_name=${Sheet Name}
	    ${ROW COUNT}  Get Length  ${COLUMN VALUE}

	    ${TESTDATA ROW NUMBER}=      Get Index From List  ${COLUMN VALUE}    ${Row Name}
	    ${TESTDATA ROW NUMBER}=   Evaluate    int(${TESTDATA ROW NUMBER}) + 1

	    @{SELECTED ROW VALUE}  read_excel_row     row_num=${TESTDATA ROW NUMBER}       sheet_name=${Sheet Name}
	    @{HEADER ROW VALUE}  read_excel_row     row_num=1       sheet_name=${Sheet Name}

	    Log To Console    "Inside Load Testdata from file... 3"

	    &{TEST DATA DICT}=    DataUtility.Convert Two List Into Dictionary     ${HEADER ROW VALUE}     ${SELECTED ROW VALUE}
	    Set Environment Variable    EXECUTE_TEST    ${TEST DATA DICT.Execute}
	    Close Current Excel Document

	    IF  '${TEST DATA DICT.UserName}' != 'None'      # added condition to handle unauth user validation

            IF  ${USER_DATA} == {}
                ${USER_DATA}    Load Login Credential From User Credential File
                Set Global Variable  ${USER_DATA}
            END
    #      Code to get User credentails and append it to specific test data
            @{USER_LIST}=     Convert Given String To List Based On Delimiter    ${TEST DATA DICT.UserName}      &
            @{PASS_LIST}=       Evaluate  [ list_item+"_Password" for list_item in ${USER_LIST}]
            @{USER_LIST}       Combine Lists  ${USER_LIST}     ${PASS_LIST}
            &{USER_DICT}=        Create New Dict For Given Values  ${USER_DATA}     ${USER_LIST}
            &{TEST DATA DICT}   Combine Two Dictionary      ${TEST DATA DICT}   ${USER_DICT}
            Set Environment Variable    USER_LOGIN    ${TEST DATA DICT.UserName}
        ELSE
            Set Environment Variable    USER_LOGIN    ${TEST DATA DICT.UserName}
        END
#        Read the creditcard, billing address and shipping address details from seperate file
        &{TEST DATA DICT}       Get Creditcard And Shipping Address Details From Test Data file     ${TEST DATA DICT}

        Log To Console    "Inside Load Testdata from file... 4"
	    RETURN      &{TEST DATA DICT}


Get Login Credential For Given Username From User Credential Data File
	    [Documentation]  Load Test Data From an Excel(.xls) File
	    [Arguments]  ${USERNAME}    ${COLUMN_NAME}=%{USER_ACCOUNT}    ${Sheet Name}=user
	    #doc_id can be any random variable
        ${doc_id}=    Generate random string    4    0123456789abc
	    Open Excel Document  ${USER CREDENTIAL FILE PATH}   ${doc_id}

	    @{FIRST COLUMN VALUE}  read_excel_column     col_num=1        sheet_name=${Sheet Name}
	    @{HEADER ROW VALUE}  read_excel_row    row_num=1      sheet_name=${Sheet Name}
	    ${COLUMN COUNT}  Get Length  ${HEADER ROW VALUE}

        # Get row number for given username
	    FOR    ${index}    ${item}    IN ENUMERATE    @{FIRST COLUMN VALUE}     start=1
            IF      '${item}' == '${USERNAME}'
	            ${Row_num}=     Set Variable  ${index}
	            Exit For Loop
	        END
	    END

        # Get column number for given batch
	     FOR    ${index}    ${item}    IN ENUMERATE    @{HEADER ROW VALUE}     start=1
            IF      '${item}' == '${COLUMN_NAME}'
	            ${col_num}=     Set Variable  ${index}
	            Exit For Loop
	        END
	    END

	    # Get column number for given user batch password column
	     FOR    ${index}    ${item}    IN ENUMERATE    @{HEADER ROW VALUE}     start=1
            IF      '${item}' == '${COLUMN_NAME}_Password'
	            ${pass_col_num}=     Set Variable  ${index}
	            Exit For Loop
	        END
	    END

#	    Read data from given row and column value
        ${EMAIL_ID}=    Read Excel Cell  ${Row_num}     ${col_num}      ${Sheet Name}
        ${PASSWORD}=    Read Excel Cell  ${Row_num}     ${pass_col_num}      ${Sheet Name}
        Close Current Excel Document
	    RETURN  ${EMAIL_ID}   ${PASSWORD}


Load Login Credential From User Credential File
	    [Documentation]  Load Test Data From an Excel(.xls) File
	    [Arguments]  ${COLUMN_NAME}=%{USER_ACCOUNT}    ${Sheet Name}=user
	    #doc_id can be any random variable
        ${doc_id}=    Generate random string    4    0123456789abc
	    Open Excel Document  ${USER CREDENTIAL FILE PATH}   ${doc_id}

        ${PASSWORD_KEY}=    Create List
	    @{FIRST COLUMN VALUE}  read_excel_column     col_num=1        sheet_name=${Sheet Name}
	    @{HEADER ROW VALUE}  read_excel_row    row_num=1      sheet_name=${Sheet Name}
	    ${COLUMN COUNT}  Get Length  ${HEADER ROW VALUE}
        @{USER_NAME_KEY}     Remove Given Index From List  ${FIRST COLUMN VALUE}     0

	    # Get column number for given user batch
	     FOR    ${index}    ${item}    IN ENUMERATE    @{HEADER ROW VALUE}     start=1
            IF      '${item}' == '${COLUMN_NAME}'
	            ${col_num}=     Set Variable  ${index}
	            Exit For Loop
	        END
	    END

	    # Get column number for given user batch password column
	     FOR    ${index}    ${item}    IN ENUMERATE    @{HEADER ROW VALUE}     start=1
            IF      '${item}' == '${COLUMN_NAME}_Password'
	            ${pass_col_num}=     Set Variable  ${index}
	            Exit For Loop
	        END
	    END
	    #Get given batch email Id
	    @{EMAIL_ID}  read_excel_column     col_num=${col_num}        sheet_name=${Sheet Name}
	    @{EMAIL_ID}     Remove Given Index From List  ${EMAIL_ID}     0
	    #Get password
	    @{PASSWORD}  read_excel_column     col_num=${pass_col_num}        sheet_name=${Sheet Name}
        @{PASSWORD}     Remove Given Index From List  ${PASSWORD}     0

#	    Create password key
	    FOR  ${item}  IN    @{USER_NAME_KEY}
	        Append To List  ${PASSWORD_KEY}     ${item}_Password
	    END
#        Convert list into dictionary
        &{USER_DICT}        DataUtility.Convert Two List Into Dictionary    ${USER_NAME_KEY}    ${EMAIL_ID}
        &{PASSWORD_DICT}    DataUtility.Convert Two List Into Dictionary    ${PASSWORD_KEY}    ${PASSWORD}

#        Combile User and password dictionary into one dictionary
        &{USER_CREDENTIAL_DICT}     Combine Two Dictionary      ${USER_DICT}        ${PASSWORD_DICT}
        Close Current Excel Document

	    RETURN  &{USER_CREDENTIAL_DICT}

Convert Two List Into Dictionary

    [Documentation]  keyword wrapper to convert the two list into dictionary
    [Arguments]     ${LIST1}       ${LIST2}
    &{Dict Data}    Create Dictionary
    FOR    ${key}    ${value}    IN ZIP    ${LIST1}    ${LIST2}
        ${STATUS}=      Run Keyword And Return Status       Should Contain      ${value}       "
        ${STATUS1}=      Run Keyword And Return Status       Should Contain      ${value}       '
        IF  not ${STATUS} and not ${STATUS1}
                  ${value}=   Evaluate   str('${value}')
        END
        ${value}    Strip String    ${value}
        IF  '${key}' == 'Catalog'
            ${value}=   Convert To Upper Case   ${value}
        END

        Set To Dictionary  ${Dict Data}  ${Key}  ${value}
    END
    RETURN  &{Dict Data}

Convert Given String To List Based On Delimiter
    [Documentation]  keyword wrapper to convert string to list based on delimiter
    [Arguments]     ${STRING}  ${SEPARATOR}=' '     ${STRIP}=True

#    ${VALIDATE STR}=     Evaluate  type(${STRING}).__name__
#    IF  ${VALIDATE STR} == int
#        ${STRING}=   Evaluate  str(${Count})
#    END

    @{DATA LIST}=   Split String  ${STRING}  ${SEPARATOR}
    IF  ${STRIP}
        @{DATA LIST}=  Evaluate  [value.strip() for value in ${DATA LIST}]
    END
    RETURN    @{DATA LIST}

Load Test Data For The Given Row
	    [Documentation]  Load Test Data From an Excel(.xls) File
	    [Arguments]  ${File Name}  ${Sheet Name}    ${Row Name}
	    #doc_id can be any random variable
        ${doc_id}=    Generate random string    4    abc0123456789
	    Open Excel Document  ${TESTDATA FILE PATH}\\${FileName}   ${doc_id}
	    @{FIRST COLUMN ROW VALUE}  read_excel_column     col_num=1        sheet_name=${Sheet Name}
	    ${FIRST COLUMN ROW COUNT}  Get Length  ${FIRST COLUMN ROW VALUE}
#	    Log To Console  ${FIRST COLUMN ROW VALUE}

        # Get row number for given row value
	     FOR    ${index}    ${item}    IN ENUMERATE    @{FIRST COLUMN ROW VALUE}     start=1
            IF      '${item}' == '${Row Name}'
	            ${Given_value_row_num}=     Set Variable  ${index}
	            Exit For Loop
	        END
	    END
        ${Row_name_exist}   Run Keyword And Return Status   Evaluate  ${Given_value_row_num} in globals()
	    IF  not ${Row_name_exist}
	        Fail  Given row name '${Row Name}' not exists in the following xls/xlsx file '${File Name}'
	    END

	    @{HEADER ROW VALUE}  read_excel_row     row_num=0       sheet_name=${Sheet Name}
	    @{GIVEN ROW VALUE}  read_excel_row     row_num=${Given_value_row_num}       sheet_name=${Sheet Name}
	    @{HEADER ROW VALUE}     Remove Given Index From List  ${HEADER ROW VALUE}     0
	    @{GIVEN ROW VALUE}     Remove Given Index From List  ${GIVEN ROW VALUE}     0
	    &{TEST DATA DICT}=    DataUtility.Convert Two List Into Dictionary     ${HEADER ROW VALUE}     ${GIVEN ROW VALUE}
	    Close Current Excel Document
	    RETURN    &{TEST DATA DICT}

Get Creditcard And Shipping Address Details From Test Data file
	    [Documentation]  Get Creditcard And Shipping Address Detail
	    [Arguments]     ${TEST DATA DICT}

	    ${CORRECT_CC_DETAILS}=     Run Keyword And Return Status    Should Contain     ${TEST DATA DICT}      Correct_Card_And_Address
        IF  ${CORRECT_CC_DETAILS}
            IF  '${TEST DATA DICT.Correct_Card_And_Address}' != 'None'
                &{TestData}=   Load Test Data For The Given Row   CreditCard_Details.xlsx   creditcard  ${TEST DATA DICT.Correct_Card_And_Address}
                &{CARD_DETAILS}  Create Dictionary  ${TEST DATA DICT.Correct_Card_And_Address}       ${TestData}
                &{TEST DATA DICT}   Combine Two Dictionary      ${TEST DATA DICT}   ${CARD_DETAILS}
            END
        END

        ${WRONG_CC_DETAILS_STATUS}=     Run Keyword And Return Status    Should Contain     ${TEST DATA DICT}      Wrong_CreditCard_And_Correct_Address
        IF  ${WRONG_CC_DETAILS_STATUS}
            IF  '${TEST DATA DICT.Wrong_CreditCard_And_Correct_Address}' != 'None'
                &{TestData}=   Load Test Data For The Given Row   CreditCard_Details.xlsx   creditcard  ${TEST DATA DICT.Wrong_CreditCard_And_Correct_Address}
                &{CARD_DETAILS}  Create Dictionary  ${TEST DATA DICT.Wrong_CreditCard_And_Correct_Address}       ${TestData}
                &{TEST DATA DICT}   Combine Two Dictionary      ${TEST DATA DICT}   ${CARD_DETAILS}
            END
        END

        ${WRONG_ADDRESS_DETAILS_STATUS}=     Run Keyword And Return Status    Should Contain     ${TEST DATA DICT}      Correct_Card_And_Wrong_Address
        IF  ${WRONG_ADDRESS_DETAILS_STATUS}
            IF  '${TEST DATA DICT.Correct_Card_And_Wrong_Address}' != 'None'
                &{TestData}=   Load Test Data For The Given Row   CreditCard_Details.xlsx   creditcard  ${TEST DATA DICT.Correct_Card_And_Wrong_Address}
                &{CARD_DETAILS}  Create Dictionary  ${TEST DATA DICT.Correct_Card_And_Wrong_Address}       ${TestData}
                &{TEST DATA DICT}   Combine Two Dictionary      ${TEST DATA DICT}   ${CARD_DETAILS}
            END
        END

        ${SHIP_ADDRESS_DETAILS_STATUS}=     Run Keyword And Return Status    Should Contain     ${TEST DATA DICT}      ShippingAddress
        IF  ${SHIP_ADDRESS_DETAILS_STATUS}
            IF  '${TEST DATA DICT.ShippingAddress}' != 'None'
                &{TestData}=   Load Test Data For The Given Row   ShippingAddress.xlsx   Shipping_Address  ${TEST DATA DICT.ShippingAddress}
                &{SHIP_ADDRESS}  Create Dictionary  ${TEST DATA DICT.ShippingAddress}       ${TestData}
                &{TEST DATA DICT}   Combine Two Dictionary      ${TEST DATA DICT}   ${SHIP_ADDRESS}
            END
        END
      RETURN  &{TEST DATA DICT}

Load Test Data For The Given Row for Registration
	    [Documentation]  Load Test Data From an Excel(.xls) File
	    [Arguments]  ${File Name}  ${Sheet Name}    ${Row Name}
	    #doc_id can be any random variable
        ${doc_id}=    Generate random string    4    abc0123456789
	    Open Excel Document  ${TESTDATA_REGISTRATION_FILE_PATH}   ${doc_id}
	    @{FIRST COLUMN ROW VALUE}  read_excel_column     col_num=1        sheet_name=${Sheet Name}
	    ${FIRST COLUMN ROW COUNT}  Get Length  ${FIRST COLUMN ROW VALUE}
#	    Log To Console  ${FIRST COLUMN ROW VALUE}

        # Get row number for given row value
	     FOR    ${index}    ${item}    IN ENUMERATE    @{FIRST COLUMN ROW VALUE}     start=1
            IF      '${item}' == '${Row Name}'
	            ${Given_value_row_num}=     Set Variable  ${index}
	            Exit For Loop
	        END
	    END
        ${Row_name_exist}   Run Keyword And Return Status   Evaluate  ${Given_value_row_num} in globals()
	    IF  not ${Row_name_exist}
	        Fail  Given row name '${Row Name}' not exists in the following xls/xlsx file '${File Name}'
	    END

	    @{HEADER ROW VALUE}  read_excel_row     row_num=0       sheet_name=${Sheet Name}
	    @{GIVEN ROW VALUE}  read_excel_row     row_num=${Given_value_row_num}       sheet_name=${Sheet Name}
	    @{HEADER ROW VALUE}     Remove Given Index From List  ${HEADER ROW VALUE}     0
	    @{GIVEN ROW VALUE}     Remove Given Index From List  ${GIVEN ROW VALUE}     0
	    &{TEST DATA DICT}=    DataUtility.Convert Two List Into Dictionary     ${HEADER ROW VALUE}     ${GIVEN ROW VALUE}
	    Close Current Excel Document
	    RETURN    &{TEST DATA DICT}
