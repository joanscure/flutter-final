import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/routes.dart';
import 'package:projectomovilfinal/screens/auth/login.dart';
import 'package:projectomovilfinal/screens/auth/registrar.dart';
import 'package:projectomovilfinal/screens/get-appointment/get_appointment.dart';
import 'package:projectomovilfinal/screens/home/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Login',
      home: GetAppointmentScreen(),
    );
  }
}
