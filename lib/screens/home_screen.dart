import 'package:flutter/material.dart';
import 'package:products_flutter_app/screens/screens.dart';
import 'package:products_flutter_app/services/products_service.dart';
import 'package:products_flutter_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String screenName = 'home';

  @override
  Widget build(BuildContext context) {
    // Obtener la instancia del provider ProductService
    final productService = Provider.of<ProductsService>(context);

    // Mostrar pantalla de loading si los productos aun estan siendo consultados desde Firebase
    // La propiedad isLoading permite que el consumo del servicio se encuentre desacoplado, a fin de que sea opcional usar un FutureBuilder
    if (productService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      // Se recomienda usar ListView.builder cuando la cantidad de elementos a mostrar en la lista es dinámica o desconocida
      // Además, va cargando cada elemento de forma perezosa cuando este le toca entrar en escena (área visible). Esto hace que nuestra app cargue más rápido y solo se vayan creando los elementos cuando se les va neesitando
      body: ListView.builder(
        // Comprobar cuantos productos hay en el listado
        itemCount: productService.products.length,
        // GestureDetector se utiliza para detectar gestos realizados por el usuario sobre ciertos elementos (envueltos por este widget) dentro de una aplicaciòn movil
        // Algunos Widgets como Container o Card no tienen capacidad de detecciòn de gestos incorporados (onTap). Al envolverslos dentro de un GestureDetector habilita esta capacidad para detectar y responder a varios tipos de gestos como: tocar, tocar dos veces, arrastrar, soltar, pellizcar, hacer zoom, deslizar, etc.
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              // Navegar a la pantalla de producto
              Navigator.pushNamed(context, ProductScreen.screenName);
            },
            // Recuperar el producto actual y pasarlo como parámetro al widget de ProductCard
            child: ProductCard(
              product: productService.products[index],
            )),
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
