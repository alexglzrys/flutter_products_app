import 'package:flutter/material.dart';
import 'package:products_flutter_app/models/models.dart';

// Widget encargado de mostrar la tarjeta para representar un producto particular
class ProductCard extends StatelessWidget {
  // Se requiere información de un Producto para mostrar en este widget
  final Product product;
  const ProductCard({super.key, required this.product});

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
        // Una imagen de fondo, y distintas etiquetas para mostrar los detalles del producto, precio, y un mensaje si el producto no se encuentra disponible
        child: Stack(
          children: [
            // Este widget ocupa el 100% del alto y ancho de su contenedor padre, por tanto no hay necesidad de posicionarlo
            _BackgroundProductCard(product.picture),
            Positioned(
                top: 0, right: 0, child: _PriceTagProductCard(product.price)),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _DetailsProductCard(
                  title: product.name, description: product.id),
            ),
            // Mostrar este widget solo si el producto no se encuentra disponible
            if (!product.available)
              Positioned(top: 0, left: 0, child: _NotAvailable())
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

// Widget encargado de mostrar un tag cuando un producto no esta disponible
class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(228, 146, 5, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
      child: const Text(
        'No disponible',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
      ),
    );
  }
}

// Widget privado encargado de mostrar los detalles del producto
class _DetailsProductCard extends StatelessWidget {
  final String title;
  final String? description;

  const _DetailsProductCard({this.description, required this.title});

  @override
  Widget build(BuildContext context) {
    // FractionallySizedBox permite dimensionar sus hijos como una fracción del espacio total disponible
    // En este ejemplo le estamos diciendo a flutter que el Contenedor ocupará el 85% del ancho de su componente padre
    return FractionallySizedBox(
      widthFactor: 0.75,
      // El contenedor quedará alineado a la izquierda dentro del espacio asignado
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: _decorationDetailsProductCard(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              // Este texto solo puede mostrarse en un solo renglón
              maxLines: 1,
              // Si el contendio excede el espacio disponible, se muestran puntos suspensivos
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            if (description != null)
              Text(
                description!,
                style: const TextStyle(fontSize: 12),
              )
          ],
        ),
      ),
    );
  }

  // Método privado encargado de la decoración referente a la sección de detalle del producto
  BoxDecoration _decorationDetailsProductCard() {
    return const BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), topRight: Radius.circular(15)));
  }
}

// Widget privado encargado de mostrar el precio de un producto
class _PriceTagProductCard extends StatelessWidget {
  final double price;

  const _PriceTagProductCard(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      // Tag o Bullet con ancho fijo
      // Esto puede provocar que textos de longitud larga ocupen más de una linea (provocando una altura no deseable en el padre), o que los textos aparezcan cortados.
      width: 100,
      alignment: Alignment.center,
      decoration: _decorationPriceTagProductCard(),
      // FittedBox es un widget ayuda a evitar sus hijos crezcan más allá de cierto límite, reescalándolos según el espacio disponible
      child: FittedBox(
        fit: BoxFit.contain,
        // Necesitamos escapar el símbolo $ con \, ya que $ dentro de una cadena en flutter permite interpolar el contenido de una variable
        child: Text(
          '\$ $price',
          style: const TextStyle(fontSize: 15),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  // Método encargado de la decoración referente a la sección de precio de un producto
  BoxDecoration _decorationPriceTagProductCard() {
    return const BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), bottomLeft: Radius.circular(15)));
  }
}

// Widget privado encargado de mostrar la imagen de producto
class _BackgroundProductCard extends StatelessWidget {
  final String? picture;

  const _BackgroundProductCard(this.picture);
  @override
  Widget build(BuildContext context) {
    // Para lograr que la imagen se ajuste a los bordes redondeados de su padre, es necesario usar ClipRRect como envoltura de la imagen
    // Esto recortara la imagen para que se ajuste a los bordes de su contenedor
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          // Comprobar si el producto tiene imagen asignada, en caso contrario mostrar una por defecto
          child: picture == null
              ? const Image(
                  image: AssetImage('assets/no-image.png'),
                  fit: BoxFit.cover,
                )
              // FadeInImage, se recomienda usarlo en imagenes que son consumidas desde servicios externos (servidores http)
              : FadeInImage(
                  placeholder: const AssetImage('assets/jar-loading.gif'),
                  image: NetworkImage(picture!),
                  // Ajustar ambas imagenes al mismo tamaño que su contenedor padre
                  fit: BoxFit.cover,
                )),
    );
  }
}
