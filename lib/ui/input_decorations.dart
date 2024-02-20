import 'package:flutter/material.dart';

// Clase con métodos estáticos que agrupan configuraciones de decoración de inputs de formulario
class InputDecorations {
  // Decoración de inputs para el formulario de login
  // Requiere el label, placeholder (hintText), y un icono opcional
  static InputDecoration authInputDecoration(
      {required String labelText,
      required String hintText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.deepPurple)
            : null);
  }
}
