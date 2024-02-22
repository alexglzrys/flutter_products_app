import 'package:flutter/material.dart';

// Widget encargado de mostrar la vistra previa de un producto a registrar
class ProductImage extends StatelessWidget {
  const ProductImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      width: double.infinity,
      height: 300,
      decoration: _decorationProductScreen(),
      child: const ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage('https://placehold.jp/9022c3/ffffff/400x300.png'),
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
