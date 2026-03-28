@automation-api
Feature: Productos - Actualizar Producto

  Background:
    * url urlBase
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:bdd/auth/loginAuth.feature@token')
    * def authToken = loginResult.response.access_token
    * header Authorization = 'Bearer ' + authToken
    * def schemaUpdate = read('classpath:resources/product/schemaUpdateProduct.json')
    * def requestPayload = read('updateProduct.json')

  @update-success
  Scenario Outline: <id_caso> - Actualizar producto <nombre> (ID: <idProducto>)
    * set requestPayload.codigo = codigo
    * set requestPayload.nombre = nombre
    * set requestPayload.medida = medida
    * set requestPayload.marca = marca
    * set requestPayload.categoria = categoria
    * set requestPayload.precio = precio
    * set requestPayload.stock = stock
    * set requestPayload.estado = estado
    * set requestPayload.descripcion = descripcion

    * print 'Enviando actualización para ID:', idProducto
    * print 'Payload enviado:', requestPayload

    Given path 'api/v1/producto', idProducto
    And request requestPayload
    When method PUT
    Then status 200
    * print 'Response recibida:', response
    And match response.nombre == nombre
    And match response.codigo == '#regex ^[A-Z]+\\d+'
    And match response.precio == '#regex ^[1-9]\\d*(\\.\\d{1,2})?$'
    And match response.stock == '#number'
    And match response == schemaUpdate
    And match response.codigo == '#regex ^[A-Z]+.*'

    * print 'Validación exitosa para el caso:', id_caso

    Examples:
     # Actualizar la data en el archivo csv, para ejecutar más actualizaciones de pruebas.
      | read('classpath:resources/csv/product/dataUpdateProduct.csv') |


  @update-error
  Scenario Outline: <id_caso> - Validar error del ID <idProducto> inexistente
    Given path 'api/v1/producto', idProducto
    And request requestPayload
    When method PUT
    # Aquí ya sabemos que la API falla con 500, así que lo marcamos como esperado
    Then status 500
    And match response.error == '#string'
    And match response.error contains 'null'
    * print response.error
    * print 'Bug confirmado y capturado para el ID:', idProducto

    Examples:

      | read('classpath:resources/csv/product/dataUpdateProductOkNo.csv') |
