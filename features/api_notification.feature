Feature: Testing api notification for a group. INlcuding relation and JSON requests

  Scenario: finds a notification of a group not read
    Given There exists a work group
    When the group has a notification for a file created 1 hour ago
    And the group has a notification for a file created 2 hour ago
    Then a notification about a file created between 1 hour ago and now should exists
    And not one from 2 hour ago