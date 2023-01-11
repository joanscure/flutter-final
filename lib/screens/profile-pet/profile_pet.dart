import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:projectomovilfinal/settings/size.dart';

class ProfilePetScreen extends StatefulWidget {
  const ProfilePetScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePetScreen();
}

class _ProfilePetScreen extends State<ProfilePetScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  static const List<Tab> petTabs = <Tab>[
    Tab(text: 'TRAMAMIENTOS'),
    Tab(text: 'CITAS'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
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
                child: Image.asset(
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
                            if (label == 'citas') {
                              return ListView.builder(
                                  itemCount: 5,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                        trailing: const Text(
                                          "Ver Receta",
                                          style: TextStyle(
                                              color: vetSecondaryColor,
                                              fontSize: 15),
                                        ),
                                        title: Text("${index + 1}/02/23 - Cita ${index + 1}"));
                                  });
                            }
                            return ListView.builder(
                                  itemCount: 5,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                        trailing: const Text(
                                          "Ver Tratamiento",
                                          style: TextStyle(
                                              color: vetSecondaryColor,
                                              fontSize: 15),
                                        ),
                                        title: Text("${index + 1}/02/23 - Tratamiento"));
                                  });
                          }).toList(),
                        ),
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
                    title: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: Text("SCOTT",
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
                        children: const [
                          Text(
                            "Perro",
                            style: TextStyle(color: vetTextColor),
                          ),
                          Text.rich(
                            TextSpan(text: "Raza: ", children: [
                              TextSpan(
                                text: "Pastor Alemán",
                                style: TextStyle(
                                    color: vetTextColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          ),
                          Text.rich(
                            TextSpan(text: "Edad: ", children: [
                              TextSpan(
                                text: " 4años",
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
