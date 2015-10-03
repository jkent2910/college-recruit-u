Feature: Student specifies choices for various factors
  As a student
  I want to specify how important various factors are to me
  So that my fans can see what matters to me

  Background:
    Given the following factors:
    | id | name         |
    |  1 | College size |
    |  3 | Cost         |
    And the following factor choices:
    | factor_id | name                | value |
    |         1 | Small               |     1 |
    |         1 | Large               |     2 |
    |         3 | Not important       |     1 |
    |         3 | Extremely important |     5 |
    And I am Sarah
    And I have a student profile
    And I am signed in

  @javascript
  Scenario: Student edits profile to set factor choices
    Given I am on my edit student profile page
    And I set the "College size" factor to "Small"
    And I set the "Cost" factor to "Extremely important"
    And I press "Update Student profile"
    Then I should be on my student profile page
    And I should see a "College size" factor of "Small"
    And I should see a "Cost" factor of "5"
