import 'package:flutter/material.dart';
import 'package:products_flutter_app/screens/screens.dart';

void main() => runApp(const ProductsApp());

class ProductsApp extends StatelessWidget {
  const ProductsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos App',
      initialRoute: LoginScreen.screenName,
      routes: {
        HomeScreen.screenName: (context) => const HomeScreen(),
        LoginScreen.screenName: (context) => const LoginScreen(),
      },
      // Configuración del tema principal de la aplicación
      // Se toma una copia completa del tema light, y se sobreescribe el color de fondo de todos los widgets Scaffold
      theme:
          ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey[300]),
    );
  }
}
