import 'package:flutter/material.dart';
import 'package:tarea/registrar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';

class Productos extends StatefulWidget {
  const Productos({super.key});

  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  getProducts() {
    return FirebaseFirestore.instance.collection("products").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade300,
      body: StreamBuilder(
          stream: getProducts(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            List<Widget> productos = [];
            var size = snapshot.data!.docs.length;
            for (var i = 0; i < size; i++) {
              Map<String, dynamic> data =
                  snapshot.data!.docs[i].data() as Map<String, dynamic>;
              productos.add(ListTile(
                title: Text(data['nombre']),
                subtitle: Text(
                    "codigo: ${data['codigo']} cantidad: ${data['cantidad']}"),
              ));
            }
            return ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 100.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/vestidos.png'),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            onSurface: Colors.blue,
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor: Colors.pinkAccent.shade700,
                            minimumSize: const Size(100, 50),
                            alignment: const Alignment(0, 0)),
                        child: const Text('Volver'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registrar()),
                          );
                        },
                      ),
                    ),
                    const Divider(
                      height: 40.0,
                    ),
                    ...productos
                  ],
                )
              ],
            );
          }),
    );
  }
}
