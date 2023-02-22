import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectomovilfinal/notifier/title-notifier.dart';
import 'package:projectomovilfinal/screens/profile-pet/modal-history.dart';
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

    pet['age'] = calcularEdad(pet);

    var eventRef = await FirebaseFirestore.instance
        .collection("pets")
        .doc(objectID)
        .collection("events")
        .orderBy("date", descending: true)
        .get();

    eventRef.docs.forEach((item) {
      events.add({...item.data(), "id": item.id});
    });

    var historyRef = await FirebaseFirestore.instance
        .collection("pets")
        .doc(objectID)
        .collection("histories")
        .orderBy("date", descending: true).get();

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

    context.read<TitleNotifier>().set("Detalle de mascota");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    Color color;
    Color bg;
pet['status'] = pet['status'] == null ? 'SALUDABLE' : pet['status'];

    switch (pet['status']) {
      case 'INTERNADO/EMERGENCIA':
        color = Colors.white;
        bg = const Color.fromRGBO(220, 53, 69, 1);
        break;
      case 'TRATAMIENTO':
        color = Colors.black;
        bg = const Color.fromRGBO(255, 193, 7, 1);
        break;
      case 'EN OBSERVACION':
        color = Colors.white;
        bg = Color.fromRGBO(13, 110, 253, 1);
        break;

      case 'SALUDABLE':
        bg = const Color.fromRGBO(25, 135, 84, 1);
        color = Colors.white;
        break;
      default:
        bg = const Color.fromRGBO(25, 135, 84, 1);
        color = Colors.white;
    }

    return SingleChildScrollView(
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
                      "assets/profile-pet.png",
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Container(
                    decoration: const BoxDecoration(color: vetColorOrange),
                    child: TabBar(
                      labelColor: vetTextTitleColor,
                      indicatorColor: vetPrimaryColor,
                      controller: _controller,
                      tabs: petTabs,
                    ),
                  ),
                  SizedBox(
                    height: double.maxFinite,
                    child: SizedBox(
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
                                      title:
                                          Text("${date} - ${item['reason']}"));
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
                                    contentPadding: EdgeInsets.all(10.0),
                                    trailing: TextButton(
                                        onPressed: () {
                                          objectHistory = item;
                                          objectHistory['status'] =
                                              pet['status'];

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      const ModalHistory()));
                                        },
                                        child: const Text(
                                          "Ver Detalle",
                                          style: TextStyle(
                                              color: vetSecondaryColor,
                                              fontSize: 15),
                                        )),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("${item['reason']}",
                                            style: const TextStyle(
                                                color: vetTextColor,
                                                fontWeight: FontWeight.bold)),
                                        Text("$date"),
                                      ],
                                    ));
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
                  contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  title: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(pet['name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: vetTextColor)),
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(bg)),
                            onPressed: () => {},
                            child: Text(pet['status'],
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                    backgroundColor: bg)),
                          ),
                        ]),
                  ),
                  subtitle: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pet['petType'],
                          style: const TextStyle(color: vetTextColor),
                        ),
                        Text.rich(
                          TextSpan(text: "Raza: ", children: [
                            TextSpan(
                              text: pet['breed'],
                              style: const TextStyle(
                                  color: vetTextColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                        ),
                        Text.rich(
                          TextSpan(text: "Edad: ", children: [
                            TextSpan(
                              text: pet['age'],
                              style: const TextStyle(
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
    );
  }

  calcularEdad(item) {
    var nacimiento = DateTime.fromMillisecondsSinceEpoch(item['birthdate']);
    var fechaActual = DateTime.now();

    var dayAc = fechaActual.day;
    var monthAc = fechaActual.month;
    var yearAc = fechaActual.year;

    var year = 0;
    var month = 0;
    var day = 0;

    if (dayAc - nacimiento.day >= 0) {
      day = (dayAc - nacimiento.day);
    } else {
      day = (dayAc + 30 - nacimiento.day);
      monthAc--;
    }

    if (monthAc - nacimiento.month >= 0) {
      month = (monthAc - nacimiento.month);
    } else {
      month = monthAc + 12 - nacimiento.month;
      yearAc--;
    }

    year = yearAc - nacimiento.year;

    var monthString = month == 1 ? 'mes' : 'meses';
    var dayString = day == 1 ? 'dia' : 'dias';
    var yearString = year == 1 ? 'año' : 'años';
    var completeYear = year != 0 ? "$year $yearString, " : '';

    return '$completeYear $month $monthString y $day $dayString';
  }
}
