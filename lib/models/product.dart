import 'dart:convert';

// Clase que representa una entidad de un producto en mi aplicación
// https://app.quicktype.io/

class Product {
  bool available;
  String name;
  String? picture;
  double price;
  String? id;

  Product(
      {required this.available,
      required this.name,
      required this.price,
      this.picture,
      this.id});

  // Método que retorna una nueva copia de Producto
  // En Dart los objetos son pasados por referencia, en este sentido, este método es un salvavidas para evitar modificar el objeto original de forma accidental
  Product copyWith() => Product(
      available: available, name: name, price: price, picture: picture, id: id);

  // Retorna una instancia de Product, a partir de una cadena de texto que tiene pinta de un json
  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };
}
