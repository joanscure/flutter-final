import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:projectomovilfinal/notifier/title-notifier.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:projectomovilfinal/settings/size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/request_appointment_button.dart';

import 'package:provider/provider.dart';

class GetAppointmentScreen extends StatelessWidget {
  const GetAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    context.read<TitleNotifier>().set("Solicita tu cita");
    return SingleChildScrollView(
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
      int millisecondsSinceEpoch = date.millisecondsSinceEpoch;
      return millisecondsSinceEpoch;
    }

    getVet() async {
      if (objectID == '') return;
      var refVet = await FirebaseFirestore.instance
          .collection("users")
          .doc(objectID)
          .get();
      vet = refVet.data() as Map<String, dynamic>;
    }

    void addAppointment(int dateAppointment) async {
      EasyLoading.show(status: 'Cargando...');
      try {
        var appointments = await FirebaseFirestore.instance
            .collection("appointments")
            .where("isClose", isEqualTo: false)
            .where("petId", isEqualTo: petId)
            .get();
        if (appointments.docs.isNotEmpty) {
          EasyLoading.showError(
              'No podemos registrar tu cita ya que ya tienes citas registradas.');
          return;
        }
        await getVet();
        await FirebaseFirestore.instance.collection('appointments').add({
          'assignedId': objectID,
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

        EasyLoading.showSuccess("CITA REGISTRADA!");
      } catch (e) {
        EasyLoading.showError(
            'No se pudo registrar tu cita, comunicate con el adminsitrador');
      }

      EasyLoading.dismiss();
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
                    int dateAppointment =
                        getIntFromDatetime(dayPicked, timePicked);
                    addAppointment(dateAppointment);

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
