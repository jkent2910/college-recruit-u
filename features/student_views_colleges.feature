Feature: Student views colleges
  As a student
  I want to be able to see what colleges are available
  So that I can get information about the colleges in which I'm interested

  Background:
    Given I am Sarah
    And I am signed in
    And the following colleges:
    | name                  | college_type | city      | state         | region |
    | University of Iowa    | Public       | Iowa City | Iowa          | Town   |
    | Iowa State University | Public       | Ames      | Iowa          | Town   |
    | Harvard University    | Private      | Cambridge | Massachusetts | City   |

  Scenario: Student views colleges alphabetically
    Given I am on the colleges page
    # And I follow "View Alphabetically"
    Then I should see the following colleges:
    | name                  | students |
    | Harvard University    |        0 |
    | Iowa State University |        0 |
    | University of Iowa    |        0 |

  Scenario: Student views colleges by popularity
    Given the colleges have the following student interest:
    | name                  | Just a Fan | Considering | Applying | Enrolling |
    | University of Iowa    |          1 |           1 |        1 |           |
    | Iowa State University |          1 |           2 |          |         1 |
    | Harvard University    |            |             |          |           |
    And I am on the colleges page
    And I follow "View by Popularity"
    Then I should see the following colleges:
    | name                  | students |
    | Iowa State University |        4 |
    | University of Iowa    |        3 |
    | Harvard University    |        0 |

