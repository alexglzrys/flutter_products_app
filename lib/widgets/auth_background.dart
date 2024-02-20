import 'package:flutter/material.dart';

// Widget encargado del color de fondo multicolor usado por la pantalla de Login
class AuthBackground extends StatelessWidget {
  // Se requiere un widget para mostrar encima de este fondo
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Usar Container si el contenedor tendrá color o márgen, en caso contrario, se recomienda un SizeBox
    return SizedBox(
      // Si no se especifica un color, el contenedor es transaparente
      // El tamaño del contenedor será igual al alto y ancho del dispositivo
      width: double.infinity,
      height: double.infinity,
      // Se requiere un hijo flotando encima del contenedor padre (contenedor de color purpura), un Icono de cabecera, y un Hijo que actuará como contenido principal flotando sobre el fondo
      // El Stack permite colocar elementos en pila, encima del contenedor padre (posicionamiento absoluto)
      child: Stack(children: [_PurpleBox(), _HeaderIcon(), child]),
    );
  }
}

// Widget encargado de mostrar el icono situado en la parte superior del fondo multicolo
class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Por defecto, cuando se usa el Stack, todos los elementos en pila se agregan en la parte superior izquierda
    // Sin embargo, dependiendo del dispositivo y SO. Existen áreas inseguras, las cuales son aprovechadas por los fabricantes para colocar cámaras (notch) y otros aditamentos
    // Para controlar ese problema, SafeArea es un widget que nos tiene 100% cubiertos, pues sabe si el dispositivo actual tiene áreas inseguras o no, y en caso de tenerlas, coloca los elementos en un área segura dentro de la pantalla visible
    return SafeArea(
      child: Container(
          width: double.infinity,
          // Sin SafeArea, es posible que estas 20 unidades de separación sean insuficientes para dispositivos con áreas inseguras
          margin: const EdgeInsets.only(top: 20),
          child: const Icon(
            Icons.person_pin,
            color: Colors.white,
            size: 100,
          )),
    );
  }
}

// Widget encargado de dibujar el contenedor de color morado gradiente
class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener información del tamaño del dispositivo
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      // Los widgets deben ser fáciles de leer. Cualquier configuración verbosa se puede separar en métodos privados dentro de la clase de ese mismo widget
      decoration: _purpleBackground(),
      // Este widget incluye algunas burbujas con opacidad ubicadas en distintas partes del mismo
      // El Stack me permita colocar elementos en pila, y Positioned me permite ubicarlos en distintas partes del contenedor padre
      child: Stack(
        children: [
          Positioned(
            top: 90,
            left: 30,
            child: _Bubble(),
          ),
          Positioned(
            top: -40,
            left: -30,
            child: _Bubble(),
          ),
          Positioned(
            top: -50,
            right: -20,
            child: _Bubble(),
          ),
          Positioned(
            bottom: -50,
            left: 10,
            child: _Bubble(),
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: _Bubble(),
          )
        ],
      ),
    );
  }

  // Método encargado de asignar el color gradiente al Widget _PurpleBox
  BoxDecoration _purpleBackground() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]));
}

// Widget encargado de dibujar circulos (burbujas) con opacidad
class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
