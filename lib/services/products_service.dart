import 'dart:convert';
import 'dart:io';

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
  File? newPictureFile;

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
      await _createProduct(product);
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
    await http.put(url, body: product.toRawJson());

    //final decodedData = response.body;
    //print(decodedData);

    // Actualizar la lista de productos con los nuevos cambios del producto modificado.
    _findAndUpdateProduct(products, product);
    return product.id!;
  }

  // Método privado encargado de registrar un neuvo Producto en Firebase Realtime Database
  Future<String> _createProduct(Product product) async {
    // La siguiente linea genera... https://training-flutter-dev-default-rtdb.firebaseio.com/products.json
    final url = Uri.https(_baseUrl, 'products.json');
    // El cuerpo de la petición espera un objeto, para este este caso un Product en formato JSON
    final response = await http.post(url, body: product.toRawJson());
    // Firebase regresa un Json en formato de String con el id del nuevo producto registrado {"name": "nuevo_id_generado"}
    final decodedData = json.decode(response.body);
    // Agregar el id a este nuevo producto (el ID lo genera de forma automática Firebase Realtime Database)
    product.id = decodedData['name'];
    // Agregar el nuevo producto registrado a la lista de productos.
    products.add(product);
    return product.id!;
  }

  // Método privado para actualizar el listado de productos con los nuevos cambios de un producto recientemente modificado.
  void _findAndUpdateProduct(List<Product> products, Product product) {
    // Buscar dentro del listado de productos, el indice o posición del producto recientemente modificado (con base en su id)
    int index = products
        .indexWhere((currentProduct) => currentProduct.id == product.id);
    // Si el índice es díferente de -1, significa que se localizó el producto en el listado
    if (index != -1) {
      // Las listas en Dart pasan como referencia, por tanto, en la posición actual coloco el producto con su nueva información
      products[index] = product;
    }
  }

  // Método para asignar o actualizar la ruta de imagen referente a un producto seleccionado
  void updateSelectedProductImage(String? path) {
    selectedProduct.picture = path;
    // bandera que indica que hay actualmente una imagen seleccionada (se usará para subir el archivo en Cloudinary)
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  // Método para subir la imagen de producto al servicio de Cloudinary mediante su servicio de Upload REST API Call
  Future<String?> uploadImage() async {
    // Verificar que se tenga un path de imagen seleccionada (el valor en esta propiedad existe si se ha seleccionado un producto con la cámara)
    if (newPictureFile == null) return null;

    // cambiar estado a guardado de información en progreso
    isSaving = true;
    notifyListeners();

    // Enviar imagen al servicio de Cloudinary

    // La siguiente URI apunta al servicio que ofrece Cloudinary para la subida de imagenes que no requieren autenticación
    const URI_API_REST =
        'https://api.cloudinary.com/v1_1/diotlmzzk/image/upload?upload_preset=flutter_products';
    // Establecer url
    final url = Uri.parse(URI_API_REST);
    // Indicar que se enviarán archivos en el cuerpo de la petición (Multi Part)
    final imageUploadRequest = http.MultipartRequest('post', url);
    // Seleccionar y preparar archivo
    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);
    // Adjuntar archivo en la petición
    imageUploadRequest.files.add(file);
    // Enviar la petición
    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('Algo ha salido mal al intentar subir la imagen a Cloudinary');
      print(response.body);
      return null;
    }

    // Establecer el archivo seleccionado a null
    newPictureFile = null;
    // Decodificar la respuesta que entrega el servicio de Cloudinary para obtener el url que apunta al recurso subido
    final decodedData = json.decode(response.body);
    return decodedData['secure_url'];
  }
}
