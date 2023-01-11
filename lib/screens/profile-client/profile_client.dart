import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:projectomovilfinal/settings/size.dart';

class ProfileclientScreen extends StatelessWidget {
  const ProfileclientScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      color: vetColorOrange,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.pets),
                          SizedBox(width: 5),
                          Text("Roko")
                        ],
                        ),
                      ),
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
                  children: const [
                    Icon(Icons.email),
                    SizedBox(width: 10),
                    Text("----"),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.phone),
                    SizedBox(width: 10),
                    Text("+51 123 456 789"),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.whatsapp),
                    SizedBox(width: 10),
                    Text("+51 203 494 494"),
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
                const Text(
                    "Ninguna nota registrada"),
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
                    title: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Claudia Lachapelle",
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
                            icon: const Icon(Icons.whatsapp),
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
