Feature: Play with projects
  In order to use codesolo
  A user
  wants to help/talk about projects

  Background:
	  Given I am logged in as "marley"
  
  Scenario: Register new project
    Given the following projects:
      |name|info|
      |rproject|Nice project in ruby|
      |42calc|A calculator with the answer|
    When I am on the projects page
	  Then I should see "rproject"
      And I should see "Help"
      And I should see "Watch"
	#    Then I should see the following projects:
	 #     |Name|Url|
