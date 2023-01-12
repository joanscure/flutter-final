import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/screens/Receta/receta.dart';
import 'package:projectomovilfinal/settings/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorPrincipal,
      ),
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
  _showRecipe() async {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
      return const Receta();
    }));
  }

  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
          children: [
            const Text("Tratamiento 1"),
            const Text("12/02/2023"),
            TextButton(onPressed: _showRecipe, child: const Text("Ver Receta"))
          ],
        ),

      bottomNavigationBar:  BottomBarDefault(
        items: items,
        backgroundColor: Colors.white,
            color: const Color(0xFFbcc0c9),
            colorSelected: Colors.blue,

        indexSelected: visit,
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}
