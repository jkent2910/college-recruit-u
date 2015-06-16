Feature: Student views students they are a fan of
  As a student
  I want to be able to see who I'm a fan of
  So that I know who I am keeping track of

  Scenario: Student views who she is a fan of
    Given I am Sarah
    And I have a student profile
    And another student "Sam" has a student profile
    And I am signed in
    And I am a fan of "Sam"
    And I am on my student profile page
    And I should see that I am a fan of "Sam"
