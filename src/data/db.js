const { randomUUID } = require('crypto');

const libros = [
  {
    id: randomUUID(),
    titulo: 'Cien años de soledad',
    autor: 'Gabriel García Márquez',
    isbn: '978-0-06-088328-7',
    anio: 1967,
    genero: 'Realismo mágico',
    sinopsis: 'La saga de la familia Buendía a lo largo de siete generaciones en el pueblo ficticio de Macondo.',
    disponible: true,
  },
  {
    id: randomUUID(),
    titulo: 'El amor en los tiempos del cólera',
    autor: 'Gabriel García Márquez',
    isbn: '978-0-14-303943-3',
    anio: 1985,
    genero: 'Novela romántica',
    sinopsis: 'Una historia de amor que se desarrolla a lo largo de más de cincuenta años en una ciudad del Caribe.',
    disponible: true,
  },
  {
    id: randomUUID(),
    titulo: 'Don Quijote de la Mancha',
    autor: 'Miguel de Cervantes',
    isbn: '978-84-376-0494-7',
    anio: 1605,
    genero: 'Novela caballeresca',
    sinopsis: 'Las aventuras de Alonso Quijano, un hidalgo que enloquece leyendo libros de caballerías y decide convertirse en caballero andante.',
    disponible: false,
  },
];

module.exports = libros;
