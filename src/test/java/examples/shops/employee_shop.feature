Feature: Karate script to play with Shops and Employees

  Background:
    * url baseUrl

  Scenario: create a new Shop on a city where an employee is
    # check structure of Employees
    Given path 'Employee'
    When method get
    Then status 200
    # ensure list is not empty
    And match response == '#[_ > 0]'
    # some fields might be empty
    And match each response == { id: '#number', lastName: '#string', firstName: '##string', address: { city: '##string' , country: '##string', zipCode: '##number', street: '##string' } }
    * def hasCityAndCountry = function(e){ return e.address != null && e.address.city != null && e.address.country != null }
    * def employeesWithCityAndCountry = karate.filter(response, hasCityAndCountry)
    And match employeesWithCityAndCountry == '#[_ > 0]'
    * def shopCity = employeesWithCityAndCountry[0].address.city
    * def shopCountry = employeesWithCityAndCountry[0].address.country
    * def shopName = 'Shop'+ java.lang.System.currentTimeMillis()
    * def newShop = { name: '#(shopName)', city: '#(shopCity)', country: '#(shopCountry)' }

    # create a new shop in the city of the first suitable employee (call create_shop)
    * def created = call read('create_shop.feature') { name: '#(shopName)', city: '#(shopCity)', country: '#(shopCountry)' }
    * def newShopId = created.shop.id

    * configure afterScenario = function(){ if (karate.get('newShopId')) karate.call('delete_shop.feature', { id: karate.get('newShopId') }) }

    # verify the created shop
    Given path 'Shops', newShopId
    When method get
    Then status 200
    And match response == { id: '#(newShopId)', name: '#(shopName)', city: '#(shopCity)', country: '#(shopCountry)' }

    # delete the new shop
    Given path 'Shops', newShopId
    When method delete
    Then status 200
    * def deletedId = newShopId
    * def newShopId = null

    # ensure that shop disappear and we have an error while get
    # should theorically send 404, but that api throws 204 instead
    Given path 'Shops', deletedId
    When method get
    Then status 204


