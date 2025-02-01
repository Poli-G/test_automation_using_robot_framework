*** Settings ***
Library             Browser
Library             Collections

Suite Setup         Open Browser Suite    #    opening browser for the whole session
Suite Teardown      Close Browser Suite    #    Close browser for the whole session
Test Setup          Open Main Page    #    open tub for the test
Test Teardown       Close Page


*** Variables ***
${BASE_URL}     https://en.wikipedia.org/wiki/Main_Page


*** Test Cases ***
Validate Wikipedia TOC for Steve Jobs
    Perform search
    Verify heading
    Verify secondary headings contain


*** Keywords ***
Open Browser Suite
    New Browser    browser=chromium    headless=False
    New Context

Close Browser Suite
    Close Browser

Open Main Page
    New Page    ${BASE_URL}
    Set Browser Timeout    30s

Close Page
    Close Page

Perform search
    Fill Text    id=searchInput    steve jobs
    Sleep    2s
    Click    xpath=//*[@id="searchform"]/div/button

Verify heading
    Get Text    id=firstHeading    ==    Steve Jobs

Verify secondary headings contain
    @{expected_secondary_headings} =    Create List
    ...    Early life
    ...    1974–1985
    ...    Health problems
    ...    Innovations and designs
    ...    Personal life
    ...    Honors and awards

    @{h2_elements} =    Get Elements    xpath=//*[@id="vector-toc-pinned-container"]//a

    ${text} =    Get Text    ${h2_elements}

    @{actual_secondary_headings} =    Create List
    FOR    ${h2_element}    IN    @{h2_elements}
        ${text} =    Get Text    ${h2_element}

        Append To List    ${actual_secondary_headings}    ${text}
    END

    Should Be Equal    ${expected_secondary_headings}    ${actual_secondary_headings}
# robot -d results    Tests/crm.robot
