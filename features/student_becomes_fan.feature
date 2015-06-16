Feature: Student becomes fan
  As a student
  I want to be able to become a fan of my friends
  So that I can keep track of what colleges they're considering

  Background:
    Given I am Sarah
    And I have a student profile
    And another student "Sam" has a student profile
    And I am signed in

  Scenario: Student becomes a fan of another student
    Given I am on the student profiles page
    Then I should see "Sam"
    When I follow "Become a Fan"
    Then I should be on the student profiles page
    And I should see "Sam"
    And I should see "Stop being a Fan"

  Scenario: Student stops being a fan of another student
    Given I am a fan of "Sam"
    And I am on the student profiles page
    Then I should see "Sam"
    When I follow "Stop being a Fan"
    Then I should be on the student profiles page
    And I should see "Sam"
    And I should see "Become a Fan"
