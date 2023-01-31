import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/routes.dart';
import 'package:projectomovilfinal/screens/auth/login.dart';
import 'package:projectomovilfinal/screens/auth/registrar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Login',
      home: const LoginForm(),
      initialRoute: 'login',
      routes: routes,
    );
  }
}
