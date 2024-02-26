import 'package:flutter/material.dart';
import 'package:products_flutter_app/screens/screens.dart';
import 'package:products_flutter_app/services/services.dart';
import 'package:provider/provider.dart';

// Primero se crea el estado global de la aplciación, y luego se carga la aplicación principal
void main() => runApp(const AppState());

// La instancia de ProductService debe existir en todo momento en mi aplciación, o por lo menos cuando se accede a la pantalla de productos
// ? El Provider nos ofrece su mecanismo de crear las instancias que extienden de ChangeNotifier de forma peresoza cuando algún widget descendiente lo neesita por primera vez, o de forma inmediata.
// por tanto si necesitamos que el servicio este disponible de forma global en la aplicación, lo invocamos desde el estado global de la aplicación, además la instancia debe ser lazy, ya que los productos se deberían cargar siempre y cuando el user este logeado (esto mejora el rendimiento de la app).
class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsService(),
          lazy: true,
        )
      ],
      // Los providers declarados en el listado estárán disponibles en toda la aplicación
      child: const ProductsApp(),
    );
  }
}

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
