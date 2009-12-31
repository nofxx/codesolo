Feature: Manage projects
  In order to use codesolo
  A user
  wants to manage his projects

  Background:
  	Given I am logged in as "marley"
  
  Scenario: Register new project
    Given I am on the new project page
	  Then I should see "New Project"
    When I fill in "Name" with "Super Proj"
      And I fill in "Url" with "someurl"
      And I fill in "Info" with "A nice project I want to do!"
      And I press "Save"
    Then I should see "Super Proj"
      And I should see "Todos"
	  When I am on the projects page
	  Then I should see "Super Proj"

  Scenario: Remove a project


