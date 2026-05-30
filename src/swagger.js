const swaggerJsdoc = require('swagger-jsdoc');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'API de Gestión de Libros',
      version: '1.0.0',
      description:
        'API RESTful para gestionar un catálogo de libros. Permite crear, consultar, actualizar y eliminar registros de libros almacenados en memoria.',
      contact: {
        name: 'Jairo Osorio',
        email: 'josorioc@unicartagena.edu.co',
      },
      license: {
        name: 'MIT',
        url: 'https://opensource.org/licenses/MIT',
      },
    },
    servers: [
      {
        url: 'http://localhost:3000',
        description: 'Servidor de desarrollo local',
      },
    ],
    components: {
      schemas: {
        Libro: {
          type: 'object',
          properties: {
            id: {
              type: 'string',
              format: 'uuid',
              example: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
              description: 'Identificador único del libro (UUID v4)',
            },
            titulo: {
              type: 'string',
              example: 'Cien años de soledad',
              description: 'Título del libro',
            },
            autor: {
              type: 'string',
              example: 'Gabriel García Márquez',
              description: 'Nombre completo del autor',
            },
            isbn: {
              type: 'string',
              example: '978-0-06-088328-7',
              description: 'Código ISBN del libro',
            },
            anio: {
              type: 'integer',
              example: 1967,
              description: 'Año de publicación',
            },
            genero: {
              type: 'string',
              example: 'Realismo mágico',
              description: 'Género literario del libro',
            },
            sinopsis: {
              type: 'string',
              example: 'Breve descripción del contenido del libro.',
              description: 'Sinopsis o resumen del libro',
            },
            disponible: {
              type: 'boolean',
              example: true,
              description: 'Indica si el libro está disponible en el catálogo',
            },
          },
          required: ['titulo', 'autor', 'isbn', 'anio', 'genero'],
        },
        LibroInput: {
          type: 'object',
          properties: {
            titulo: {
              type: 'string',
              example: 'El otoño del patriarca',
            },
            autor: {
              type: 'string',
              example: 'Gabriel García Márquez',
            },
            isbn: {
              type: 'string',
              example: '978-0-06-088328-8',
            },
            anio: {
              type: 'integer',
              example: 1975,
            },
            genero: {
              type: 'string',
              example: 'Realismo mágico',
            },
            sinopsis: {
              type: 'string',
              example: 'Retrato de un dictador caribeño en el ocaso de su poder.',
            },
            disponible: {
              type: 'boolean',
              example: true,
            },
          },
          required: ['titulo', 'autor', 'isbn', 'anio', 'genero'],
        },
        Error: {
          type: 'object',
          properties: {
            mensaje: {
              type: 'string',
              example: 'Libro no encontrado',
            },
          },
        },
      },
    },
  },
  apis: ['./src/routes/*.js'],
};

const swaggerSpec = swaggerJsdoc(options);

module.exports = swaggerSpec;
