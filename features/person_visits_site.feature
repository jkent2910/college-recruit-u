Feature: Person visits site
  As a person
  I visit the Collge Recruit U site
  So I can learn more about it

  Scenario: Person views home page
    Given I am anybody
    And I visit the home page
    Then I should be on the home page
    And I should see "Sign in"
    And I should see "Sign up"

  Scenario: Person tries to create new student profile
    Given I am anybody
    And I visit the new student profile page
    Then I should be on the sign in page
    And I should see "You need to sign in or sign up before continuing."
