Feature: User signs in
  As a student
  I want to sign in
  So I can use the application

  Scenario: student signs in
    Given I am Sarah
    And I am not signed in
    When I sign in
    Then I should be on the home page
    And I should see "Signed in successfully."
    And I should see "Signed in as sarah@school.k12.ia.us."

  Scenario: student signs in with wrong email
    Given I am Sarah
    And I am not signed in
    When I sign in with the wrong email
    Then I should see "Invalid email or password."

  Scenario: student signs in with wrong password
    Given I am Sarah
    And I am not signed in
    When I sign in with the wrong password
    Then I should see "Invalid email or password."
