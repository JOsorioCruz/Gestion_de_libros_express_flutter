import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/libro.dart';
import '../services/libros_provider.dart';
import '../widgets/libro_form.dart';

class ListaLibrosScreen extends StatefulWidget {
  const ListaLibrosScreen({super.key});

  @override
  State<ListaLibrosScreen> createState() => _ListaLibrosScreenState();
}

class _ListaLibrosScreenState extends State<ListaLibrosScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LibrosProvider>().cargarTodos();
    });
  }

  void _abrirFormulario({Libro? libro}) {
    final provider = context.read<LibrosProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (_, ctrl) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                libro == null ? 'Agregar libro' : 'Editar libro',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: LibroForm(
                libro: libro,
                onGuardar: (datos) => libro == null
                    ? provider.crear(datos)
                    : provider.actualizar(libro.id, datos),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmarEliminar(BuildContext ctx, Libro libro) async {
    final confirmar = await showDialog<bool>(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar libro'),
        content: Text('¿Eliminar "${libro.titulo}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Eliminar')),
        ],
      ),
    );
    if (confirmar == true && ctx.mounted) {
      await ctx.read<LibrosProvider>().eliminar(libro.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Libros'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<LibrosProvider>().cargarTodos(),
          ),
        ],
      ),
      body: Consumer<LibrosProvider>(
        builder: (ctx, provider, _) {
          if (provider.cargando) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 8),
                  Text(provider.error!, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: provider.cargarTodos,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (provider.libros.isEmpty) {
            return const Center(child: Text('No hay libros registrados.'));
          }

          return ListView.separated(
            itemCount: provider.libros.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (ctx, i) {
              final libro = provider.libros[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: libro.disponible ? Colors.green[100] : Colors.grey[200],
                  child: Icon(
                    Icons.menu_book,
                    color: libro.disponible ? Colors.green[700] : Colors.grey,
                  ),
                ),
                title: Text(libro.titulo, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('${libro.autor} · ${libro.anio} · ${libro.genero}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => _abrirFormulario(libro: libro),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _confirmarEliminar(ctx, libro),
                    ),
                  ],
                ),
                onTap: () => _abrirFormulario(libro: libro),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirFormulario,
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
      ),
    );
  }
}
