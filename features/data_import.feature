Feature: Import deployment data from a Google Sheet exported CSV. (someday go direct via the API)

@wip
#TODO: figure out how browsing deployments should work. What's the user need?
Scenario: Import data, see deployments
  Given I am logged in
  When I import deployment data
  And I click on "Deployments"
  Then I should see "Core"
