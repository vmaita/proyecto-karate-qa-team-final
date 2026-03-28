@automation-api
Feature: Productos - Obtener Listado de Productos por ID

  Background:
    * url urlBase
    * header Accept = 'application/json'
    * def loginResult = call read('classpath:bdd/auth/loginAuth.feature@token')
    * def authToken = loginResult.response.access_token
    * header Authorization = 'Bearer ' + authToken
    * def schemaGetProductById = read('classpath:resources/product/schemaGetProductById.json')

  @get-product-success
  Scenario Outline: CP<id_caso> - Listar producto pi ID <idProducto>
    * def idProduct = parseInt(idProducto)
    Given path 'api/v1/producto', idProducto
    When method GET
    Then status 200
    And match response == schemaGetProductById
    And match response.id == idProduct
    And match response.codigo == '#regex ^[A-Z]+.*'
    And match response.precio == '#regex ^\\d+\\.\\d{2}$'
    And match response.estado == '#number? _ >= 0'

    * print 'Producto validado: ' + response.nombre + ' con stock: ' + response.stock

    Examples:
      # 1. Validar el 'Total de productos recuperados' en el archivo getAllProducto.feature
      # ingresar un ID dentro del rango para q salgan tus casos de exito en el archivo CSV
      | read('classpath:resources/csv/product/dataGetProductOk.csv') |


  @get-product-error
  Scenario Outline: CP<id_caso> - Validar el ID <idProducto> No encotrado
    Given path 'api/v1/producto', idProducto
    When method GET
    Then status 404
    And match response == { "error": "Producto no encontrado" }
    * print response

    Examples:
      # 1. Validar el 'Total de productos recuperados' en el archivo getAllProducto.feature
      # ingresar un ID que este fuera del rango, actualizar en el archivo CSV
      | read('classpath:resources/csv/product/dataGetProductOkNo.csv') |