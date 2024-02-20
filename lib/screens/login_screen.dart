import 'package:flutter/material.dart';
import 'package:products_flutter_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String screenName = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            // El contenido principal situado encima del fondo multicolor, crecerá a tal grado que se necesitará hacer scroll para ver el resto de sus elementos
            // SingleChildScrollView nos permite hacer scroll.
            child: SingleChildScrollView(
      child: Column(
        children: [
          // Se deja una separación de 200 unidades en la parte superior, para dejar ver el icono de cabecera
          // Se pueden centrar los elementos en la vertical, pero el diseño que se usa como prototipo indica que deben dejarse 200px
          const SizedBox(height: 200),
          // Widget encargado de mostrar el formulario de login con una decoración de tarjeta con sombra
          CardContainer(
            child: Column(
              children: [
                Text(
                  'Ingreso',
                  // Se hereda el estilo declarado en el tema principal para titulos medios
                  style: Theme.of(context).textTheme.headlineMedium,
                )
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
