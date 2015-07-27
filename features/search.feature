Feature: Student searches for colleges and other students
  As a student
  I want to be able to search for colleges and other students
  So I can find colleges and find friends I know on the site

  Background:
    Given I am Sarah
    And I have a student profile
    And the following colleges:
    | name                  | college_type | city      | state         | region |
    | University of Iowa    | Public       | Iowa City | Iowa          | Town   |
    | Iowa State University | Public       | Ames      | Iowa          | Town   |
    | Harvard University    | Private      | Cambridge | Massachusetts | City   |

    And the following student profiles:
    | first_name | last_name | high_school                   |
    | Meghan     | Trainor   | Ankeny High School            |
    | Charlie    | Puth      | Ankeny Centennial High School |
    | John       | Harvard   | Valley High School            |

    And I am signed in

  Scenario: Student searches for Iowa
    When I search for "Iowa"
    Then I should be on the search results page
    And I should see "No students were found."
    And I should see the following colleges
    | name                  |
    | Iowa State University |
    | University of Iowa    |

  Scenario: Student searches for Harvard
    When I search for "Harvard"
    Then I should be on the search results page
    And I should see the following students
    | name         | high_school        |
    | John Harvard | Valley High School |
    And I should see the following colleges
    | name               |
    | Harvard University |

