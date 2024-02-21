import 'package:flutter/material.dart';

// Provider para gestionar el estado del formulario de Login
class LoginFormProvider extends ChangeNotifier {
  // Crear una instancia específica para gestionar el estado de un Formulario
  // Permite realizar acciones como validar el formulario, guardar su estado, resetearlo, e interactuar con los campos del formulario de forma programatica
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Información a gestionar por el fomrulario de Login
  String email = '';
  String password = '';
  // Propiedad privada que permite conocer si el formulario se encuentra en un estado de procesamiento, sin enviar o enviado
  bool _isLoading = false;

  // Getters and Setters

  bool get isLoading => _isLoading;
  // Cuando el fomulario se envia, su estado pasa a true, una vez enviado pasa nuevamente a ser false
  set isLoading(bool value) {
    _isLoading = value;
    // Cuando cambia el estado de _isLoading, necesitamos hacer cambios en la UI,
    // es por eso que lanzamos el notifyListeners() para que todos los widgets suscritos a este provider escuchen los cambios
    notifyListeners();
  }

  // Método para saber si el formulario a pasado todas las validaciones
  bool isValidForm() {
    return formKey.currentState!.validate();
  }
}
