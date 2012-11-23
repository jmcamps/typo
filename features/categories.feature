Feature: Create categories
  As a blog administrator
  In order to unify contents on the same topic
  I want to be able to merge the current article with another

  Background:    
	Given the blog data is published
	 
  Scenario: Admin users should create categories
    Given I am logged as admin    
    And I go to the new category page
    Then I should see "Categories"   	  	
  	