Feature: User creates profile for first time
  As a student
  I want to create a profile
  So that other students can learn more about me

  Scenario: student creates profile
    Given I am Sarah
    When I sign in for the first time
    Then I should be on the new student profile page
    When I fill in "First name" with "Sarah"
    And I fill in "Last name" with "Smith"
    And I fill in "Cell number" with "319-521-8353"
    And I select "Female" from "Gender"
    And I select "Valley High School" from "High school"
    And I select "2017" from "Graduation year"
    When I press "Create"
    Then I should be on my student profile page
    And I should see "Great! Your profile is created."

  Scenario: student bypasses creating a profile
    Given I am Sarah
    When I sign in for the first time
    Then I should be on the new student profile page
    And I follow "Skip"
    Then I should be on the student profiles page

  Scenario: student tries to create two profiles
    Given I am Sarah
    And I am signed in
    And I have already created a profile
    When I visit the new student profile page
    Then I should be on my student profile page
    And I should see "You have already created a profile."

  Scenario: student edits profile
    Given I am Sarah
    And I am signed in
    And I have already created a profile
    When I visit my edit student profile page
    When I select "2018" from "Graduation year"
    When I press "Update"
    Then I should be on my student profile page
    And I should see "2018"

  Scenario: student deletes profile
    Given I am Sarah
    And I am signed in
    And I have already created a profile
    When I visit my edit student profile page
    And I follow "Delete"
    Then I should be on the student profiles page
    And I should see "Student profile was successfully destroyed"
