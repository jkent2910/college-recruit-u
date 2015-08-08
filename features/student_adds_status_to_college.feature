Feature: Student adds status to a college
  As a student
  I want to specify my interest level in different colleges
  So that my fans can see what schools I'm interested in

  Background:
    Given I am Sarah
    And I have a student profile
    And the following college:
    | name               | college_type | city      | state | region |
    | University of Iowa | Public       | Iowa City | Iowa  | Town   |
    | Mount Mercy University | Private | Cedar Rapids | Iowa | Town |
    And I am signed in

  @javascript
  Scenario: Student adds status to a specific college
    Given I am on the "University of Iowa" college show page
    And I select "Considering" from "College Status:"
    And I press "Add College"
    Then I should be on the "University of Iowa" college show page
    And I should see "You are now Considering University of Iowa"

  @javascript
  Scenario: Student tries to add status of "Enrolling" to multiple colleges
    Given I am on the "University of Iowa" college show page
    And I select "Enrolling" from "College Status:"
    And I press "Add College"
    Then I should be on the "University of Iowa" college show page
    And I should see "You are now Enrolling in University of Iowa"
    Then I am on the "Mount Mercy University" college show page
    And I select "Enrolling" from "College Status:"
    And I press "Add College"
    Then I should be on the "Mount Mercy University" college show page
    And I should see "You can only enroll at one school"
