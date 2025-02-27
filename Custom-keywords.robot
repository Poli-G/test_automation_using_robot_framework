*** Settings ***
Library             Collections
Library             Browser

Suite Setup         Setup Browser
Suite Teardown      Close Browser
Test Setup          Go to wikipedia
Test Teardown       Close Page


*** Test Cases ***
Test Case1
    Perform search

    Verify heading

    Verify secondary headings contain


*** Keywords ***
Setup Browser
    New Browser    chromium    headless=False
    New Context

Go to wikipedia
    New Page    https://www.wikipedia.org/
    Set Browser Timeout    30s

Perform search
    Fill Text    id=searchInput    steve jobs
    Click    xpath=//*[@id="search-form"]/fieldset/button

Verify heading
    ${heading} =    Get Text    id=firstHeading
    Should Be Equal    ${heading}    Steve Jobs

Verify secondary headings contain
    # Define expected secondary headings
    @{expected_secondary_headings} =    Create List
    ...    Early life
    ...    1974–1985
    ...    Health problems
    ...    Innovations and designs
    ...    Personal life
    ...    Honors and awards

    # Get all H2 elements
    # Wait For Elements State    //div[@id='mw-content-text']//h2    visible    timeout=10s
    @{h2_elements} =    Get Elements    //div[@id='mw-content-text']//h2

    # Ensure `h2_elements` is a list before checking its length
    ${h2_elements_length} =    Get Length    ${h2_elements}
    Should Be True    ${h2_elements_length} > 0    No headings found!

    # Initialize the actual_secondary_headings list
    ${actual_secondary_headings} =    Create List

    # Extract text from each H2 element
    FOR    ${h2_element}    IN    @{h2_elements}
        ${text} =    Get Text    ${h2_element}
        Append To List    ${actual_secondary_headings}    ${text}
    END

    # Debug: Print actual headings
    Log To Console    Actual Secondary Headings: ${actual_secondary_headings}

    # Compare each expected heading to actual headings
    FOR    ${expected_heading}    IN    @{expected_secondary_headings}
        Log To Console    Checking: ${expected_heading}
        Should Contain    ${actual_secondary_headings}    ${expected_heading}
    END

    # robot Custom-keywords.robot
