@automation-api
Feature: Registro - Creación de usuario completo

  Background:
    * url urlBase
    * def registerBody = read('registerAuth.json')
    * def schemaValidator = read('classpath:resources/register/schemaValidator.json')
    * configure headers = { Accept: 'application/json', Content-Type: 'application/json' }

  Scenario Outline: CP<id_caso> - Registro de <caso_prueba>
    # Seteamos el email final en el body antes de enviar la petición
    * set registerBody.email = email
    * set registerBody.nombre = nombre
    * set registerBody.password = password
    * set registerBody.tipo_usuario_id = parseInt(tipo_usuario_id)
    * set registerBody.estado = 1
    * print 'Email a registrar:', email
    * print 'Request Body:', registerBody

    Given path 'api/register'
    And request registerBody
    When method post
    * print 'Status recibido:', responseStatus
    * print 'Response Body:', response
    Then status <status_esperado>
    # --- VALIDACIONES  ---
    # Si es exitoso (200)
    * if (responseStatus == 200) karate.match(response, schemaValidator)
    * if (responseStatus == 200) karate.match(response.access_token, '#string')

    # Si es error (No es 200)
    * if (responseStatus != 200) karate.match(response.email[0], 'The email has already been taken.')

    Examples:
      #en el archivo csv, cambiar la data de nombre y email
      |read('classpath:resources/csv/register/dataRegister.csv')|



