@automation-api
Feature: Gestión de Productos - Obtener Todos

  Background:
    * url urlBase
    * header Accept = 'application/json'
    # invocamos tu escenario de login para obtener el token
    * def loginResult = call read('classpath:bdd/auth/loginAuth.feature@token')
    * def authToken = loginResult.response.access_token
    * header Authorization = 'Bearer ' + authToken
    * def schemaProductData = read('classpath:resources/product/schemaProductData.json')

  @get-all
  Scenario: CP01 - Consultar lista completa de productos exitosamente
    Given path 'api/v1/producto'
    When method GET
    Then status 200

    And match response.data == '#[]'
    And match each response.data == schemaProductData
    And match response.data != []
    And match response.data[0].nombre == 'ALTERNADOR PL135'
    And match each response.data[*].estado == '#number'

    * print 'Total de productos recuperados: ', response.data.length