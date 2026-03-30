# PetStore API - Karate Framework Testing

Proyecto de automatización de pruebas API REST para el módulo de usuarios de [Swagger PetStore](https://petstore.swagger.io/) utilizando **Karate Framework**.

## Tecnologías

| Tecnología | Versión |
|-----------|---------|
| Java | 11 |
| Karate | 1.5.0 |
| JUnit 5 | 5.x |
| Maven | 3.x |

## Estructura del Proyecto

```
src/test/java/
├── karate-config.js              # Configuración global (URL, headers, timeouts)
├── logback-test.xml              # Configuración de logs
│
└── petstore/                     # Dominio: PetStore API
    ├── PetStoreTest.java         # Runner principal
    │
    └── user/                     # Módulo: Usuarios
        ├── UserRunner.java       # Runner individual del módulo
        ├── user-crud.feature     # Casos de prueba CRUD
        └── data/
            └── user-data.json    # Datos de prueba externalizados
```

## Casos de Prueba

| # | Caso | Método | Endpoint |
|---|------|--------|----------|
| 1 | Crear un usuario | POST | `/user` |
| 2 | Buscar el usuario creado | GET | `/user/{username}` |
| 3 | Actualizar nombre y correo del usuario | PUT | `/user/{username}` |
| 4 | Verificar los datos actualizados | GET | `/user/{username}` |
| 5 | Eliminar el usuario | DELETE | `/user/{username}` |
| 6 | Verificar que el usuario fue eliminado | GET | `/user/{username}` |

## Instrucciones de Ejecución (Paso a Paso)

### Pre-requisitos
1. Tener instalado **Java 11** o superior.
2. Tener instalado **Apache Maven 3.x**.
3. Tener clonado este repositorio y una terminal abierta.

### Paso 1: Abrir la terminal en el proyecto
Abre tu consola de comandos o la terminal de tu IDE (IntelliJ, Eclipse, VS Code) y navega hasta la carpeta raíz del proyecto, exactamente donde se encuentra el archivo `pom.xml`.

### Paso 2: Ejecutar las pruebas
El proyecto usa Maven para descargar automáticamente las dependencias de Karate e iniciar las pruebas. Puedes elegir cualquiera de las siguientes opciones de ejecución:

**Opción A: Ejecutar todo el suite de pruebas (Recomendado)**
Este comando invoca al Runner principal, asegurándose de ejecutar todo el ciclo del CRUD en orden correcto y validando los contratos.
```bash
mvn clean test -Dtest=petstore.PetStoreTest
```

**Opción B: Ejecutar exclusivamente el runner de usuarios**
Si en el futuro hay más módulos y solo quieres evaluar el módulo `user`.
```bash
mvn clean test -Dtest=petstore.user.UserRunner
```

**Opción C: Ejecutar por etiqueta (Tags)**
Si deseas correr un escenario en específico (ej. crear el usuario o actualizarlo). Reemplaza `@create` por `@update`, `@delete`, o `@get`.
```bash
mvn clean test -Dkarate.options="--tags @create"
```

### Paso 3: Revisar los Resultados (Reporte HTML)
Karate genera automáticamente reportes de ejecución con el detalle de los Request, Response y validaciones fallidas/exitosas.

1. Una vez termine de correr la prueba, ve a tu explorador de archivos.
2. Navega a la ruta: `target/karate-reports/`
3. Abre el archivo **`karate-summary.html`** en cualquier navegador web (Chrome, Firefox, Safari).
4. Da clic en el nombre de la prueba (`user-crud`) para expandir y ver la evidencia completa de cada caso de prueba.

## Autor

Jean Pierre Villacis
