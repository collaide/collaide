Feature: Signing in from the dedicated page
  
  Scenario: Unsuccessful sign in
    Given a user visits the signin page
    When he submits invalid signin information
    Then he should see an error message
  
  Scenario: Successful signin
    Given a user visits the signin page
      And a normal user has an account
    When the normal user submits valid signin information
    Then he should see the welcome message
      And he should see a signout link