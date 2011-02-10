Feature: Moderate a comment

  Moderation involves taking an unmoderated
  comment and, after possibly editing it,
  setting it's state to either published
  or rejected.

  Scenario: Publish a single comment
    Given 1 unmoderated Comment
    When the moderator publishes the Comment
    Then the moderator sees a green indication that the Comment is now published
    And the Comment should be displayed on the Article page
    And the moderator should see that there is 1 published Comment
    