@petstore @user
Feature: PetStore API - User CRUD Operations
  Como QA Engineer,
  quiero validar las operaciones CRUD del módulo de usuarios de la API PetStore,
  para garantizar que los endpoints de creación, consulta, actualización y eliminación
  funcionan correctamente según la especificación Swagger.

  Background:
    * url baseUrl
    * def testData = read('classpath:petstore/user/data/user-data.json')
    * def schemas = read('classpath:petstore/user/schema/user-schema.json')

  @create
  Scenario: Crear un usuario mediante POST /user
    * def newUser = testData.createUser

    Given path 'user'
    And request newUser
    When method post
    Then status 200
    And match response == schemas.apiResponse

  @get
  Scenario: Buscar el usuario creado mediante GET /user/{username}
    * def expected = testData.createUser

    Given path 'user', expected.username
    When method get
    Then status 200
    And match response == schemas.userResponse
    And match response contains
      """
      {
        id: #(expected.id),
        username: '#(expected.username)',
        firstName: '#(expected.firstName)',
        lastName: '#(expected.lastName)',
        email: '#(expected.email)',
        phone: '#(expected.phone)',
        userStatus: #(expected.userStatus)
      }
      """

  @update
  Scenario: Actualizar firstName y email del usuario mediante PUT /user/{username}
    * def original = testData.createUser
    * def updated = testData.updateUser

    Given path 'user', original.username
    And request updated
    When method put
    Then status 200
    And match response == schemas.apiResponse

  @get @verify-update
  Scenario: Verificar que los datos del usuario fueron actualizados mediante GET /user/{username}
    * def expected = testData.updateUser

    Given path 'user', expected.username
    When method get
    Then status 200
    And match response == schemas.userResponse
    And match response.firstName == expected.firstName
    And match response.email == expected.email

  @delete
  Scenario: Eliminar el usuario mediante DELETE /user/{username}
    * def target = testData.updateUser

    Given path 'user', target.username
    When method delete
    Then status 200
    And match response == schemas.apiResponse
    And match response.message == target.username

  @delete @verify-delete
  Scenario: Verificar que el usuario eliminado ya no existe mediante GET /user/{username}
    * def target = testData.updateUser

    Given path 'user', target.username
    When method get
    Then status 404
    And match response.message == 'User not found'
