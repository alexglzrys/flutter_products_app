import 'package:flutter/material.dart';
import 'package:products_flutter_app/ui/input_decorations.dart';
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
                Form(
                    // La validación de los controles de este formulario se harán en tiempo real con base a la interacción del usuario
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        // a comparación del TextField, los TextFormField actuan como un widget avanzado que envuelve un TextField y le proporciona funciones adiconales como la validación. Asi mismo, lo integra facilmente con un formulario para que este se hga cargo de toda la gestión
                        TextFormField(
                          // Evitar el auto-corrector
                          autocorrect: false,
                          // Tipo de teclado al momento de usar la caja de texto
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.deepPurple),

                          // Decoración de la caja de texto (información situada en un método estatico de la clase personalizada InputDecorations)
                          decoration: InputDecorations.authInputDecoration(
                              labelText: 'Correo Electrónico',
                              hintText: 'kakaroto@correo.com',
                              prefixIcon: Icons.alternate_email),
                          // Validación del contenido escrito en esta caja de texto
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'El correo electrónico es requerido';
                            }
                            // Expresión regular para la validación de correo electrónico
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(pattern);
                            if (!regExp.hasMatch(value)) {
                              return 'El valor ingresado no luce como un correo válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          // Evitar el auto-corrector
                          autocorrect: false,
                          // De forma visual, el contenido de este input se mostrará ofuscado (password)
                          obscureText: true,
                          style: const TextStyle(color: Colors.deepPurple),
                          // Decoración de la caja de texto (información situada en un método estatico de la clase personalizada InputDecorations)
                          decoration: InputDecorations.authInputDecoration(
                              labelText: 'Contraseña',
                              hintText: '******',
                              prefixIcon: Icons.lock),
                          // Validación del contenido escrito en esta caja de texto
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'La contraseña es un dato requerido';
                            }
                            if (value.length < 6) {
                              return 'La contraseña debe ser de al menos 6 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        MaterialButton(
                          onPressed: () {
                            // Todo: Login Submit
                          },
                          color: Colors.deepPurple,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          // Agregar un Padding al botón de envio
                          child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                'Ingresar',
                                style: TextStyle(color: Colors.white),
                              )),
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
          ),
          const SizedBox(height: 50)
        ],
      ),
    )));
  }
}
