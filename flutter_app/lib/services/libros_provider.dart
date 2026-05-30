import 'package:flutter/material.dart';
import '../models/libro.dart';
import 'libro_service.dart';

class LibrosProvider extends ChangeNotifier {
  final LibroService _service = LibroService();

  List<Libro> _libros = [];
  bool _cargando = false;
  String? _error;

  List<Libro> get libros => List.unmodifiable(_libros);
  bool get cargando => _cargando;
  String? get error => _error;

  Future<void> cargarTodos() async {
    _setEstado(cargando: true, error: null);
    try {
      _libros = await _service.getAll();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setEstado(cargando: false);
    }
  }

  Future<bool> crear(Map<String, dynamic> datos) async {
    _setEstado(cargando: true, error: null);
    try {
      final nuevo = await _service.create(datos);
      _libros.add(nuevo);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setEstado(cargando: false);
    }
  }

  Future<bool> actualizar(String id, Map<String, dynamic> datos) async {
    _setEstado(cargando: true, error: null);
    try {
      final actualizado = await _service.update(id, datos);
      final index = _libros.indexWhere((l) => l.id == id);
      if (index != -1) _libros[index] = actualizado;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setEstado(cargando: false);
    }
  }

  Future<bool> eliminar(String id) async {
    _setEstado(cargando: true, error: null);
    try {
      await _service.delete(id);
      _libros.removeWhere((l) => l.id == id);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setEstado(cargando: false);
    }
  }

  void _setEstado({required bool cargando, String? error}) {
    _cargando = cargando;
    if (error != null) _error = error;
    notifyListeners();
  }
}
