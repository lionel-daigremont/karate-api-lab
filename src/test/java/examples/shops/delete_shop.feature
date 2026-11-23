Feature: Delete the shop and confirm deletion

  @ignore
  Scenario: Delete the shop and confirm deletion

    # delete the new shop
    Given url baseUrl
    And path 'Shops', id
    When method delete
    Then status 200

    # ensure that shop disappear and we have an error while get
    Given url baseUrl
    And path 'Shops', id
    When method get
    Then status 204