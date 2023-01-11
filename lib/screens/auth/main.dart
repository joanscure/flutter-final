import 'package:flutter/material.dart';
import 'package:nuevo/logo.dart';
import 'package:nuevo/registrar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Login',
      home: Registrar (),
    );
  }
}