import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:projectomovilfinal/notifier/user-notifier.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/routes.dart';
import 'package:projectomovilfinal/screens/auth/login.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Provider.debugCheckInvalidValueType = null;
  await initializeDateFormatting();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectViewModel()),
        ChangeNotifierProvider(create: (_) => UserNotifier()),
      ],
      child: MaterialApp(
        home: MyApp(),
        builder: EasyLoading.init(),
        //builder: EasyLoading.init(),
      )));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Login',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const LoginForm(),
      initialRoute: 'login',
      routes: mainRoutes,
    );
  }
}
