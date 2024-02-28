import 'dart:io';
import 'package:flutter/material.dart';

// Widget encargado de mostrar la vistra previa de un producto a registrar
class ProductImage extends StatelessWidget {
  // Este widget puede mostrar una imagen dinàmica si esta es pasada como paràmetro
  final String? picture;
  const ProductImage({super.key, this.picture});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      width: double.infinity,
      height: 300,
      decoration: _decorationProductScreen(),
      // El widget Opacity, aplica una determinada opacidad a sus elementos hijos
      child: Opacity(
        opacity: 0.85,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          // El siguiente método, verificar si existe una imagen para el producto seleccionado
          child: getImage(picture),
        ),
      ),
    );
  }

  // Método privado encargado de dar decoración al contenedor de la imagen
  BoxDecoration _decorationProductScreen() => BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 0))
          ]);

  Widget getImage(String? picture) {
    // Si no hay imagen, se muestra una por defecto
    if (picture == null) {
      return const Image(
          image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);
    }

    // Si la imagen proviene de un recurso de red http o https, mostrar la imagen con el Widget correspondiente
    if (picture.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(picture),
        fit: BoxFit.cover,
      );
    }

    // Si la imagen existe pero proviene de un directorio temporal en el dispositivo, mostrar la imagen desde archivo
    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
