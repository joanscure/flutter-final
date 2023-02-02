import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/routes.dart';
import 'package:projectomovilfinal/screens/auth/login.dart';
import 'package:projectomovilfinal/screens/auth/registrar.dart';
import 'package:projectomovilfinal/screens/profile-client/profile_client.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Provider.debugCheckInvalidValueType = null;

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectViewModel()),
      ],
      child: MaterialApp(
        home: MyApp(),
        //builder: EasyLoading.init(),
      )));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Login',
      theme: ThemeData(
        fontFamily: 'Poppins'
        ),
      home: const LoginForm(),
      initialRoute: 'login',
      routes: mainRoutes,
    );
  }
}
