Feature: Allow and manage different types of users: admins, goal owners, and non-owners. Show user info.

Scenario: Sign in as an admin and see "Manage Users", then sign out
  Given I sign in as an admin named "Jim" with the email "jim@wherever.com"
  Then I should see "Successfully signed in"
  And I should see "Manage users"

  When I click "Sign out"
  Then I should see "Successfully signed out"

Scenario: Sign in as a non-admin and DO NOT see "Manage Users"
  When I sign in as a non-admin named "Joe" with the email "joe@wherever.com"
  Then I should NOT see "Manage users"

Scenario: Get redirected when trying to access admin only functionality.
  And I sign in as a non-admin named "Joe" with the email "joe@wherever.com"
  And I visit "/users"
  Then I should see "requires admin"

@javascript
Scenario: Make someone an admin
  Given I sign in as an admin named "Jim" with the email "jim@wherever.com"
  And I create a new non-admin named "Dave" with the email "dave@test.com"
  And I click on "Manage users"
  Then I should see "Dave"
  And I should see "dave@test.com"
  When I click on the checkbox next to "dave@test.com"
  Then I should see "was successfully updated."
  When I click "Sign out"
  Then I should see "Successfully signed out"
  And I sign in using the email "dave@test.com"
  Then I should see "Manage users"
