Feature: Student views her fans
  As a student
  I want to be able to see who my fans are
  So that I know who is wanting to keep track of my profile

  Scenario: Student views fans
    Given I am Sarah
    And I have a student profile
    And another student "Sam" has a student profile
    And I am signed in
    And "Sam" is a fan of mine
    And I am on my student profile page
    And I should see "Sam" listed in my fans
