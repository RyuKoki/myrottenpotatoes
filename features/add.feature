Feature: User can manually add movie

Background: Start from the Search form on the home page
  Given I am on the RottenPotatoes home page

@omniauth_test_success
Scenario: Add a movie
  When I follow "Add new movie"
  Then I should see "You have to login first!!!"
  When I should see "Sign in with Facebook"
  And I follow "Sign in with Facebook"
  Then I should see "Successfully authenticated from Facebook account."
  When I follow "Add new movie"
  Then I should be on the Create New Movie page
  When I fill in "Title" with "Men In Black"
  And I select "PG-13" from "Rating"
  And I press "Save Changes"
  Then I should be on the Review new page
  And I should see "Men In Black"

