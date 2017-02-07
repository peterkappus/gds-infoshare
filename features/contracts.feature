Feature: Browse contracts

@wip
	Scenario: Import data
		Given I import contract data
    And I sign in as an admin named "Peter" with the email "peter@wherever.com"
    And I click on "Contracts" within ".nav"
    Then I should see "Showing"
