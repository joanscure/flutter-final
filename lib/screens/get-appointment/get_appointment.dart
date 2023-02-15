import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:projectomovilfinal/settings/size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/request_appointment_button.dart';

class GetAppointmentScreen extends StatelessWidget {
  const GetAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Citas",
              style: TextStyle(
                  color: vetTextTitleColor, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                "assets/citar.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      "¡REGISTRA TU CITA AHORA!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: vetTextColor),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                      "Rellena el formulario para reservar tu cita de la forma más cómoda y sencilla.",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: vetTextColor),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      "Nos pondremos en contacto contigo cuanto antes para confirmarla.",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: vetTextColor),
                    ),
                  ),
                  RequestAppointmentButton(
                    text: "Solicitar cita",
                    onpressed: () {
                      showModal(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showModal(BuildContext context) {
    TextEditingController mascotaController = TextEditingController();
    TextEditingController fechaController = TextEditingController();
    TextEditingController horaController = TextEditingController();
    late Map<String, dynamic> vet = {};
    String? userId;
    String? petId;
    DateTime? dayPicked;
    TimeOfDay? timePicked;

    Future<void> showMascotasModal(BuildContext context) async {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('id');
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Hacer la consulta a la colección de mascotas
      QuerySnapshot querySnapshot = await firestore
          .collection('pets')
          .where("userId", isEqualTo: prefs.getString('id'))
          .get();

      // Iterar sobre los documentos y crear los ListTile
      List<Widget> listTiles = querySnapshot.docs.map((doc) {
        return ListTile(
          title: Text(doc.get("name").toString()),
          onTap: () {
            mascotaController.text = doc.get("name").toString();
            petId = doc.id;
            Navigator.pop(context);
          },
        );
      }).toList();

      // Mostrar la lista de mascotas en el showModalBottomSheet
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: listTiles,
              ),
            ),
          );
        },
      );
    }

    int getIntFromDatetime(DateTime? date, TimeOfDay? time) {
      int hours = time!.hour;
      int minutes = time.minute;

      date = date!.add(Duration(hours: hours, minutes: minutes));
      print(date);
      int millisecondsSinceEpoch = date.millisecondsSinceEpoch;
      print(millisecondsSinceEpoch);
      return millisecondsSinceEpoch;
    }

    getVet() async {
      if(objectID == '') return;
      var refVet = await FirebaseFirestore.instance
          .collection("users")
          .doc(objectID)
          .get();
      vet = refVet.data() as Map<String, dynamic>;
    }

    void addAppointment(int dateAppointment) async {
      await getVet();
      await FirebaseFirestore.instance.collection('appointments').add({
        'assignedId': objectID ?? '',
        'assignedName': vet['fullname'] ?? '',
        'date': dateAppointment,
        'petId': petId,
        'petName': mascotaController.text,
        'userId': userId,
        'isApproved': false,
        'isClose': false,
        'notes': "",
        'reason': "Cita Programada",
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Formulario de citas'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: mascotaController,
                    readOnly: true, // Deshabilita la edición
                    showCursor: false,
                    decoration: const InputDecoration(
                      hintText: 'Nombre de la mascota',
                    ),
                    onTap: () {
                      showMascotasModal(context);
                    },
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2025),
                      );
                      if (picked != null) {
                        setState(() {
                          fechaController.text =
                              "${picked.day}/${picked.month}/${picked.year}";
                        });
                      }
                      dayPicked = picked;
                    },
                    child: IgnorePointer(
                      child: TextField(
                        controller: fechaController,
                        decoration: const InputDecoration(
                          hintText: 'Fecha de la cita',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          horaController.text =
                              "${picked.hour}:${picked.minute}";
                        });
                      }
                      timePicked = picked;
                    },
                    child: IgnorePointer(
                      child: TextField(
                        controller: horaController,
                        decoration: const InputDecoration(
                          hintText: 'Hora de la cita',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aquí se podría agregar la lógica para guardar la cita en la base de datos
                    print('Mascota: ${mascotaController.text}');
                    print('Fecha: ${fechaController.text}');
                    print('Hora: ${horaController.text}');
                    print(dayPicked);

                    int dateAppointment =
                        getIntFromDatetime(dayPicked, timePicked);
                    print('asss');
                    print(dateAppointment);
                    addAppointment(dateAppointment);

                    // getDataAppointment();
                    Navigator.pop(context);
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
