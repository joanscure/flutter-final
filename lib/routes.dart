import 'package:flutter/cupertino.dart';
import 'package:projectomovilfinal/screens/auth/login.dart';
import 'package:projectomovilfinal/screens/home/home.dart';

final Map<String, WidgetBuilder> routes = {
  LoginForm.routeName: (context) => const LoginForm(),
  Home.routeName: (context) => const Home(),
};
