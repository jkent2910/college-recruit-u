Feature: User logs in
  As a student
  I want to log in
  So I can use the application

  Scenario: student logs in
    Given I am Sarah
    And I am not logged in
    When I log in
    Then I should be on the home page
    And I should see "Signed in successfully."
    And I should see "Signed in as sarah@school.k12.ia.us."

  Scenario: student logs in with wrong email
    Given I am Sarah
    And I am not logged in
    When I log in with the wrong email
    Then I should see "Invalid email or password."

  Scenario: student logs in with wrong password
    Given I am Sarah
    And I am not logged in
    When I log in with the wrong password
    Then I should see "Invalid email or password."
