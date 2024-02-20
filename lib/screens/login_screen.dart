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
                // Titulo de la tarjeta
                Text(
                  'Ingreso',
                  // Se hereda el estilo declarado en el tema principal para titulos medios
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                // Contenido principal - Formulario
                const Form(
                    child: Column(
                  children: [
                    TextField(
                      // Evitar el auto-corrector
                      autocorrect: false,
                      // Tipo de teclado al momento de usar la caja de texto
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.deepPurple),
                      // Decoración de la caja de texto
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple, width: 2)),
                          labelText: 'Correo Electrónico',
                          hintText: 'goku@correo.com',
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.alternate_email,
                              color: Colors.deepPurple)),
                    )
                  ],
                ))
              ],
            ),
          ),
          // Separación de 50 unidades en la vertical para colocar un texto adicional por debajo de la tarjeta
          const SizedBox(height: 50),
          const Text(
            'Crear una cuenta nueva',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          )
        ],
      ),
    )));
  }
}
