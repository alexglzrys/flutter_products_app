import 'package:flutter/material.dart';

// Provider para gestionar el estado del formulario de Login
class LoginFormProvider extends ChangeNotifier {
  // Crear una instancia específica para gestionar el estado de un Formulario
  // Permite realizar acciones como validar el formulario, guardar su estado, resetearlo, e interactuar con los campos del formulario de forma programatica
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Información a gestionar por el fomrulario de Login
  String email = '';
  String password = '';

  // Método para saber si el formulario a pasado todas las validaciones
  bool isValidForm() {
    return formKey.currentState!.validate();
  }
}
