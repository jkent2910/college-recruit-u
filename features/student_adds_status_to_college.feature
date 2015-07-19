Feature: Student adds status to a college
  As a student
  I want to specify my interest level in different colleges
  So that my fans can see what schools I'm interested in

  Background:
    And I am Sarah
    And I have a student profile
    And the following college:
    | name               | college_type | city      | state | region |
    | University of Iowa | Public       | Iowa City | Iowa  | Town   |
    And I am signed in

  @javascript
  Scenario: Student adds status to a specific college
    Given I am on the "University of Iowa" college show page
    And I select "Considering" from "College Status:"
    And I press "Add College"
    Then I should be on the "University of Iowa" college show page
    And I should see "You are now Considering University of Iowa"
