import 'package:flutter/material.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:projectomovilfinal/settings/size.dart';

import 'package:provider/provider.dart';

class ProfileVetScreen extends StatelessWidget {
  const ProfileVetScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Detalle de Veterinario",
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
                  children: const [
                    Icon(Icons.email),
                    SizedBox(width: 10),
                    Text("rosaly@gamil.com"),
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
                    Icon(Icons.phone_iphone),
                    SizedBox(width: 10),
                    Text("+51 203 494 494"),
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
                  children: const [
                    Icon(Icons.backpack),
                    SizedBox(width: 10),
                    Text(" Veterinaria calificada"),
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
                const Text(
                    "Está capacitado para ejercer la profesión y seguir programas de educación continua, imbuido del espíritu ético y humanista que requiere para comprender y actuar en los diversos ámbitos de la profesión: salud, bienestar y producción de especies animales terrestres y acuícolas, salud pública, protección y calidad de los alimentos y la prevención y control de las enfermedades zoonóticas y emergentes"),
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
                      child: Text("Rosaly Lizano",
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
      ),
    );
  }
}
