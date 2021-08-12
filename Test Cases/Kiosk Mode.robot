*** Settings ***
Resource    ../Resources/Keywords/Global/GlobalResources.robot

*** Test Cases ***
Test Kiosk Mode
    [Setup]    Run Keywords    Launch Kiosk Mode    Palm Harbor, FL    AND    User Start the Kiosk
    FOR    ${i}    IN RANGE    1    2
        &{Employee}    Create Dictionary
        &{Employee}    Get Employee Data    ${i}
        Set Global Variable    &{Employee}
        Populate Your Info Page
        Populate Military Service Page
        Populate Assistance Page
        Sleep    5s           
    END 
    
    