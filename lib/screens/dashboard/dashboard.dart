import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:projectomovilfinal/notifier/title-notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Home();
}

class _Home extends State<Dashboard> {
  late bool loading = true;
  late bool isClient;
  late String name;
  int clients = 0;
  int pets = 0;
  int vets = 0;

  List<Map<String, dynamic>> events = [];

  setUser() async {
    final prefs = await SharedPreferences.getInstance();

    String id = prefs.getString("id") ?? '';
    name = prefs.getString("name") ?? '';
    isClient = prefs.getBool("isClient") ?? true;

    var refVets = await FirebaseFirestore.instance
        .collection("users")
        .where("isClient", isEqualTo: true)
        .get();
    clients = refVets.docs.length;

    var refClient = await FirebaseFirestore.instance
        .collection("users")
        .where("isVet", isEqualTo: true)
        .get();
    vets = refClient.docs.length;
    var refpets = await FirebaseFirestore.instance
        .collection("pets")
        .where("userId", isEqualTo: id)
        .get();
    pets = refpets.docs.length;
    DateTime date = DateTime.now();

    var eventRef = await FirebaseFirestore.instance
        .collection("appointments")
        .where('date', isGreaterThan: date.millisecondsSinceEpoch)
        .orderBy("date", descending: true)
        .get();

    eventRef.docs.forEach((item) {
      events.add({...item.data(), "id": item.id});
    });

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loading = true;
    super.initState();
    context.read<TitleNotifier>().set("Patita Feliz");
    setUser();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SizedBox(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFececec),
            ),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Bienvenido ${name}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Es bueno verte otra vez",
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                SvgPicture.asset(
                  "assets/hello.svg",
                  width: 100,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                child: Expanded(child: 
Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (isClient? 'Mascotas': "Clientes"),
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          (isClient? "$pets": "$clients"),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                          (isClient? Icons.pets: Icons.people),
                          size: 50, color: Colors.white),
                    )
                  ],
                ),
                  )
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange,
                ),
                padding: const EdgeInsets.all(10),
                child: Expanded(child: 
Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Veterinarios",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          "$vets",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.emoji_people,
                          size: 50, color: Colors.white),
                    )
                  ],
                )
                  ),
              ),
            ],
          ),

          const SizedBox(
            height: 30,
          ), //space between bullet and text
          const Text(
            "Proximos Eventos",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(
            height: 30,
          ), //space between bullet and text
          Expanded(
              child: ListView(children: [
            ...events.map((item) {
              DateTime now = DateTime.fromMillisecondsSinceEpoch(item['date']);
              String date = DateFormat('yyyy-MM-dd').format(now);
              return ListTile(
                title: Text("$date - ${item['reason']}"),
                subtitle: Text(
                    "Mascota: ${item['petName']} \nNotas: ${item['notes']}"),
              );
            })
          ]))
        ],
      ),
    );
  }
}
