🚀 Proyecto Final de Automatización de APIs - Karate Framework
Este repositorio contiene el Proyecto Final de Automatización para la gestión de productos y autenticación de usuarios. 
Se ha utilizado Karate DSL por su potencia en pruebas BDD y facilidad para manejar peticiones REST.

📋 Características del Proyecto
Pruebas de Autenticación: Registro de nuevos usuarios y obtención de tokens Bearer.

Gestión de Productos: CRUD completo (Crear, Leer, Actualizar y Eliminar).

Validación de Errores: Casos de prueba para capturar excepciones del servidor (Error 500) y mensajes de negocio.

Data-Driven Testing: Uso de archivos CSV para ejecutar múltiples escenarios con diferentes juegos de datos.

Validación de Esquemas: Uso de archivos JSON para asegurar la integridad de la estructura de las respuestas.

🛠️ Tecnologías Utilizadas
Java: Azul Zulu JDK 11

Framework: Karate 1.3.1

Gestor de Dependencias: Maven

IDE: IntelliJ IDEA

⚙️ Configuración y Ejecución
Clonar el repositorio:

Bash
git clone https://github.com/vmaita/proyecto-karate-qa-team-final.git
Ejecutar todas las pruebas con Maven:

Bash
mvn test
Ejecutar por Tags (Ejemplo: Solo Productos):

Bash
mvn test -Dkarate.options="--tags @automation-api"
📊 Reportes de Prueba
Tras la ejecución, Karate genera reportes interactivos en formato HTML. Puedes encontrarlos en:
target/karate-reports/karate-summary.html

🐛 Hallazgos y Bugs Reportados
Durante el desarrollo se identificaron los siguientes puntos de mejora en la API:

Error 500 en Registro: La API devuelve un error interno en lugar de un 422 Unprocessable Entity cuando un correo ya existe.

Excepción de Objeto Nulo: Se capturó el error "Call to a member function update() on null" al intentar actualizar productos inexistentes.

Desarrollado por: Verito Maita 👩‍💻
