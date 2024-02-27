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

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
