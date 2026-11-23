Feature: Karate script to browse shops and coffees

  Background:
    * url baseUrl

  Scenario: get all Shops and verify the general structure of the response then verify the first entry, ensure they have coffees
    # check structure of Shops info
    Given path 'Shops'
    When method get
    Then status 200
    #ensure list is not empty
    And match response == '#[_ > 0]'
    And match each response == { id: '#number', city: '#string', country: '#string', name: '#string' }

    * def firstShop = response[0]

    # once retrieved first Shop of the list, verify data
    Given path 'Shops', firstShop.id
    When method get
    Then status 200
    And match response == { id: '#(firstShop.id)', city: '#(firstShop.city)', country: '#(firstShop.country)', name: '#(firstShop.name)' }

    # inspect structure of coffees linked to the shop
    Given path 'Shops', firstShop.id, 'coffees'
    When method get
    Then status 200
    # ensure list is not empty
    And match response == '#[_ > 0]'
    And match each response == { id: '#number', description: '##string', name: '##string' }



