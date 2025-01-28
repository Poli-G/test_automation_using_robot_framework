*** Settings ***
Library             Collections
Library             Browser

#    Go to wikipedia
# Suite Setup    Open browser
Test Setup          Go to wikipedia
Test Teardown       Close browser
# Suite Teardown    Close browser


*** Variables ***
${BASE_URL}     https://www.wikipedia.org/


*** Test Cases ***
Test Case1
    Go to wikipedia
    Perform search
    Verify heading
    Verify secondary headings contain


*** Keywords ***
Go to wikipedia
    # Browser.New Browser    browser=chromium
    New Context
    Open Browser    ${BASE_URL}
    Set Browser Timeout    30s

Perform search
    Fill Text    id=searchInput    steve jobs
    Click    xpath=//*[@id="search-form"]/fieldset/button

Verify heading
    # Verify heading    expected_heading=Steve Jobs
    Get Text    id=firstHeading    should be    Steve Jobs

Verify secondary headings contain
    @{expecte_secondary_headings} =    Create list
    ...    Early life
    ...    1974–1985
    ...    Health problems
    ...    Innovations and designs
    ...    Personal life
    ...    Honors and awards
 #-----------------------------
    @{h2_elements} =    Create List
    ...    # Get Elements    xpath=//*[id='vector-toc-pinned-container]'//a
    Get Elements    id=vector-toc-pinned-container/a

    @{actual_secondary_headings} =    Create List
    # Iterate through the h2 elements and add them to the list of actual headings
    FOR    ${h2_element}    IN    @{h2_elements}
        ${text} =    Get Text    ${h2_element}

        Append To List    @{actual_secondary_headings}    ${text}
    END
    # List comparison
    Should Be Equal    @{expecte_secondary_headings}    @{actual_secondary_headings}
#    robot -d results    crm.robot

