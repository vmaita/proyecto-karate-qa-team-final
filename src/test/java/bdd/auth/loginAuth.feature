@automation-api
Feature: Autenticación de Usuario

  Background:
    * url urlBase
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * def loginSchema = read('classpath:resources/json/auth/loginSchema.json')
    * def loginBodyBase = read('classpath:bdd/auth/loginAuth.json')

  @token
  Scenario Outline: CP<id_caso> - <caso_prueba>
    * def userNombre = '<nombre_esperado>'
    * copy loginBody = loginBodyBase
    * set loginBody.email = email
    * set loginBody.password = password

    Given path 'api/login'
    And request loginBody
    When method POST
    Then status 200
    And match response == loginSchema
    And match response.user.nombre == '<nombre_esperado>'
    And match response.user.email == email
    And match response.access_token == "#regex ^\\d+\\|.+"
    And match response.token_type == "Bearer"
    * print 'Login exitoso para: ', response.user.nombre

    Examples:
      | read('classpath:resources/csv/login/dataLoginOK.csv') |



    @token-noOk
   # Caso de prueba de Datos incorrectos:
  Scenario Outline: CP<id_caso> - <caso_prueba>
    * copy loginBody = loginBodyBase
    * set loginBody.email = email
    * set loginBody.password = password

    Given path 'api/login'
    And request loginBody
    When method POST
    Then status 401
    And match response == { "message": "Datos incorrectos" }
    And match response.access_token == "#notpresent"

    * print response

    Examples:
      | read('classpath:resources/csv/login/dataLoginNoOk.csv') |




