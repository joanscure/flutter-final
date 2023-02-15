import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:projectomovilfinal/settings/size.dart';

import 'package:provider/provider.dart';
class ProfilePetScreen extends StatefulWidget {
  const ProfilePetScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePetScreen();
}

class _ProfilePetScreen extends State<ProfilePetScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  static const List<Tab> petTabs = <Tab>[
    Tab(text: 'EVENTOS'),
    Tab(text: 'HISTORIAL'),
  ];
  late bool loading;

  List<Map<String, dynamic>> events = [];
  List<Map<String, dynamic>> histories = [];
  late Map<String, dynamic> pet = {};
  getPet() async {
    var refPet =
        await FirebaseFirestore.instance.collection("pets").doc(objectID).get();
    pet = refPet.data() as Map<String, dynamic>;

    var eventRef = await FirebaseFirestore.instance
        .collection("pets")
        .doc(objectID)
        .collection("events")
        .get();

    eventRef.docs.forEach((item) {
      events.add({...item.data(), "id": item.id});
    });

    var historyRef = await FirebaseFirestore.instance
        .collection("pets")
        .doc(objectID)
        .collection("histories")
        .get();

    historyRef.docs.forEach((item) {
      histories.add({...item.data(), "id": item.id});
    });

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    loading = true;
    getPet();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_circle_left),
            tooltip: 'Atras',
            onPressed: () {
              objectID = pet['userId'];

              context.read<SelectViewModel>().set(Section.PROFILE, "");
            },
          ),
          title: const Text("Detalle de Mascota",
              style: TextStyle(
                  color: vetTextTitleColor, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [

              SizedBox(
                height: 200,
                width: double.infinity,
                child: pet['photoUrl'] != ''
                    ? Image.network(
                  pet['photoUrl'],
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  "assets/profile-pet.jpg",
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Container(
                      decoration: BoxDecoration(color: vetColorOrange),
                      child: TabBar(
                        labelColor: vetTextTitleColor,
                        indicatorColor: vetPrimaryColor,
                        controller: _controller,
                        tabs: petTabs,
                      ),
                    ),
                    Container(
                      height: double.maxFinite,
                      child: Container(
                        width: SizeConfig.screenWidth,
                        child: TabBarView(
                            controller: _controller,
                            children: petTabs.map((Tab tab) {
                              final String label = tab.text!.toLowerCase();
                              if (label == 'eventos') {
                                return ListView(children: [
                                  ...events.map((item) {
                                    DateTime now =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            item['date']);
                                    String date =
                                        DateFormat('yyyy-MM-dd').format(now);
                                    return ListTile(
                                        title: Text(
                                            "${date} - ${item['reason']}"));
                                  })
                                ]);
                              }
                              return ListView(children: [
                                ...histories.map((item) {
                                  DateTime now =
                                      DateTime.fromMillisecondsSinceEpoch(
                                          item['date']);
                                  String date =
                                      DateFormat('yyyy-MM-dd').format(now);
                                  return ListTile(
                                      trailing: const Text(
                                        "Ver Detalle",
                                        style: TextStyle(
                                            color: vetSecondaryColor,
                                            fontSize: 15),
                                      ),
                                      title: Text("$date - ${item['reason']}"));
                                })
                              ]);
                            }).toList()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 150,
            child: SizedBox(
                width: SizeConfig.screenWidth,
                child: Card(
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(15),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                    title: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: Text(pet['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: vetTextColor)),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pet['petType'],
                            style: TextStyle(color: vetTextColor),
                          ),
                          Text.rich(
                            TextSpan(text: "Raza: ", children: [
                              TextSpan(
                                text: pet['breed'],
                                style: TextStyle(
                                    color: vetTextColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          ),
                          Text.rich(
                            TextSpan(text: "Edad: ", children: [
                              TextSpan(
                                text: "---",
                                style: TextStyle(
                                    color: vetTextColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
