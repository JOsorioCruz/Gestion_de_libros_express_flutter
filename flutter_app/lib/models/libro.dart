class Libro {
  final String id;
  final String titulo;
  final String autor;
  final String isbn;
  final int anio;
  final String genero;
  final String sinopsis;
  final bool disponible;

  Libro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.isbn,
    required this.anio,
    required this.genero,
    required this.sinopsis,
    required this.disponible,
  });

  factory Libro.fromJson(Map<String, dynamic> json) => Libro(
        id: json['id'] as String,
        titulo: json['titulo'] as String,
        autor: json['autor'] as String,
        isbn: json['isbn'] as String,
        anio: (json['anio'] as num).toInt(),
        genero: json['genero'] as String,
        sinopsis: json['sinopsis'] as String? ?? '',
        disponible: json['disponible'] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'autor': autor,
        'isbn': isbn,
        'anio': anio,
        'genero': genero,
        'sinopsis': sinopsis,
        'disponible': disponible,
      };

  Libro copyWith({
    String? id,
    String? titulo,
    String? autor,
    String? isbn,
    int? anio,
    String? genero,
    String? sinopsis,
    bool? disponible,
  }) =>
      Libro(
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
        autor: autor ?? this.autor,
        isbn: isbn ?? this.isbn,
        anio: anio ?? this.anio,
        genero: genero ?? this.genero,
        sinopsis: sinopsis ?? this.sinopsis,
        disponible: disponible ?? this.disponible,
      );
}
