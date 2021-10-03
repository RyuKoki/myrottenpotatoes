Feature: User can manually see detail movie

Scenario: See detail a movie
  Given I am on the Aladdin page
  Then I should see "Description:"
  And I should see "Edit Info"
  And I should see "Delete"
  When I follow "Back to movie list"
  Then I should be on the RottenPotatoes home page
