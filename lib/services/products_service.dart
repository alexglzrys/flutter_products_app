import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:products_flutter_app/models/models.dart';

// Servicio para gestionar lo productos.
// Extiende de ChangeNotifier, ya que necesitamos notificar en todo momento a la UI los cambios que vayan surgiendo en los productos
class ProductsService extends ChangeNotifier {
  // ? Firebase Realtime Database puede usarse como un servcio de REST API
  final String _baseUrl = 'training-flutter-dev-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;
  bool isSaving = false;
  // su valor será inicializado más tarde cuando el usuario seleccione un producto, mientras tanto serà nula
  late Product selectedProduct;

  ProductsService() {
    // En el momento que se genere la instancia de ProductService, cargamos el listado de productos
    loadProducts();
  }

  Future loadProducts() async {
    // Cambiar estado de la petición http en progreso y notificar a todos los listeners (redibujar pantalla)
    isLoading = true;
    notifyListeners();

    // La siguiente linea genera... https://training-flutter-dev-default-rtdb.firebaseio.com/products.json
    final url = Uri.https(_baseUrl, 'products.json');
    final response = await http.get(url);
    // Me interesa el cuerpo de la respuesta del servicio (listado de procutos)
    final Map<String, dynamic> productsMap = json.decode(response.body);
    // Sin embargo, Firebase RealTime Database al tratarse de una colección de documentos, estos los recupera como {ID_documento: {cuerpo_del_documento}}
    // Es por ello, que necesitan iterarse para lograr recuperar un listado que cumpla con el cuerpo o estructura de un Documento tal como lo necesita mi app
    productsMap.forEach((key, value) {
      // Obtengo una instancia de Producto
      final temporalProduct = Product.fromJson(value);
      // agregamos su id como parte del cuerpo del Documento
      temporalProduct.id = key;
      // agregamos al listado de Productos
      products.add(temporalProduct);
    });

    // Cambiar estado de la petición http en completado y notificar a todos los listeners (redibujar pantalla)
    isLoading = false;
    notifyListeners();
  }

  // Método para crear o actualizar un producto
  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      // Se trata de un nuevo registro
    } else {
      // Se trata de una actualización de un producto existente
      await _updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  // Método privado encargado de actualizar un Producto por su ID en Firebase Realtime Database
  Future<String> _updateProduct(Product product) async {
    // La siguiente linea genera... https://training-flutter-dev-default-rtdb.firebaseio.com/products/ABC01.json
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    // El cuerpo de la petición espera un objeto, para este este caso un Product en formato JSON
    final response = await http.put(url, body: product.toRawJson());
    final decodedData = response.body;
    print(decodedData);
    return product.id!;
  }
}
