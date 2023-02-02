import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';

class Home extends StatefulWidget {
  static const routeName = 'home';
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  int visit = 0;
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
                  child: const Text("actualizar"),
                ),
              ));
            }

            return ListView(children: [...usuarios]);
          }),
      bottomNavigationBar: 
        BottomBarInspiredInside(
          items: itemsTab,
          backgroundColor: Colors.white,
          color: ColorsApp[ColorsAppEnum.gray],
          colorSelected: Colors.white,
          itemStyle: ItemStyle.hexagon,
          indexSelected: visit,
          onTap: (index) => setState(() {
            visit = index;
          }),
          chipStyle: ChipStyle(
            isHexagon: true,
            convexBridge: true,
            background: ColorsApp[ColorsAppEnum.menu],
          ),
        ),
    );
  }
}
