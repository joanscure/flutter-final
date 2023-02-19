import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/notifier/title-notifier.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:projectomovilfinal/settings/size.dart';

import 'package:provider/provider.dart';

class ProfileVetScreen extends StatefulWidget {
  const ProfileVetScreen({super.key});

  @override
  State<ProfileVetScreen> createState() => _ProfileVetScreen();
}

class _ProfileVetScreen extends State<ProfileVetScreen> {

  late bool loading;
  late Map<String, dynamic> user = {};
  getUser() async {
    var refUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(objectID)
        .get();
    user = refUser.data() as Map<String, dynamic>;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    getUser();
    context.read<TitleNotifier>().set("Detalle de veterinario");
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return  SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [

                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: user['profile']['photoUrl'] != ''
                  ? Image.network(
                      user['profile']['photoUrl'],
                    fit: BoxFit.cover,
                  )
                  : Image.asset(
                    "assets/test.jpg",
                    fit: BoxFit.cover,
                  ),
                ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          "INFORMACION DE CONTACTO",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: vetTextColor),
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
                  children:  [
                    Icon(Icons.email),
                    SizedBox(width: 10),
                    Text(user['email']),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children:  [
                    Icon(Icons.phone),
                    SizedBox(width: 10),
                    Text(user['profile']['phoneNumber']),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children:  [
                    Icon(Icons.phone_iphone),
                    SizedBox(width: 10),
                    Text(user['profile']['whatsapp']),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 10),
                    Text("Disponible"),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.backpack),
                    SizedBox(width: 10),
                    Text(user['profile']['specialist']),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    "PERFIL PROFESIONAL",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: vetTextColor),
                  ),
                ),

                  Text(user['profile']['notes']
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
                    title:  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(user['fullname'],
                          style: const TextStyle(
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
                        const SizedBox(width: 16),
                        Ink(
                          decoration: const ShapeDecoration(
                            color: vetSecondaryDarkColor,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.calendar_month),
                            color: vetPrimaryDarkColor,
                            onPressed: () {
                              objectID = objectID;
                              context.read<SelectViewModel>().set(Section.APPOINTMENT, "");
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ]),
      );
  }
}
