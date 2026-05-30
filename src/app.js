const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./swagger');

const librosRoutes = require('./routes/libros.routes');

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Redoc — documentación alternativa (HTML estático)
app.get('/redoc', (req, res) => {
  res.send(`<!DOCTYPE html>
<html>
  <head>
    <title>API de Libros — Redoc</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,700|Roboto:300,400,700" rel="stylesheet">
    <style>body { margin: 0; padding: 0; }</style>
  </head>
  <body>
    <redoc spec-url='/api-docs/swagger.json'></redoc>
    <script src="https://cdn.redoc.ly/redoc/latest/bundles/redoc.standalone.js"></script>
  </body>
</html>`);
});

// Exponer el JSON de la spec para que Redoc lo consuma
app.get('/api-docs/swagger.json', (req, res) => {
  res.setHeader('Content-Type', 'application/json');
  res.send(swaggerSpec);
});

// Swagger UI
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec, {
  customSiteTitle: 'API de Libros — Swagger',
  swaggerOptions: { persistAuthorization: true },
}));

// Rutas del CRUD
app.use('/api/libros', librosRoutes);

// Ruta raíz informativa
app.get('/', (req, res) => {
  res.json({
    mensaje: 'API de Gestión de Libros v1.0.0',
    endpoints: {
      swagger: '/api-docs',
      redoc: '/redoc',
      libros: '/api/libros',
    },
  });
});

module.exports = app;
