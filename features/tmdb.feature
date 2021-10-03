Feature: User can add movie by searching for it in The Movie Database (TMDb)
 
  As a movie fan
  So that I can add new movies without manual tedium
  I want to add movies by looking up their details in TMDb
 
Background: Start from the Search form on the home page
 
  Given I am on the RottenPotatoes home page
  Then I should see "Search TMDB for a movie"
 
Scenario: Try to add nonexistent movie (sad path)
 
  Given I am on the RottenPotatoes home page
  Then I should see "Search TMDB for a movie"
  When I fill in "search_tmdb" with "Movie That Does Not Exist"
  And I press "Search TMDb"
  Then I should see "Sorry, No match for 'Movie That Does Not Exist'"
 
Scenario: Try to add existing movie (happy path)

  When I fill in "search_tmdb" with "Inception"
  And I press "Search TMDb"
  Then I should be on the Search TMDb page
  And I should not see "not found"
  And I should see "Inception"
