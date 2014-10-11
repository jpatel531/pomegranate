Feature: As a user I can create a tutorial

	Background:
		Given I am logged in	

	@javascript
	Scenario: before I can create a tutorial
		Given I am on the dashboard page
		And I click to create a new tutorial
		When I click on a repository of mine
		Then I should be on the tutorial page 
		And I should be given a list of instructions