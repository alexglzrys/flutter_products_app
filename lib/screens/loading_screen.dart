import 'package:flutter/material.dart';

// Pantalla que se mostrará cuando la consulta para recuperar el listado de productos se encuentre en progreso
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
