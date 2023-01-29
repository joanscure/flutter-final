import 'package:flutter/cupertino.dart';
import 'package:projectomovilfinal/screens/auth/home.dart';
import 'package:projectomovilfinal/screens/auth/logo.dart';

final Map<String, WidgetBuilder> routes = {
  MyAppForm.routeName: (context) => const MyAppForm(),
  Home.routeName: (context) => const Home(),
};
