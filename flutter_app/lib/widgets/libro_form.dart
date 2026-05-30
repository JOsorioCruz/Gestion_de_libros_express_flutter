import 'package:flutter/material.dart';
import '../models/libro.dart';

class LibroForm extends StatefulWidget {
  final Libro? libro;
  final Future<bool> Function(Map<String, dynamic>) onGuardar;

  const LibroForm({super.key, this.libro, required this.onGuardar});

  @override
  State<LibroForm> createState() => _LibroFormState();
}

class _LibroFormState extends State<LibroForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tituloCtrl;
  late final TextEditingController _autorCtrl;
  late final TextEditingController _isbnCtrl;
  late final TextEditingController _anioCtrl;
  late final TextEditingController _generoCtrl;
  late final TextEditingController _sinopsisCtrl;
  bool _disponible = true;

  @override
  void initState() {
    super.initState();
    _tituloCtrl = TextEditingController(text: widget.libro?.titulo ?? '');
    _autorCtrl = TextEditingController(text: widget.libro?.autor ?? '');
    _isbnCtrl = TextEditingController(text: widget.libro?.isbn ?? '');
    _anioCtrl = TextEditingController(text: widget.libro?.anio.toString() ?? '');
    _generoCtrl = TextEditingController(text: widget.libro?.genero ?? '');
    _sinopsisCtrl = TextEditingController(text: widget.libro?.sinopsis ?? '');
    _disponible = widget.libro?.disponible ?? true;
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _autorCtrl.dispose();
    _isbnCtrl.dispose();
    _anioCtrl.dispose();
    _generoCtrl.dispose();
    _sinopsisCtrl.dispose();
    super.dispose();
  }

  Future<void> _enviar() async {
    if (!_formKey.currentState!.validate()) return;

    final datos = {
      'titulo': _tituloCtrl.text.trim(),
      'autor': _autorCtrl.text.trim(),
      'isbn': _isbnCtrl.text.trim(),
      'anio': int.parse(_anioCtrl.text.trim()),
      'genero': _generoCtrl.text.trim(),
      'sinopsis': _sinopsisCtrl.text.trim(),
      'disponible': _disponible,
    };

    final exito = await widget.onGuardar(datos);
    if (exito && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _campo(_tituloCtrl, 'Título', obligatorio: true),
            _campo(_autorCtrl, 'Autor', obligatorio: true),
            _campo(_isbnCtrl, 'ISBN', obligatorio: true),
            _campo(_anioCtrl, 'Año', obligatorio: true, esNumero: true),
            _campo(_generoCtrl, 'Género', obligatorio: true),
            _campo(_sinopsisCtrl, 'Sinopsis', lineas: 3),
            SwitchListTile(
              title: const Text('Disponible'),
              value: _disponible,
              onChanged: (v) => setState(() => _disponible = v),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _enviar,
              icon: const Icon(Icons.save),
              label: Text(widget.libro == null ? 'Crear libro' : 'Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campo(
    TextEditingController ctrl,
    String etiqueta, {
    bool obligatorio = false,
    bool esNumero = false,
    int lineas = 1,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: ctrl,
          maxLines: lineas,
          keyboardType: esNumero ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            labelText: etiqueta,
            border: const OutlineInputBorder(),
          ),
          validator: obligatorio
              ? (v) => (v == null || v.trim().isEmpty) ? 'Campo requerido' : null
              : null,
        ),
      );
}
