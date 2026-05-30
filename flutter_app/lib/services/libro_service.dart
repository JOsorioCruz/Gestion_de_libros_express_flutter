import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/libro.dart';

class LibroService {
  // Cambiar la IP si la API corre en un contenedor Docker o en otra máquina
  static const String _baseUrl = 'http://localhost:3000/api/libros';

  Future<List<Libro>> getAll() async {
    final response = await http.get(Uri.parse(_baseUrl));
    _verificarRespuesta(response);
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Libro.fromJson(json)).toList();
  }

  Future<Libro> getById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    _verificarRespuesta(response);
    return Libro.fromJson(jsonDecode(response.body));
  }

  Future<Libro> create(Map<String, dynamic> datos) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(datos),
    );
    _verificarRespuesta(response);
    return Libro.fromJson(jsonDecode(response.body));
  }

  Future<Libro> update(String id, Map<String, dynamic> datos) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(datos),
    );
    _verificarRespuesta(response);
    return Libro.fromJson(jsonDecode(response.body));
  }

  Future<void> delete(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    _verificarRespuesta(response);
  }

  void _verificarRespuesta(http.Response response) {
    if (response.statusCode >= 400) {
      final body = jsonDecode(response.body);
      throw Exception(body['mensaje'] ?? 'Error en la API: ${response.statusCode}');
    }
  }
}
