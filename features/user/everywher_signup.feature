Feature: Try to sign up from every pages with the off canvas

  @javascript
  Scenario: Valid sign up
    Given a user visits the welcome page
    And clicks the sign up button
    When he submits a valid sign up form
    Then he should see the welcome message for the registration
    And he should see a signout link

  @javascript
  Scenario: Invalid e-mail
    Given a user visits the welcome page
    And clicks the sign up button
    When he fills the e-mail field with invalid e-mail and focus out
    Then he should see an error message under the e-mail field

  @javascript
  Scenario: Invalid sign up
    Given a user visits the welcome page
    And clicks the sign up button
    When he submits an invalid sign up form
    Then he should see an error message under the e-mail field