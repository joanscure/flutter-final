import 'package:flutter/material.dart';
import 'package:projectomovilfinal/screens/auth/logo.dart';
import 'package:projectomovilfinal/screens/auth/registrar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Login',
      home: MyAppForm(),
    );
  }
}
