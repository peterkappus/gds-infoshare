Feature: Import deployment data from a CSV exported from Google Sheets. (someday go direct via the API)

@wip
#TODO: figure out how browsing deployments should work. What's the user need?
Scenario: Import data, see deployments
  Given I am logged in
  When I import benefits data
  And I click on "Benefits"
  Then I should see "Guest Wifi"
