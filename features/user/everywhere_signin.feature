Feature: Sign in from every pages with the side panel
#  @javascript
#  Scenario: Sign in attempt
#    Given a user visits the welcome page
#    When he click the sign in button
#    Then he should see the sign in form in the right panel

  @javascript
  Scenario: Unsuccessful sign in
    Given a user visits the welcome page
    And he click the sign in button
    When he submit invalid information for the in page form
    Then he should see an error message in the right panel

  @javascript
  Scenario: Successful sign in
    Given a user visits the welcome page
    And he click the sign in button
    And a normal user has an account
    When he submit valid information for the in page form
    Then he should see the welcome message
    And he should see a signout link