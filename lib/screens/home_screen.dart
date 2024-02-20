import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String screenName = 'home';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Home Screen')));
  }
}
