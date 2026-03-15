*** Keywords ***
Convert String To Dictionary List
    [Documentation]  convert the given string to dictionary list
    [Arguments]  ${String_value}
    @{New_dict_list}=     Evaluate  list(${String_value})
    RETURN    @{New_dict_list}