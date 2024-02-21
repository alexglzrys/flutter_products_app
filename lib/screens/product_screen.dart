import 'package:flutter/material.dart';
import 'package:products_flutter_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  static String screenName = 'product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Colocar el contenido principa en un área segura, esta pantalla no tendrá AppBar
        body: SafeArea(
      // Para asegurar el buen funcionamiento de nuestra App en diferentes dispositivos con altura pequeña, pero sobre todo si estamos concientes que puede aparecer el teclado para ingresar algún tipo de información
      // Es importante agrupar el contenido principal en widgets que ofrescan scroll (ListView, o SingleChildScrollView)
      child: SingleChildScrollView(
          child: Column(children: [
        Stack(children: [
          const ProductImage(),
          Positioned(
            top: 20,
            left: 20,
            child: _BackButtonProductScreen(),
          ),
          Positioned(top: 20, right: 20, child: _CameraButtonProductScreen())
        ]),
      ])),
    ));
  }
}

// Widget encargado de mostrar el botón de ir atrás
class _CameraButtonProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          // Todo: Activar camara o galería
        },
        icon: const Icon(
          Icons.camera_alt_outlined,
          size: 28,
          color: Colors.white,
        ));
  }
}

// Widget encargado de mostrar el botón para activar la cámara o galería
class _BackButtonProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 28,
        ));
  }
}
