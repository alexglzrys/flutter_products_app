import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String screenName = 'login';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Login Screen')));
  }
}
