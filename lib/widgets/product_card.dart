import 'package:flutter/material.dart';

// Widget encargado de mostrar la tarjeta para representar un producto particular
class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20, bottom: 10),
        height: 300,
        // ! la propiedad color y decoration, no pueden convivir en un mismo Container
        // Si se requiere agregar más estilos, el color debe ser declarado como una propiedad de decoration
        decoration: _decorationProductCard(),
        // Esta tarjeta mostrará contenido situado en distintas direcciones
        child: Stack(
          children: [
            _BackgroundProductCard(),
            Positioned(top: 0, right: 0, child: _PriceTagProductCard())
          ],
        ),
      ),
    );
  }

  // Método privado refernete a la decoración y estilo de la tarjeta de productos
  BoxDecoration _decorationProductCard() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 8, offset: Offset(0, 2))
          ]);
}

// Widget privado encargado de mostrar el precio de un producto
class _PriceTagProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: const BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), bottomLeft: Radius.circular(15))),
      // Necesitamos escapar el símbolo $ con \, ya que $ dentro de una cadena en flutter permite interpolar el contenido de una variable
      child: const Text(
        '\$ 103.50',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

// Widget privado encargado de mostrar la imagen de producto
class _BackgroundProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Para lograr que la imagen se ajuste a los bordes redondeados de su padre, es necesario usar ClipRRect como envoltura de la imagen
    // Esto recortara la imagen para que se ajuste a los bordes de su contenedor
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        // FadeInImage, se recomienda usarlo en imagenes que son consumidas desde servicios externos (servidores http)
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage('https://placehold.jp/ffffff/878787/400x300.png'),
          // Ajustar ambas imagenes al mismo tamaño que su contenedor padre
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
