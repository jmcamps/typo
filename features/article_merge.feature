Feature: Merge Articles
  As a blog administrator
  In order to unify contents on the same topic
  I want to be able to merge the current article with another

  Background:    
	Given the blog data is published
	 
  Scenario: Non logged user cannot merge two articles
  	Given  I go to the edit article 3
    Then I should not see "Merge"
  
  Scenario: Publisher users should not merge articles
    Given I am logged as publisher    
    And I go to the edit article 4
    Then I should not see "Merge"
  	
  Scenario: Admin users should merge articles on their articles
    Given I am logged as admin    
    And I go to the edit article 3
    Then I should see "Merge"
  
  Scenario: We can see comments on articles
    Given I am logged as admin    
    And I go to the comments feewdback for article 3 page
    Then I should see "Admin comment"  
  
  Scenario: Merge articles should leave the title from the first article 
    Given I merge article 3 with article 4   
    And I go to the admin content page	  	    
  	Then I should see "Admin article"   	
  	
  
  Scenario: Merge articles should merge two bodies in the first article 
    Given I merge article 3 with article 4   
    And I go to the edit article 3 	  	    
  	Then I should see "Body for admin article"   	
  	And I should see "Body for publisher article"
  
  Scenario: Merge articles should copy all comments from second article to the first article 
    Given I merge article 3 with article 4   
    And I go to the comments feewdback for article 3 page   
  	Then I should see "Admin comment"   	
  	And I should see "Publisher comment"
  	
  Scenario: Merge articles should delete second article 
    Given I merge article 3 with article 4   
    And I go to the admin content page	  	    
  	Then I should not see "Publisher article"   	  	
  	