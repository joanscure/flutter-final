
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget{
  String title;

  AppBarCustom({super.key, required this.title, required this.preferredSize});

  @override
  final Size preferredSize; 

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }
}
