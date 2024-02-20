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
      },
    );
  }
}
