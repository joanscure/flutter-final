import 'package:flutter/material.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:projectomovilfinal/settings/size.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileClientScreen extends StatefulWidget {
  const ProfileClientScreen({super.key});

  @override
  State<ProfileClientScreen> createState() => _ProfileClientScreen();
}

class _ProfileClientScreen extends State<ProfileClientScreen> {
  late bool loading;
  late Map<String, dynamic> user = {};
  List<Map<String, dynamic>> pets = [];
  getUser() async {
    var refUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(objectID)
        .get();
    user = refUser.data() as Map<String, dynamic>;
    var petsRef = await FirebaseFirestore.instance
        .collection("pets")
        .where("userId", isEqualTo: refUser.id)
        .get();

    petsRef.docs.forEach((item) {
      pets.add({...item.data(), "id": item.id});
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    getUser();
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
          title: const Text("Detalle de Cliente",
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
                child: Image.asset(
                  "assets/perro.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        "MASCOTAS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: vetTextColor),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...pets.map((item) {
                          return GestureDetector(
                            onTap: () {
                              objectID = item['id'];
                              context
                                  .read<SelectViewModel>()
                                  .set(Section.PETPROFILE, "");
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              color: vetColorOrange,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.pets),
                                  SizedBox(width: 5),
                                  Text(item['name'])
                                ],
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const Text(
                              "INFORMACION DE CONTACTO",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: vetTextColor),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Compartir",
                              style: TextStyle(
                                  color: vetSecondaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.email),
                        SizedBox(width: 10),
                        Text(user['profile']['email']),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 10),
                        Text(user['profile']['phoneNumber']),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.phone_iphone),
                        SizedBox(width: 10),
                        Text(user['profile']['whatsapp']),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        "NOTAS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: vetTextColor),
                      ),
                    ),
                    Text(user['profile']['notes']),
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
                      padding: EdgeInsets.all(10),
                      child: Text(user['fullname'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: vetTextColor)),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Ink(
                          decoration: const ShapeDecoration(
                            color: vetSecondaryDarkColor,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.email),
                            color: vetPrimaryDarkColor,
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Ink(
                          decoration: const ShapeDecoration(
                            color: vetSecondaryDarkColor,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.phone),
                            color: vetPrimaryDarkColor,
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Ink(
                          decoration: const ShapeDecoration(
                            color: vetSecondaryDarkColor,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.phone_iphone),
                            color: vetPrimaryDarkColor,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
