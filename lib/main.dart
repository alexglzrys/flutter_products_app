import 'package:flutter/material.dart';
import 'package:products_flutter_app/screens/screens.dart';

void main() => runApp(const ProductsApp());

class ProductsApp extends StatelessWidget {
  const ProductsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos App',
      initialRoute: HomeScreen.screenName,
      routes: {
        HomeScreen.screenName: (context) => const HomeScreen(),
        LoginScreen.screenName: (context) => const LoginScreen(),
        ProductScreen.screenName: (context) => const ProductScreen()
      },
      // Configuración del tema principal de la aplicación
      // Se toma una copia completa del tema light, y se sobreescribe el color de fondo de todos los widgets Scaffold
      theme: ThemeData.light().copyWith(
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.grey[300],
          textTheme: const TextTheme(
              headlineMedium: TextStyle(
                  fontSize: 24,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500)),
          // Estilos globales para los appBar
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.deepPurple,
              elevation: 0,
              centerTitle: true),
          // Estilos globales para el FloatingActionButton
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepPurple, elevation: 0)),
    );
  }
}
