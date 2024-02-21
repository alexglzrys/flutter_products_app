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
        height: 400,
        color: Colors.red,
      ),
    );
  }
}
