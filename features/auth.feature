Feature: Can we log in and out?

	Scenario: See that we're logged out
		Given I am on the home page
		Then I should NOT see "Sign out"
		And I should NOT see "Products"
		And I should see "Sign in"

	Scenario: Failed login using non-existant account
		Given I sign in using the email "nonexistant@whatever.com"
		Then I should NOT see "Success"
		And I should see "Sorry, could not find an account with the email"

	Scenario: Login as a regular user
		Given I create a new non-admin named "Peter Test" with the email "test@test.com"
		And I sign in using the email "test@test.com"
		Then I should see "Peter Test"
		And I should see "Successfully signed in as Peter Test"
		When I click "Sign out"
		Then I should NOT see "Peter Test"
		And I should see "Successfully signed out."
