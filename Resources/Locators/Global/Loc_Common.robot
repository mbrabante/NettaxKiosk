*** Variables ***
${day}    ${EMPTY}
#Login
${loc_inputUsername}    //input[@aria-describedby='login-email']
${loc_inputPassword}    //input[@aria-describedby='login-password']
${loc_btnSignin}    //button[text()='Sign in ']

#Kiosk Mode
${loc_btnKioskMode}    //button[text()='Kiosk Mode']
${loc_listKioskLocation}    //div[@class='dropdown-menu show']
${loc_screenLoading}    loading-bg
${loc_btnStartKiosk}    //button[text()='Start']

#Your Info
${loc_employeeFirstName}    //label[text()='First Name (PSF-E1)']/..//input
${loc_employeeLastName}    //label[text()='Last Name (PSF-E2)']/..//input 
${loc_employeeSSN}    //label[text()='Social Security Number (PSF-E3)']/..//input
${loc_employeeDOBCalendarIcon}    //button[@class='btn btn-outline-secondary calendar-btn']
${loc_employeeDOBMonth}    //select[@title='Select month']
${loc_employeeDOBYear}    //select[@title='Select year']
${loc_employeeDOBDay}    //div[@class='btn-light' and text()='${day}']
${loc_employeeAddress}    //label[text()='Address (PSF-E5)']/..//input
${loc_employeeCity}    //label[text()='City (PSF-E6)']/..//input
${loc_employeeCounty}    //label[text()='County (PSF-E7)']/..//input
${loc_employeeState}    //label[text()='State (PSF-E8)']/..//select
${loc_employeeZip}    //label[text()='Zip (PSF-E9)']/..//input
${loc_employeePhone}    //label[text()='Phone (PSF-E10)']/..//input
${loc_btnNext}    //button[text()='Next']

#Military Service
${loc_btnVeteranYes}    //input[@id='yes']/../label
${loc_btnVeteranNo}    //input[@id='no']/../label
${loc_VeteranBranch}    //div[@class='questions']//div//div//select    #//div//div//select[@class='form-control ng-pristine ng-invalid ng-touched']
${loc_VeteranEnlistedDateMonth}    //label[text()='Enlisted Date']/../app-month-year-selector//select
${loc_VeteranEnlistedDateYear}    //label[text()='Enlisted Date']/../app-month-year-selector//input
${loc_VeteranSeparatedDateMonth}    //label[text()='Separated Date']/../app-month-year-selector//select
${loc_VeteranSeparatedDateYear}    //label[text()='Separated Date']/../app-month-year-selector//input
${loc_VeteranJobTrainingDVAMonth}    //label[text()='Job Training Program Date']/../app-month-year-selector//select
${loc_VeteranJobTrainingDVAYear}    //label[text()='Job Training Program Date']/../app-month-year-selector//input

#Assistance
${loc_btnAssistanceIam}    //input[@id='i_am']/../label
${loc_btnAssistanceSomeone}    //input[@id='someone_else']/../label
${loc_AssistanceTANFMonth}    //label[text()='TANF Date Received']/../app-month-year-selector//select
${loc_AssistanceTANFYear}    //label[text()='TANF Date Received']/../app-month-year-selector//input
${loc_AssistanceSNAPMonth}    //label[text()='SNAP Date Received']/../app-month-year-selector//select
${loc_AssistanceSNAPYear}    //label[text()='SNAP Date Received']/../app-month-year-selector//input
${loc_AssistanceRecipientName}    //label[contains(text(), 'Name')]/..//input
${loc_AssistanceRecipientSSN}    //label[contains(text(), 'SSN')]/..//input
${loc_AssistanceRecipientCity}    //label[contains(text(), 'City')]/..//input
${loc_AssistanceRecipientState}    //label[contains(text(), 'State')]/..//select
${loc_AssistanceRecipientCaseNumber}    //label[contains(text(), 'Case Number')]/..//input
${loc_AssistanceRecipientWorkerName}    //label[contains(text(), 'Name')]/..//input
${loc_AssistanceRecipientWorkerPhone}    //label[contains(text(), 'Phone Number')]/..//input


      