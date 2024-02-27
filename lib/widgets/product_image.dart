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
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        // Verificar si existe una imagen para el producto seleccionado
        child: picture == null
            ? const Image(
                image: AssetImage('assets/no-image.png'), fit: BoxFit.cover)
            : FadeInImage(
                placeholder: const AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(picture!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  // Método privado encargado de dar decoración al contenedor de la imagen
  BoxDecoration _decorationProductScreen() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 8,
                offset: const Offset(0, 0))
          ]);
}
