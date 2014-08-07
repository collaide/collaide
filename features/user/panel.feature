Feature: User's panel

  Scenario Outline: Not everybody can see user's profile and afferent pages
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
    | normal      | normal      | edit_user_registration | see     |
    | super_admin | normal      | edit_user_registration | see     |
# Le test ci-dessous ne fonctionne pas car on ne change pas d'url
# Mais on voit notre propre formulaire d'edition
    | normal      | super_admin | edit_user_registration | not see |
    |             | normal      | user_invitations       | not see |
    | normal      | normal      | user_invitations       | see     |
    | super_admin | normal      | user_invitations       | see     |
    | normal      | super_admin | user_invitations       | not see |
    |             | normal      | user_documents         | see     |
    | normal      | normal      | user_documents         | see     |
    | super_admin | normal      | user_documents         | see     |
    | normal      | super_admin | user_documents         | see     |
    |             | normal      | user_advertisements    | see     |
    | normal      | normal      | user_advertisements    | see     |
    | super_admin | normal      | user_advertisements    | see     |
    | normal      | super_admin | user_advertisements    | see     |
    |             | normal      | user_avatar            | see     |
    | normal      | normal      | user_avatar            | see     |
    | super_admin | normal      | user_avatar            | see     |
    | normal      | super_admin | user_avatar            | see     |



# TODO Pour les messages il faut changer et les attribuer au user
#    |             | normal      | messages               | not see |
#    | normal      | super_admin | messages               | not see |
#    | super_admin | normal      | messages               | see     |
#    | normal      | normal      | messages               | see     |
