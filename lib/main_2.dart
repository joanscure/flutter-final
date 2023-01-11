import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/screens/chat-vet/chat-vet.dart';
import 'package:projectomovilfinal/screens/chat/chat.dart';
import 'package:projectomovilfinal/screens/profile-client/profile_client.dart';
import 'package:projectomovilfinal/screens/profile-vet/profile_vet.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:projectomovilfinal/settings/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int visit = 0;

  @override
  Widget build(BuildContext context) {
    //return ProfileclientScreen();
    return ChatVet();
  }
}
