Feature: Create a shop with a given name, city and country

  @ignore
  Scenario: Create a shop with a given name, city and country

    # create a new shop with given name, city and country
    Given url baseUrl
    And path 'Shops'
    * def newShop = { name: '#(name)', city: '#(city)', country: '#(country)' }
    And request newShop
    When method post
    Then status 200
    And match response contains newShop
    And match response.id == '#number'
    * def shop = response
