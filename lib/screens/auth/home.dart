import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static final routeName = 'home';
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  getUser() {
    return FirebaseFirestore.instance.collection("users").snapshots();
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
                subtitle: Text(data['email'] + "-" + id),
                leading: TextButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(id)
                        .update({
                          'isAdmin': true,
                        });
                  },
                  child: Text("actualizar"),
                ),
              ));
            }

            return ListView(children: [...usuarios]);
          }),
    );
  }
}
