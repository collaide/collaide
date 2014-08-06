#Feature:
#
#  Scenario: Everybody can see user's profil
#    Given the following users
#      | user        |
#      | super_admin |
#      | normal      |
#    Given I am logged is as <login>
#    When I visit profile for <profile>
#    Then I should <action>
#
#    Examples:
#      | login | profile | action        |
#      |       | normal  | see "Profile" |
#      | normal| normal  | see "Profile" |
#      | admin | normal  | see "Profile" |
#      | normal| admin   | see "Profile" |

Feature: User's panel

  Scenario Outline: Everybody can see user's profile
    Given the following users
      | role        |
      | super_admin |
      | normal      |
    Given I am logged in as "<login>"
    When I visit "<path>" for "<role>"
    Then I should "<visit>" "<path>" for "<role>"

  Examples:
    | login       | role        | path                   | visit   |
    |             | normal      | user                   | see     |
    | normal      | normal      | user                   | see     |
    | super_admin | normal      | user                   | see     |
    | normal      | super_admin | user                   | see     |
    |             | normal      | edit_user_registration | not see |
    |             | normal      | user_invitations       | not see |
    | normal      | super_admin | user_invitations       | not see |
    | normal      | normal      | user_invitations       | see     |
