Feature: User can manually add movie
 

@omniauth_test_success
Scenario: A user successfully signs in with Facebook
    Given I am on the RottenPotatoes home page
    When I follow "Sign in with Facebook"
    Then I should see "Successfully authenticated from Facebook account."

@omniauth_test_failure
Scenario: A user unsuccessfully signs in with Facebook
    Given I am on the RottenPotatoes home page
    And I follow "Sign in with Facebook"
    Then I should be on the RottenPotatoes home page
    