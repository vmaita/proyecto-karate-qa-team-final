@automation-api
Feature: Productos - Creación de Nuevos Productos

  Background:
    * url urlBase
    # llamamos solo al escenario exitoso usando su etiqueta (@token)
    * def loginResult = callonce read('classpath:bdd/auth/loginAuth.feature@token')
    # extraemos el token directamente del objeto response capturado
    * def token = loginResult.response.access_token
    * def schemaValidatorProduct = read('classpath:resources/product/schemaValidatorProduct.json')
    * def productBaseBody = read('classpath:bdd/product/newProduct.json')
    * header Accept = 'application/json'
    * header Authorization = 'Bearer ' + token

  @CrearProducto
  Scenario Outline: CP<id_caso> - <nombre_caso>

    * copy payload = productBaseBody

    * set payload.codigo = codigo
    * set payload.nombre = nombre
    * set payload.medida = medida
    * set payload.marca = marca
    * set payload.categoria = categoria
    * set payload.precio = precio
    * set payload.stock = stock
    * set payload.estado = estado
    * set payload.descripcion = descripcion

    Given path 'api/v1/producto'
    And request payload
    When method POST
    Then status <status_esperado>

    * if (responseStatus == 201 || responseStatus == 200) karate.match("response == schemaValidatorProduct")

    * def logMessage =
    """
    function(status, res) {
      if (status == 201 || status == 200) {
        karate.log('✅ ÉXITO - ID:', res.id, 'Nombre:', res.nombre);
      } else {
        // Esta lógica busca CUALQUIER llave que contenga un arreglo de mensajes
        var msg = res.error || res.message;
        if (!msg) {
          for (var key in res) {
            if (Array.isArray(res[key])) {
              msg = key + ": " + res[key][0];
              break;
            }
          }
        }
        karate.log('❌ FALLO CONTROLADO (' + status + ') - Mensaje:', msg || 'Error no mapeado');
      }
    }
    """

    * eval logMessage(responseStatus, response)

    Examples:
      # cambiar en el archivo csv, el campo código de los 5 primeros productos
      | read('classpath:resources/csv/product/dataNewProduct.csv') |