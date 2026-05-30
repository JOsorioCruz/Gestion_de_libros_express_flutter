const { randomUUID } = require('crypto');
const libros = require('../data/db');

const CAMPOS_REQUERIDOS = ['titulo', 'autor', 'isbn', 'anio', 'genero'];

const obtenerTodos = (req, res) => {
  res.status(200).json(libros);
};

const obtenerPorId = (req, res) => {
  const libro = libros.find((l) => l.id === req.params.id);
  if (!libro) {
    return res.status(404).json({ mensaje: 'Libro no encontrado' });
  }
  res.status(200).json(libro);
};

const crear = (req, res) => {
  const { titulo, autor, isbn, anio, genero, sinopsis, disponible } = req.body;

  const faltantes = CAMPOS_REQUERIDOS.filter((campo) => !req.body[campo]);
  if (faltantes.length > 0) {
    return res.status(400).json({
      mensaje: `Faltan campos obligatorios: ${faltantes.join(', ')}`,
    });
  }

  const duplicadoIsbn = libros.find((l) => l.isbn === isbn);
  if (duplicadoIsbn) {
    return res.status(409).json({ mensaje: 'Ya existe un libro con ese ISBN' });
  }

  const nuevoLibro = {
    id: randomUUID(),
    titulo,
    autor,
    isbn,
    anio: Number(anio),
    genero,
    sinopsis: sinopsis || '',
    disponible: disponible !== undefined ? Boolean(disponible) : true,
  };

  libros.push(nuevoLibro);
  res.status(201).json(nuevoLibro);
};

const actualizar = (req, res) => {
  const index = libros.findIndex((l) => l.id === req.params.id);
  if (index === -1) {
    return res.status(404).json({ mensaje: 'Libro no encontrado' });
  }

  const { titulo, autor, isbn, anio, genero, sinopsis, disponible } = req.body;

  if (isbn && isbn !== libros[index].isbn) {
    const duplicadoIsbn = libros.find((l) => l.isbn === isbn);
    if (duplicadoIsbn) {
      return res.status(409).json({ mensaje: 'Ya existe un libro con ese ISBN' });
    }
  }

  libros[index] = {
    ...libros[index],
    titulo: titulo !== undefined ? titulo : libros[index].titulo,
    autor: autor !== undefined ? autor : libros[index].autor,
    isbn: isbn !== undefined ? isbn : libros[index].isbn,
    anio: anio !== undefined ? Number(anio) : libros[index].anio,
    genero: genero !== undefined ? genero : libros[index].genero,
    sinopsis: sinopsis !== undefined ? sinopsis : libros[index].sinopsis,
    disponible: disponible !== undefined ? Boolean(disponible) : libros[index].disponible,
  };

  res.status(200).json(libros[index]);
};

const eliminar = (req, res) => {
  const index = libros.findIndex((l) => l.id === req.params.id);
  if (index === -1) {
    return res.status(404).json({ mensaje: 'Libro no encontrado' });
  }

  const [eliminado] = libros.splice(index, 1);
  res.status(200).json({ mensaje: 'Libro eliminado correctamente', libro: eliminado });
};

module.exports = { obtenerTodos, obtenerPorId, crear, actualizar, eliminar };
