#Feature: I want to test the good functionality of the topics
#
#  Scenario: I can post a new topic
#    Given: I'm a member of a work group
#    When: I start a new topic
#    Then: I should see the topic I started

Feature: I want to test the good functionality of the topic of work groups

  Background:
    Given I am authenticated as a "normal" user
    And I am a member of a work group

  Scenario: I can post a new topic
    Given I visit the topic's page of the group
    When I start a new topic
    Then I sould see the topic I started

  Scenario: I want to have pagination of work groups
    Given There are more than 50 topics
    When I visit the topic's page of the group
    Then I should see the pagination