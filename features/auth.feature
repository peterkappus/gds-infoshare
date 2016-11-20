Feature: Can we log in and out?

	Scenario: See that we're logged out
		Given I am on the home page
		Then I should NOT see "Sign out"
		And I should see "Sign in"
