import 'package:flutter/material.dart';
import 'package:products_flutter_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String screenName = 'login';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AuthBackground());
  }
}
