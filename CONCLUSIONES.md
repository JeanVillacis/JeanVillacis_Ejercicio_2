# Reporte de Hallazgos y Conclusiones - Pruebas QA

**Proyecto:** PetStore API (Módulo de Usuarios)
**Framework:** Karate DSL 1.5.0
**Autor:** Jean Pierre Villacis

---

## 1. Resumen  de pruebas
Se diseñó e implementó una suite de pruebas automatizadas enfocada en el ciclo de vida completo (flujo CRUD) de un usuario dentro de la API pública de PetStore. La ejecución fue exitosa, confirmando que la API cumple con la lógica de negocio fundamental (crear, consultar, actualizar y eliminar registros). 


## 2. Métricas de Ejecución
- **Total de Escenarios Ejecutados:** 6
- **Tasa de Éxito (Pass Rate):** 100% (6/6 Passed)
- **Tasa de Fallos (Fail Rate):** 0%
- **Tiempo Promedio de Ejecución:** ~2.3 segundos (Dependiente de latencia de red)
- **Cobertura Operacional:** Endpoints POST, GET, PUT, y DELETE para `/user`.

## 3. Matriz de Cobertura y Trazabilidad

| Flujo | Método | Endpoint | Status Code Esperado | Resultado | Observación QA |
|-------|--------|----------|----------------------|-----------|-----------------|
| Crear | `POST` | `/user` | `200 OK` | ✅ Passed | Verifica creación inicial. |
| Buscar | `GET` | `/user/{username}` | `200 OK` | ✅ Passed | Valida persistencia de los 7 campos enviados. |
| Actualizar | `PUT` | `/user/{username}` | `200 OK` | ✅ Passed | Update parcial/total exitoso. |
| Verificar Actualización | `GET` | `/user/{username}` | `200 OK` | ✅ Passed | Confirma que `firstName` y `email` mutaron en DB de forma persistente. |
| Eliminar | `DELETE` | `/user/{username}` | `200 OK` | ✅ Passed | Devuelve el username eliminado en el response body. |
| **Aserción de Eliminación** | `GET` | `/user/{username}` | `404 Not Found` | ✅ Passed | *Paso extra de resiliencia QA para verificar la destrucción real del recurso.* |

## 4. Hallazgos

Durante la implementación y ejecución de las pruebas, se identificaron los siguientes comportamientos en la API desde la perspectiva de mejores prácticas RESTful:

1. **Desviación de Estándares HTTP REST en Modificadores de Estado (POST/PUT/DELETE):**
   - **Post (Creación):** La API retorna un código de estado `200 OK` al crear un recurso. Según los estándares REST, la respuesta idónea para la creación de un recurso debería ser `201 Created`.
   - **Estructura del Response:** En los métodos POST, PUT y DELETE, el servidor no devuelve el objeto creado/modificado, sino un objeto estructurado genérico de "Operation Status" (`{ "code": 200, "type": "unknown", "message": "ID_O_USERNAME" }`).
2. **Uso de Path Parameters como Identificador Único:**
   - Para las transacciones de lectura y actualización (`GET`, `PUT`, `DELETE`), el sistema emplea el `username` como clave primaria de la ruta (`/user/{username}`), a pesar de que en la creación inicial (`POST`) se provee explícitamente un atributo numérico de identificación (`id`).
3. **Persistencia y Congruencia de Datos:**
   - La API gestiona la consistencia transaccional correctamente. Las pruebas de mutación (Scenario 3 y 4) reflejaron inmediatamente los cambios (update de correo electrónico y nombre) sin latencia caché aparente. El estado del dato se mantuvo fiable en todas las lecturas.

## 5. Conclusiones

### A. Conclusiones
La API PetStore (`/v2/user`) es funcional y satisface los criterios de aceptación relacionados con el "Happy Path" de un CRUD. Las automatizaciones implementadas bajo Karate Framework demostraron la estabilidad actual del microservicio. La integración de *Schema Validations* garantiza que cualquier futura violación de contrato en los microservicios será capturada inmediatamente por la suite.

---
