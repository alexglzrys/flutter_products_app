import 'package:flutter/material.dart';
import 'package:products_flutter_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  static String screenName = 'product';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // Para asegurar el buen funcionamiento de nuestra App en diferentes dispositivos con altura pequeña, pero sobre todo si estamos concientes que puede aparecer el teclado para ingresar algún tipo de información
        // Es importante agrupar el contenido principal en widgets que ofrescan scroll (ListView, o SingleChildScrollView)
        body: SingleChildScrollView(
      child: Column(
        children: [ProductImage()],
      ),
    ));
  }
}
