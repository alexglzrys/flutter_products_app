import 'package:flutter/material.dart';
import 'package:products_flutter_app/models/models.dart';

// Servicio para gestionar lo productos.
// Extiende de ChangeNotifier, ya que necesitamos notificar en todo momento a la UI los cambios que vayan surgiendo en los productos
class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'training-flutter-dev-default-rtdb.firebaseio.com';
  final List<Product> products = [];
}
