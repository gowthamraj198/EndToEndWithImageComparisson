Feature: Verify current time

  @current_time
  Scenario: Verify current time
    Given   User is in test page
    When    User enters milliseconds "1538852207061"
    Then    User takes the screenshot "current_time" "1400" "1900"
