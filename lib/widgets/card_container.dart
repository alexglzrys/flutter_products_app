import 'package:flutter/material.dart';

// Widget encargado de generar una envoltura con estilo de tarjeta
class CardContainer extends StatelessWidget {
  // Requiere de un Widget hijo para colocarlo como contenido principal de la tarjeta
  final Widget child;
  const CardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Como la tarjeta ocupa el 100% del ancho disponible del dispositivo, es necesario dar un Padding para que no quede tan pegada a los bordes
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        // Para mantener fácil la lectura de este widget, su estilo y decoración se encuentra agrupada en un método privado
        decoration: _createCardShape(),
        // El hijo de la tarjeta será el widget pasado como argumento
        child: child,
      ),
    );
  }

  // Método privado encargado de dar el estilo y decoración del CardContainer
  BoxDecoration _createCardShape() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            // La sombra requiere 3 parámetros, el color, el blur (expansión de sombra), y el desplazamiento (x, y)
            BoxShadow(
                color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))
          ]);
}
