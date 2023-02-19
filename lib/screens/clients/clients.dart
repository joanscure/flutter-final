import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/notifier/title-notifier.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/settings/constant.dart';

import 'package:provider/provider.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreen();
}

class _ClientsScreen extends State<ClientsScreen> {
  int visit = 0;
  getUser() {
    return FirebaseFirestore.instance.collection("users").where("isClient", isEqualTo: true).snapshots();
  }
  @override
  void initState() {
    super.initState();
    context.read<TitleNotifier>().set("Patita Feliz");
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
                Image.asset("assets/profile-client.jpg") :
                Image.network(data['profile']['photoUrl']),
                trailing: TextButton(
                  onPressed: () {
                    objectID = id;
                    context.read<SelectViewModel>().set(Section.PROFILE, "");
                  },
                  child: const Text("Ver Perfil"),
                ),
              ));
            }
            return Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      child: const Text("Lista de Clientes", style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0, color: vetPrimaryColor))
                  ),
                  Expanded(
                      child: ListView(children: [...usuarios])
                  )

                ]
            );
            //return ListView(children: [...usuarios]);
          }),
    );
  }
}
