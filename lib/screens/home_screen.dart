import 'package:flutter/material.dart';
import 'package:products_flutter_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String screenName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      // Se recomienda usar ListView.builder cuando la cantidad de elementos a mostrar en la lista es dinámica o desconocida
      // Además, va cargando cada elemento de forma perezosa cuando este le toca entrar en escena (área visible). Esto hace que nuestra app cargue más rápido y solo se vayan creando los elementos cuando se les va neesitando
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => const ProductCard(),
      ),
      // Botón flotante situado (por defecto) en la parte inferior derecha
      // Puede contener cualquier widget, pero generalmente se hace uso de botones de acción
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
