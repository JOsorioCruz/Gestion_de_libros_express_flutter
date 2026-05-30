# API de Gestión de Libros

**Autor:** Jairo Osorio  
**Correo:** josorioc@unicartagena.edu.co  
**Curso:** Desarrollo de Apps  
**Universidad:** Universidad de Cartagena  
**Año:** 2026

---

## Introducción

Este proyecto implementa un **stack completo y containerizado** para gestionar un catálogo de libros: una API RESTful desarrollada con **Node.js y Express** como backend, y una aplicación **Flutter Web** como frontend, ambas orquestadas con **Docker Compose** en un único comando. La API expone operaciones CRUD completas (Crear, Leer, Actualizar, Eliminar) sobre un recurso `Libro` almacenado en memoria, y el frontend consume esa API desde el navegador.

El problema que resuelve es la necesidad de contar con un sistema funcional, documentado y portable — desde el servidor hasta la interfaz de usuario — que pueda reproducirse en cualquier entorno sin instalar dependencias manualmente. Se eligió este stack por su amplia adopción en la industria, la facilidad de prototipado rápido y la disponibilidad de herramientas maduras de documentación y contenedorización.

---

## Objetivos

### Objetivo general

Construir un stack completo y containerizado — API RESTful en Node.js con Express y frontend Flutter Web servido por nginx — orquestado con Docker Compose, que permita realizar operaciones CRUD sobre un catálogo de libros desde el navegador.

### Objetivos específicos

1. Implementar los cinco endpoints del CRUD (`GET`, `POST`, `PUT`, `DELETE`) siguiendo los principios REST, con validación de entradas y manejo de errores HTTP apropiados.
2. Documentar todos los endpoints mediante Swagger UI (OpenAPI 3.0) y Redoc, generando una especificación interactiva accesible desde el navegador.
3. Dockerizar el stack completo (backend Node.js y frontend Flutter Web) usando builds multi-etapa y orquestar ambos servicios con `docker-compose`, garantizando la reproducibilidad del entorno con un único comando.
4. Consumir la API desde Flutter Web usando el paquete `http` y gestionar el estado de la aplicación con `Provider`, conectando cada operación CRUD a una interfaz de usuario funcional accesible desde el navegador.

---

## Justificación

| Tecnología | Justificación |
|---|---|
| **Node.js + Express** | Ecosistema maduro, rendimiento asíncrono, y velocidad de desarrollo para APIs REST. Express es el framework más extendido en el mercado profesional. |
| **Flutter Web** | El mismo código Dart compila a HTML/JS/CSS y se sirve desde un contenedor nginx, sin necesidad de instalar el SDK de Flutter en el servidor ni en el equipo del usuario final. |
| **Docker + Docker Compose** | Garantiza que tanto la API como el frontend corran de forma idéntica en cualquier entorno. Con un único `docker-compose up` se levanta el stack completo, eliminando los problemas de "funciona en mi máquina". |
| **Swagger / Redoc** | La documentación interactiva es un estándar de facto en APIs profesionales; permite probar los endpoints sin herramientas externas y sirve como contrato entre frontend y backend. |

---

## Pre-requisitos

**Para ejecutar con Docker (recomendado):**
- Docker Desktop 4.x o superior

**Solo para desarrollo local sin Docker:**
- Node.js 18 o superior (el módulo nativo `crypto.randomUUID()` requiere Node.js 15.6+)
- npm 9 o superior
- Flutter SDK 3.x o superior

**Recomendado:**
- Editor de código: VS Code con extensiones Dart, Flutter y Docker

---

## Requisitos del sistema

| Recurso | Mínimo recomendado |
|---|---|
| Sistema operativo | macOS 13+, Windows 10+, Ubuntu 20.04+ |
| RAM | 8 GB (la imagen de Flutter para Docker es ~2 GB) |
| Espacio en disco | 5 GB libres (imágenes Docker incluidas) |
| Puertos disponibles | 3000 (API), 8080 (frontend Flutter web) |

---

## Instrucciones de uso

### 1. Clonar el repositorio

```bash
git clone <url-del-repositorio>
cd actividad_4
```

### 2. Instalar dependencias

```bash
npm install
```

### 3. Ejecutar la API en modo desarrollo (local)

```bash
npm run dev        # con nodemon (recarga automática)
# o
npm start          # sin nodemon
```

La API queda disponible en `http://localhost:3000`.

### 4. Ejecutar todo el stack con Docker (recomendado)

Este comando levanta **ambos servicios** al mismo tiempo: la API en Node.js y el frontend Flutter web servido por nginx.

```bash
# Primera vez o tras cambiar código/dependencias
docker-compose build --no-cache

# Levantar los dos contenedores
docker-compose up

# En segundo plano
docker-compose up -d

# Detener y eliminar contenedores/redes
docker-compose down
```

| Servicio | Contenedor | URL |
|---|---|---|
| API REST | `libros-api` | `http://localhost:3000` |
| Flutter web | `libros-frontend` | `http://localhost:8080` |
| Swagger UI | — | `http://localhost:3000/api-docs` |
| Redoc | — | `http://localhost:3000/redoc` |

> **Nota sobre la primera compilación:** la imagen de Flutter descarga el SDK (~2 GB) la primera vez; las compilaciones posteriores usan el caché de capas y son mucho más rápidas.

> **Nota sobre la URL de la API:** el frontend Flutter web corre en el navegador del usuario, por lo que llama a `http://localhost:3000` directamente (no a través de la red interna de Docker). Esto funciona porque el puerto 3000 del contenedor `api` está mapeado al puerto 3000 del host.

### 5. Ejecutar la API localmente (sin Docker)

```bash
npm run dev    # con nodemon (recarga automática)
# o
npm start      # sin nodemon
```

La API queda disponible en `http://localhost:3000`.

### 6. Ejecutar la app Flutter localmente (sin Docker)

```bash
cd flutter_app
flutter pub get
flutter run -d chrome    # en el navegador
# o
flutter run -d macos     # como app de escritorio
```

Asegúrate de que la API esté corriendo antes de iniciar Flutter.

---

## Endpoints disponibles

| Método | Ruta | Descripción |
|---|---|---|
| GET | `/api/libros` | Listar todos los libros |
| GET | `/api/libros/:id` | Obtener un libro por UUID |
| POST | `/api/libros` | Crear un nuevo libro |
| PUT | `/api/libros/:id` | Actualizar un libro existente |
| DELETE | `/api/libros/:id` | Eliminar un libro |

### Ejemplo de cuerpo (POST / PUT)

```json
{
  "titulo": "El otoño del patriarca",
  "autor": "Gabriel García Márquez",
  "isbn": "978-0-06-088328-8",
  "anio": 1975,
  "genero": "Realismo mágico",
  "sinopsis": "Retrato de un dictador caribeño en el ocaso de su poder.",
  "disponible": true
}
```

### Campos obligatorios

`titulo`, `autor`, `isbn`, `anio`, `genero`

---

## Documentación interactiva

| Interfaz | URL |
|---|---|
| Swagger UI | `http://localhost:3000/api-docs` |
| Redoc | `http://localhost:3000/redoc` |

---

## Estructura del proyecto

```
actividad_4/
├── src/
│   ├── routes/
│   │   └── libros.routes.js       # Rutas con comentarios JSDoc/Swagger
│   ├── controllers/
│   │   └── libros.controller.js   # Lógica CRUD de cada endpoint
│   ├── data/
│   │   └── db.js                  # Arreglo en memoria con datos semilla
│   ├── swagger.js                 # Configuración OpenAPI 3.0
│   └── app.js                     # Express + middlewares
├── flutter_app/
│   ├── lib/
│   │   ├── models/libro.dart           # Modelo de datos
│   │   ├── services/
│   │   │   ├── libro_service.dart      # Llamadas HTTP a la API
│   │   │   └── libros_provider.dart    # Estado global con Provider
│   │   ├── screens/
│   │   │   └── lista_libros_screen.dart
│   │   ├── widgets/
│   │   │   └── libro_form.dart
│   │   └── main.dart
│   ├── Dockerfile          # Build Flutter web → nginx
│   ├── nginx.conf          # Configuración del servidor web
│   ├── .dockerignore
│   └── pubspec.yaml
├── index.js                # Punto de entrada del servidor Node.js
├── .env                    # Variables de entorno
├── Dockerfile              # Imagen Docker del backend
├── .dockerignore
├── docker-compose.yml      # Orquesta api + frontend
└── package.json
```

---

## Desarrollo de la actividad

### Diseño del recurso

El recurso elegido fue **Libro**, con los siguientes campos:

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | UUID v4 | Identificador único generado automáticamente |
| `titulo` | string | Título del libro (requerido) |
| `autor` | string | Nombre del autor (requerido) |
| `isbn` | string | Código ISBN único (requerido) |
| `anio` | number | Año de publicación (requerido) |
| `genero` | string | Género literario (requerido) |
| `sinopsis` | string | Descripción opcional del contenido |
| `disponible` | boolean | Indica si está disponible, por defecto `true` |

### Decisiones técnicas del CRUD

- **`crypto.randomUUID()`** para generar los IDs en lugar de autoincrement. Se usa el módulo nativo de Node.js `crypto` (disponible desde Node.js 15.6) en vez del paquete externo `uuid`, ya que `uuid` v14 es un módulo ESM puro incompatible con `require()` de CommonJS en Node.js 18 dentro de Docker (lanza `ERR_REQUIRE_ESM`). Eliminar la dependencia también reduce el tamaño de la imagen.
- **Validación de ISBN único** en creación y actualización para garantizar integridad de datos.
- **Actualizaciones parciales**: el `PUT` aplica únicamente los campos enviados en el body, preservando el resto.
- Los **códigos HTTP** siguen el estándar: 200 OK, 201 Created, 400 Bad Request, 404 Not Found, 409 Conflict.

### Configuración de Swagger y Redoc

Se usó `swagger-jsdoc` para generar la especificación OpenAPI 3.0 a partir de comentarios JSDoc en las rutas. La spec se expone en `/api-docs/swagger.json`, lo que permite que tanto Swagger UI (montado con `swagger-ui-express`) como Redoc (HTML inline con CDN) la consuman desde el mismo servidor.

### Dockerización

El proyecto usa un stack de **dos contenedores** orquestados con Docker Compose:

| Contenedor | Imagen base | Rol |
|---|---|---|
| `libros-api` | `node:18-alpine` | Sirve la API REST en el puerto 3000 |
| `libros-frontend` | build multi-etapa: `flutter:stable` → `nginx:alpine` | Compila la app Flutter para web y la sirve en el puerto 8080 |

**Backend (`Dockerfile` raíz):** usa `node:18-alpine` para minimizar el tamaño (≈ 60 MB). El flag `--omit=dev` excluye las devDependencies (nodemon) de la imagen final.

**Frontend (`flutter_app/Dockerfile`):** usa un build multi-etapa. La primera etapa descarga el SDK de Flutter, instala dependencias con `flutter pub get` y compila la aplicación con `flutter build web --release`, generando archivos HTML/JS/CSS estáticos. La segunda etapa copia esos archivos a una imagen `nginx:alpine` (≈ 25 MB) que los sirve. Esta separación garantiza que la imagen final no incluya el SDK de Flutter ni las herramientas de compilación.

El `docker-compose.yml` define la dependencia `depends_on: api` para que el frontend arranque después del backend, y elimina el atributo `version:` (obsoleto en Docker Compose v2).

**Incompatibilidad ESM en Node.js 18:** durante las pruebas se detectó que el paquete `uuid` v14 es un módulo ESM puro y lanza `ERR_REQUIRE_ESM` con `require()` en Node.js 18. La solución fue reemplazarlo con `crypto.randomUUID()`, nativo de Node.js, sin dependencias externas. Después de cualquier cambio de dependencias o código fuente, es obligatorio reconstruir con `docker-compose build --no-cache`.

### Consumo desde Flutter Web

La app Flutter se compila como **aplicación web** (`flutter build web --release`) y se sirve como archivos HTML/JS/CSS estáticos a través de nginx. Esto significa que el código Dart se transpila a JavaScript y corre directamente en el navegador del usuario, sin necesidad de un runtime de Dart en el servidor.

La capa de servicio (`LibroService`) encapsula todas las llamadas HTTP con el paquete `http`. Como el frontend corre en el navegador (no en el contenedor), las peticiones se dirigen a `http://localhost:3000`, que apunta al puerto expuesto del contenedor `libros-api` en el host.

El estado global se gestiona con `Provider` (`LibrosProvider`), que expone los libros como lista inmutable y notifica a los widgets ante cualquier cambio. Los formularios usan `TextEditingController` y validación nativa de Flutter.

**Proceso de containerización del frontend:**

1. **Etapa de build** (`ghcr.io/cirruslabs/flutter:stable`): instala dependencias con `flutter pub get` y compila con `flutter build web --release`, produciendo artefactos estáticos en `build/web/`.
2. **Etapa de producción** (`nginx:alpine`): copia únicamente la carpeta `build/web/` a `/usr/share/nginx/html`. La imagen final pesa ~25 MB en lugar de los ~2 GB del SDK de Flutter.
3. **`nginx.conf`**: usa `try_files $uri $uri/ /index.html` para que Flutter maneje el enrutamiento del lado del cliente.
4. **`.dockerignore`**: excluye `build/`, `android/`, `ios/`, `macos/`, `windows/` y `linux/`, reduciendo el contexto enviado al daemon de Docker.

---

## Conclusiones

- La combinación Node.js + Express permite construir APIs REST de forma rápida y limpia, con una separación de responsabilidades clara entre rutas y controladores.
- La documentación con Swagger/Redoc es invaluable durante el desarrollo: actúa como contrato vivo entre el backend y los consumidores, reduciendo errores de integración.
- Docker garantiza la reproducibilidad del entorno y simplifica el despliegue en cualquier máquina, independientemente del sistema operativo.
- Flutter + Provider ofrece una experiencia de desarrollo fluida para aplicaciones reactivas, donde la UI se actualiza automáticamente ante cambios de estado.
- Una dificultad encontrada fue la incompatibilidad entre módulos ESM y CommonJS en Node.js: el paquete `uuid` v14 (ESM puro) fallaba con `ERR_REQUIRE_ESM` dentro del contenedor Docker (Node.js 18). La solución fue sustituirlo por `crypto.randomUUID()`, nativo de Node.js, sin dependencias externas. Este problema evidencia la importancia de probar siempre en el entorno de contenedor y no solo en el host local.
- La gestión de CORS al conectar Flutter (especialmente en Android) con la API local se resolvió con el paquete `cors` en Express y ajustando la URL base (`10.0.2.2` en lugar de `localhost`) en el emulador.
- El caché de imágenes de Docker Compose es independiente del de `docker build`: al cambiar código o dependencias se debe ejecutar `docker-compose build --no-cache` para garantizar que la imagen refleje los cambios más recientes.
- El frontend Flutter se containerizó como una aplicación **web** usando un build multi-etapa: la imagen de Flutter compila los artefactos estáticos y nginx los sirve, resultando en una imagen final de solo ~25 MB en lugar de los ~2 GB del SDK completo.

---

## Bibliografía

- OpenJS Foundation. (2024). *Node.js Documentation — Crypto: randomUUID()*. Recuperado de https://nodejs.org/api/crypto.html#cryptorandomuuidoptions
- OpenJS Foundation. (2024). *Node.js Documentation*. Recuperado de https://nodejs.org/en/docs
- Express.js Team. (2024). *Express — Fast, unopinionated, minimalist web framework for Node.js*. Recuperado de https://expressjs.com
- Swagger.io. (2024). *OpenAPI Specification 3.0*. Recuperado de https://swagger.io/specification
- Redocly. (2024). *Redoc — OpenAPI/Swagger-generated API Reference Documentation*. Recuperado de https://redocly.com/redoc
- Google LLC. (2024). *Flutter documentation*. Recuperado de https://docs.flutter.dev
- Docker Inc. (2024). *Docker documentation*. Recuperado de https://docs.docker.com
- Docker Inc. (2024). *Compose file reference — version (obsolete)*. Recuperado de https://docs.docker.com/compose/compose-file
- npm, Inc. (2024). *swagger-jsdoc*. Recuperado de https://www.npmjs.com/package/swagger-jsdoc
- npm, Inc. (2024). *swagger-ui-express*. Recuperado de https://www.npmjs.com/package/swagger-ui-express
- Flutter Community. (2024). *provider package*. Recuperado de https://pub.dev/packages/provider
- Flutter Community. (2024). *http package*. Recuperado de https://pub.dev/packages/http
- Google LLC. (2024). *Flutter Web — Building a web application with Flutter*. Recuperado de https://docs.flutter.dev/platform-integration/web
- Cirrus Labs. (2024). *Flutter Docker image (ghcr.io/cirruslabs/flutter)*. Recuperado de https://github.com/cirruslabs/docker-images-flutter
- nginx. (2024). *nginx documentation — Serving static content*. Recuperado de https://nginx.org/en/docs/beginners_guide.html
