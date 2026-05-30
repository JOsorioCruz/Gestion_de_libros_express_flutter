const express = require('express');
const router = express.Router();
const ctrl = require('../controllers/libros.controller');

/**
 * @swagger
 * tags:
 *   name: Libros
 *   description: Operaciones CRUD sobre el catálogo de libros
 */

/**
 * @swagger
 * /api/libros:
 *   get:
 *     summary: Obtener todos los libros
 *     tags: [Libros]
 *     responses:
 *       200:
 *         description: Lista completa de libros
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Libro'
 */
router.get('/', ctrl.obtenerTodos);

/**
 * @swagger
 * /api/libros/{id}:
 *   get:
 *     summary: Obtener un libro por ID
 *     tags: [Libros]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *         description: UUID del libro
 *     responses:
 *       200:
 *         description: Libro encontrado
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Libro'
 *       404:
 *         description: Libro no encontrado
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.get('/:id', ctrl.obtenerPorId);

/**
 * @swagger
 * /api/libros:
 *   post:
 *     summary: Crear un nuevo libro
 *     tags: [Libros]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/LibroInput'
 *     responses:
 *       201:
 *         description: Libro creado exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Libro'
 *       400:
 *         description: Faltan campos obligatorios
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       409:
 *         description: ISBN duplicado
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.post('/', ctrl.crear);

/**
 * @swagger
 * /api/libros/{id}:
 *   put:
 *     summary: Actualizar un libro por ID
 *     tags: [Libros]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *         description: UUID del libro a actualizar
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/LibroInput'
 *     responses:
 *       200:
 *         description: Libro actualizado exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Libro'
 *       404:
 *         description: Libro no encontrado
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       409:
 *         description: ISBN ya en uso por otro libro
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.put('/:id', ctrl.actualizar);

/**
 * @swagger
 * /api/libros/{id}:
 *   delete:
 *     summary: Eliminar un libro por ID
 *     tags: [Libros]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *         description: UUID del libro a eliminar
 *     responses:
 *       200:
 *         description: Libro eliminado correctamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 mensaje:
 *                   type: string
 *                   example: Libro eliminado correctamente
 *                 libro:
 *                   $ref: '#/components/schemas/Libro'
 *       404:
 *         description: Libro no encontrado
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.delete('/:id', ctrl.eliminar);

module.exports = router;
