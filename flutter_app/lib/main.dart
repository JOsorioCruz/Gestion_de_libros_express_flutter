import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/libros_provider.dart';
import 'screens/lista_libros_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LibrosProvider(),
      child: const LibrosApp(),
    ),
  );
}

class LibrosApp extends StatelessWidget {
  const LibrosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Libros',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
      ),
      home: const ListaLibrosScreen(),
    );
  }
}
