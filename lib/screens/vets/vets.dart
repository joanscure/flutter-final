import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/settings/constant.dart';

import 'package:provider/provider.dart';

class VetScreen extends StatefulWidget {
  const VetScreen({super.key});

  @override
  State<VetScreen> createState() => _VetScreen();
}

class _VetScreen extends State<VetScreen> {
  int visit = 0;
  getUser() {
    return FirebaseFirestore.instance
        .collection("users")
        .where("isVet", isEqualTo: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: getUser(),
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

            List<Widget> usuarios = [];
            var size = snapshot.data!.docs.length;
            for (var i = 0; i < size; i++) {
              String id = snapshot.data!.docs[i].id;
              Map<String, dynamic> data =
                  snapshot.data!.docs[i].data() as Map<String, dynamic>;
              usuarios.add(ListTile(
                title: Text(data['fullname']),
                subtitle: Text(data['email']),
                leading:
                data['profile']['photoUrl'] == '' ?
                  Image.asset("assets/registrar.png") :
                  Image.network(data['profile']['photoUrl']),
                trailing: TextButton(
                  onPressed: () {
                    objectID = id;
                    context.read<SelectViewModel>().set(Section.VET, "");
                  },
                  child: const Text("Ver Perfil"),
                ),
              ));
            }

            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: const Text("Lista de Veterinarios", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0, color: vetPrimaryColor))
                ),
                Expanded(
                  child: ListView(children: [...usuarios])
                )

              ]
            );
          }),
    );
  }
}
