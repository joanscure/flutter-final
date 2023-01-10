import 'package:flutter/material.dart';
import 'package:projectomovilfinal/screens/Receta/components/body.dart';

class Receta extends StatelessWidget {
  const Receta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tratamiento 1"),
      ),
      body: const BodyReceta());
    }
}
