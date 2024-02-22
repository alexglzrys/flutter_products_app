import 'package:flutter/material.dart';
import 'package:products_flutter_app/ui/input_decorations.dart';
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
          // La pantalla estará formada por una imagen previa del producto, botones de acción personalizados para ir a la pantalla anterior y activar la camara, así como una sección de formulario

          // Imagen previa del producto y botones de acción
          Stack(children: [
            const ProductImage(),
            Positioned(
              top: 20,
              left: 20,
              child: _BackButtonProductScreen(),
            ),
            Positioned(top: 20, right: 20, child: _CameraButtonProductScreen())
          ]),
          // Formulario
          _ProductForm(),
          const SizedBox(height: 90)
        ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Todo: Guardar información del producto
        },
        child: const Icon(Icons.save_outlined),
      ),
    );
  }
}

// Widget encargado de mostrar el formulario de registro o edición de producto
class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: _decorationProductForm(),
      child: Form(
          child: Column(children: [
        TextFormField(
          autocorrect: true,
          decoration: InputDecorations.authInputDecoration(
              labelText: 'Nombre del producto:', hintText: 'Teclado iMac'),
        ),
        const SizedBox(height: 15),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecorations.authInputDecoration(
              labelText: 'Precio de venta:', hintText: '\$ 1500.00'),
        ),
        const SizedBox(height: 15),
        // El constructor adaptative de un SwitchListTile, le indica a Flutter que use un control de Switch con la apariecnia nativa de la plataforma o SO
        SwitchListTile.adaptive(
          value: true,
          onChanged: (value) {},
          activeColor: Colors.deepPurple,
          // Retirar padding aplicado por defecto en este tipo de control
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'Disponible',
            style: TextStyle(color: Colors.deepPurple),
          ),
          subtitle: const Text(
            'Especificar si hay unidades',
            style: TextStyle(color: Colors.grey),
          ),
        )
      ])),
    );
  }

  // Método privado para decorar la sección de formulario
  BoxDecoration _decorationProductForm() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 3))
          ]);
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
