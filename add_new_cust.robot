*** Settings ***
Documentation       This is some basic info about the whole SUITE

Library             Browser    timeout=0:00:10
#    run the script
#    robot -d results    tests/crm.robot


*** Test Cases ***
Should be able to add new customer
    [Documentation]    This is some info about the TEST
    [Tags]    1006    smoke    contacts

    # Initialising Browser library
    Set Browser Timeout    5s
    # Open the browser
    Log    starting the test case
    Open Browser    url=https://automationplayground.com/crm/    browser=chromium

    Get Element States    'Customers Are Priority One!'    validate    value & visible

    Click    id=SignIn
    Get Element States    'Login'    validate    value & visible
    # Click    id=new-customer

    Fill Text    id=email-id    admin@login.com
    Fill Text    id=password    adminPass
    Click    id=submit-id
    Get Element States    'Our Happy Customers'    validate    value & visible

    Click    id=new-customer
    Get Element States    'Add Customer'    validate    value & visible

    Fill Text    id=EmailAddress    rr@ur.com
    Fill Text    id=FirstName    Fqwe
    Fill Text    id=LastName    dsfs
    Fill Text    id=City    NewYorkCity
    Select Options By    id=StateOrRegion    label    Georgia
    Check Checkbox    xpath=//*[@id="loginform"]/div/div/div/div/form/div[6]/input[2]
    Check Checkbox    xpath=//*[@id="loginform"]/div/div/div/div/form/div[7]/input
    Click    xpath=//*[@id="loginform"]/div/div/div/div/form/button
    Get Element States    'Success! New customer added.'    validate    visible

    Sleep    3s
    Close Browser
    #    robot -d results    tests/crm.robot
