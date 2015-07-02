Feature: Student specifies importance of various factors
  As a student
  I want to specify how important various factors are to me
  So that my fans can see what matters to me

  Background:
    Given the following factors:
      | name         |
      | College size |
      | Cost         |
    And I am Sarah
    And I have a student profile
    And I am signed in

  @javascript
  Scenario: Student edits profile to set factor importance
    Given I am on my edit student profile page
    And I set the importance of "College size" to "4"
    And I set the importance of "Cost" to "2"
    And I press "Update Student profile"
    Then I should be on my student profile page
    And I should see "College size 4"
    And I should see "Cost 2"
