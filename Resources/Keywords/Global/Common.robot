*** Settings ***
Resource    GlobalResources.robot

*** Variables ***
&{Employee}    =${EMPTY}


*** Keywords ***
Login to Tenant Portal
    Open Browser    ${tenantURL}    chrome
    Maximize Browser Window
    Set Selenium Speed    0.15 seconds
    Waiting for loading to complete
    Wait Until Element Is Visible    ${loc_inputUsername}    60
    Input Text    ${loc_inputUsername}    ${adminUsername}
    Input Password    ${loc_inputPassword}    ${adminPassword}
    Click Element    ${loc_btnSignin}
    
Launch Kiosk Mode
    [Arguments]    ${location}
    Wait Until Element Is Visible    ${loc_btnKioskMode}    30
    Click Element    ${loc_btnKioskMode}
    Wait Until Element Is Visible    ${loc_listKioskLocation}//a[contains(text(), '${location}')]
    Click Element    ${loc_listKioskLocation}//a[contains(text(), '${location}')]

User Start the Kiosk
    Waiting for loading to complete
    Wait Until Element Is Visible    ${loc_btnStartKiosk}    10
    Click Element    ${loc_btnStartKiosk}   
       
Waiting for loading to complete
    Wait Until Element Is Not Visible    ${loc_screenLoading}    300
    
Get Employee Data
    [Arguments]    ${row}
    Close All Excel Documents
    Open Excel Document   ${dataEmployees}    doc_id=docid
    #${count}    Get Column Count    ${arg_sheet}
    &{content}    Create Dictionary
    FOR    ${i}    IN RANGE    1    80
        ${var_col}    Read Excel Cell    row_num=1  col_num=${i}    sheet_name=data
        Exit For Loop If    '${var_col}'=='None'
        ${temp}    Read Excel Column    col_num=${i}    sheet_name=data
        Set To Dictionary    ${content}    ${temp[0]}    ${temp[${row}]}
    END     
    Return From Keyword    &{content}
    Close All Excel Documents
    
Populate Your Info Page
    Wait Until Element Is Visible    ${loc_employeeFirstName}
    Input Text    ${loc_employeeFirstName}    ${Employee.employee_firstname_psf_e1}
    Input Text    ${loc_employeeLastName}    ${Employee.employee_lastname_psf_e2}
    Input Text    ${loc_employeeSSN}    ${Employee.ssn_psf_e4}
    #DOB
    Click Element    ${loc_employeeDOBCalendarIcon}
    ${DOB}    Split String    ${Employee.birth_date_psf_66}    /
    Wait Until Element Is Visible    ${loc_employeeDOBMonth}
    Select From List By Value    ${loc_employeeDOBMonth}    ${DOB}[0]
    Select From List By Value    ${loc_employeeDOBYear}    ${DOB}[2]
    Sleep    1s
    Click Element    //div[@class='btn-light' and text()='${DOB}[1]']
    Input Text    ${loc_employeeAddress}    ${Employee.address_street_psf_7}
    Input Text    ${loc_employeeCity}    ${Employee.address_city_psf_e8}
    Input Text    ${loc_employeeCounty}    ${Employee.address_county_psf_e9}
    Select From List By Value    ${loc_employeeState}    ${Employee.address_state_psf_e10}   
    Input Text    ${loc_employeeZip}    ${Employee.address_postal_psf_11}    
    Input Text    ${loc_employeePhone}    ${Employee.phone_number_psf_e5}
    Sleep    3s
    Click Element    ${loc_btnNext}
    
Populate Military Service Page
    Wait Until Element Is Visible    ${loc_btnVeteranYes}    10
    Run Keyword If    '${Employee.militaryservice_1stQuestion_psf_m1}'=='1'    Run Keywords    Click Element    ${loc_btnVeteranYes}    AND    Populate Veteran Details
    ...    ELSE IF    '${Employee.militaryservice_1stQuestion_psf_m1}'=='0'    Click Element    ${loc_btnVeteranNo}  
    
Populate Veteran Details
    Wait Until Element Is Visible    ${loc_VeteranBranch}    10
    Select From List By Label    ${loc_VeteranBranch}    ${Employee.militaryservice_1stQuestion_branch_psf_m11}
    Click Element    ${loc_btnNext}
    #Enlisted Date
    ${enlistedDate}    Split String    ${Employee.militaryservice_1stQuestion_from_psf_m1c}    /
    ${enlistedDateMonth}    Convert To Integer    ${enlistedDate}[0]
    ${enlistedDateMonth}    Convert To String    ${enlistedDateMonth}
    Wait Until Element Is Visible    ${loc_VeteranEnlistedDateMonth}    10
    Select From List By Value    ${loc_VeteranEnlistedDateMonth}    ${enlistedDateMonth}
    Input Text    ${loc_VeteranEnlistedDateYear}    ${enlistedDate}[1]
    #Separated Date
    ${separatedDate}    Split String    ${Employee.militaryservice_1stQuestion_to_psf_m1d}    /
    ${separatedDateMonth}    Convert To Integer    ${separatedDate}[0]
    ${separatedDateMonth}    Convert To String    ${separatedDateMonth}
    Select From List By Value    ${loc_VeteranSeparatedDateMonth}    ${separatedDateMonth}
    Input Text    ${loc_VeteranSeparatedDateYear}    ${separatedDate}[1]                          
    Sleep    3s
    Click Element    ${loc_btnNext}      
    #Is Disabled
    Wait Until Element Is Visible    ${loc_btnVeteranYes}    10
    Run Keyword If    '${Employee.militaryservice_2ndQuestion_psf_m2}'=='1'    Click Element    ${loc_btnVeteranYes}
    ...    ELSE IF    '${Employee.militaryservice_2ndQuestion_psf_m2}'=='0'    Click Element    ${loc_btnVeteranNo}
    #Service Connected Disability
    Sleep    2s
    Wait Until Element Is Visible    ${loc_btnVeteranYes}    10
    Run Keyword If    '${Employee.militaryservice_3rdQuestion_psf_m3}'=='1'    Click Element    ${loc_btnVeteranYes}
    ...    ELSE IF    '${Employee.militaryservice_3rdQuestion_psf_m3}'=='0'    Click Element    ${loc_btnVeteranNo}
    #Training DVA
    Sleep    2s
    Wait Until Element Is Visible    ${loc_btnVeteranYes}    10
    Run Keyword If    '${Employee.militaryservice_4thQuestion_psf_m4}'=='1'    Run Keywords    Click Element    ${loc_btnVeteranYes}    AND    Input Job Training Date
    ...    ELSE IF    '${Employee.militaryservice_4thQuestion_psf_m4}'=='0'    Click Element    ${loc_btnVeteranNo}

Input Job Training Date
    Wait Until Element Is Visible    ${loc_VeteranJobTrainingDVAMonth}    10
    ${jobTrainingDate}    Split String    ${Employee.militaryservice_4thQuestion_when_psf_m4b}    /
    ${jobTrainingDateMonth}    Convert To Integer    ${jobTrainingDate}[0]
    ${jobTrainingDateMonth}    Convert To String    ${jobTrainingDateMonth}
    Select From List By Value    ${loc_VeteranJobTrainingDVAMonth}    ${jobTrainingDateMonth}
    Input Text    ${loc_VeteranJobTrainingDVAYear}    ${jobTrainingDate}[1]                          
    Sleep    3s
    Click Element    ${loc_btnNext}
    
Populate Assistance Page
    Sleep    2s
    Wait Until Element Is Visible    ${loc_btnVeteranYes}    10
    #TANF
    Run Keyword If    '${Employee.assistance_1stQuestion_psf_a1}'=='1'    Run Keywords    Click Element    ${loc_btnVeteranYes}    AND    Input TANF Details
    ...    ELSE IF    '${Employee.assistance_1stQuestion_psf_a1}'=='0'    Click Element    ${loc_btnVeteranNo}
    
    #SNAP
    Sleep    2s
    Wait Until Element Is Visible    ${loc_btnVeteranYes}    10
    Run Keyword If    '${Employee.assistance_2ndQuestion_psf_a2}'=='1'    Run Keywords    Click Element    ${loc_btnVeteranYes}    AND    Input SNAP Details
    ...    ELSE IF    '${Employee.assistance_2ndQuestion_psf_a2}'=='0'    Click Element    ${loc_btnVeteranNo}

Input TANF Details
    Wait Until Element Is Visible    ${loc_btnAssistanceIam}    10
    Run Keyword If    '${Employee.assistance_1stQuestion_Recipient}'=='1'    Run keywords    Click Element    ${loc_btnAssistanceIam}    AND    Input TANF Date Received
    ...    ELSE IF    '${Employee.assistance_1stQuestion_Recipient}'=='0'    Run Keywords    Click Element    ${loc_btnAssistanceSomeone}
    ...    AND    Wait Until Element Is Visible    ${loc_AssistanceRecipientName}    10
    ...    AND    Input Text    ${loc_AssistanceRecipientName}    ${Employee.assistance_3rdQuestion_PrimaryRecipient_psf_a2h} 
    ...    AND    Input Text    ${loc_AssistanceRecipientSSN}    ${Employee.assistance_3rdQuestion_SSN_psf_a2}
    ...    AND    Click Element    ${loc_btnNext}
    ...    AND    Input TANF Date Received  
    Wait Until Element Is Visible    ${loc_AssistanceRecipientCity}    10    
    Input Text    ${loc_AssistanceRecipientCity}    ${Employee.assistance_3rdQuestion_City_pdf_a2c}        
    Select From List By Label    ${loc_AssistanceRecipientState}    ${Employee.assistance_3rdQuestion_State_psf_a2d}
    Click Element    ${loc_btnNext}
    Wait Until Element Is Visible    ${loc_AssistanceRecipientCaseNumber}    10
    Input Text    ${loc_AssistanceRecipientCaseNumber}    ${Employee.assistance_3rdQuestion_CaseNo_psf_a2e}     
    Input Text    ${loc_AssistanceRecipientWorkerName}    ${Employee.assistance_3rdQuestion_CaseWorker_psf_a2f}
    Input Text    ${loc_AssistanceRecipientWorkerPhone}    ${Employee.assistance_3rdQuestion_PhoneNo_psf_a2g}
    Click Element    ${loc_btnNext}

Input TANF Date Received
    Wait Until Element Is Visible    ${loc_AssistanceTANFYear}    10
    ${TANFReceivedDate}    Split String    ${Employee.FirstQuestion_LastDateReceived_mmyyyy_psf_a1b}    /
    ${TANFReceiedDateMonth}    Convert To Integer    ${TANFReceivedDate}[0]
    ${TANFReceiedDateMonth}    Convert To String    ${TANFReceiedDateMonth}
    Select From List By Value    ${loc_AssistanceTANFMonth}    ${TANFReceiedDateMonth}
    Input Text    ${loc_AssistanceTANFYear}    ${TANFReceivedDate}[1]                          
    Sleep    3s
    Click Element    ${loc_btnNext}
    
Input SNAP Details
    Wait Until Element Is Visible    ${loc_btnAssistanceIam}    10
    Run Keyword If    '${Employee.assistance_2ndQuestion_Recipient}'=='1'    Run keywords    Click Element    ${loc_btnAssistanceIam}    AND    Input SNAP Date Received
    ...    ELSE IF    '${Employee.assistance_2ndQuestion_Recipient}'=='0'    Run Keywords    Click Element    ${loc_btnAssistanceSomeone}
    ...    AND    Wait Until Element Is Visible    ${loc_AssistanceRecipientName}    10
    ...    AND    Input Text    ${loc_AssistanceRecipientName}    ${Employee.assistance_3rdQuestion_PrimaryRecipient_psf_a2h} 
    ...    AND    Input Text    ${loc_AssistanceRecipientSSN}    ${Employee.assistance_3rdQuestion_SSN_psf_a2i}
    ...    AND    Click Element    ${loc_btnNext}
    ...    AND    Input SNAP Date Received  
    Wait Until Element Is Visible    ${loc_AssistanceRecipientCity}    10    
    Input Text    ${loc_AssistanceRecipientCity}    ${Employee.assistance_3rdQuestion_City_pdf_a2c}        
    Select From List By Label    ${loc_AssistanceRecipientState}    ${Employee.assistance_3rdQuestion_State_psf_a2d}
    Click Element    ${loc_btnNext}
    Wait Until Element Is Visible    ${loc_AssistanceRecipientCaseNumber}    10
    Input Text    ${loc_AssistanceRecipientCaseNumber}    ${Employee.assistance_3rdQuestion_CaseNo_psf_a2e}     
    Input Text    ${loc_AssistanceRecipientWorkerName}    ${Employee.assistance_3rdQuestion_CaseWorker_psf_a2f}
    Input Text    ${loc_AssistanceRecipientWorkerPhone}    ${Employee.assistance_3rdQuestion_PhoneNo_psf_a2g}
    Click Element    ${loc_btnNext}
    
Input SNAP Date Received
    Wait Until Element Is Visible    ${loc_AssistanceSNAPYear}    10
    ${SNAPReceivedDate}    Split String    ${Employee.SecondQuestion_LastDateReceived_mmyyyy_psf_a2b}    /
    ${SNAPReceivedDateMonth}    Convert To Integer    ${SNAPReceivedDate}[0]
    ${SNAPReceivedDateMonth}    Convert To String    ${SNAPReceivedDateMonth}
    Select From List By Value    ${loc_AssistanceSNAPMonth}    ${SNAPReceivedDateMonth}
    Input Text    ${loc_AssistanceSNAPYear}    ${SNAPReceivedDate}[1]                          
    Sleep    3s
    Click Element    ${loc_btnNext}
    
  
    

    