import 'package:flutter/material.dart';
import 'package:products_flutter_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Propiedad para almacenar el producto seleccionado por el usuario
  // En lugar de declarar una propieda para cada campo del formulario, suena lógico usar una propiedad de tipo Product
  Product product;

  // El constructor inicializa el producto automáticamente al instanciar la clase
  // Este constructor está utilizando una sintaxis abreviada en Dart para asignar automáticamente el parámetro a la variable de instancia (propiedad product)
  ProductFormProvider(this.product);

  // Método para actualizar el estado de la disponibilidad del producto seleccionado
  updateAvailability(bool value) {
    product.available = value;
    // Notificar a los listeners para que actualicen la UI (el control de switch cambie de estado o comportamiento)
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
