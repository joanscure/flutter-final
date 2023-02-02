import 'package:flutter/cupertino.dart';
import 'package:projectomovilfinal/screens/auth/login.dart';
import 'package:projectomovilfinal/screens/home/home.dart';

final Map<String, WidgetBuilder> mainRoutes = {
  LoginForm.routeName: (context) => const LoginForm(),
  Home.routeName: (context) => const Home(),
};

final Map<String, WidgetBuilder> appRoutes = {
  LoginForm.routeName: (context) => const LoginForm(),
  Home.routeName: (context) => const Home(),
};
