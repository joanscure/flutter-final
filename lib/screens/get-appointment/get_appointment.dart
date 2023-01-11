import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:projectomovilfinal/settings/size.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'components/request_appointment_button.dart';
import 'components/select_date.dart';
import 'components/select_pet_dropdown.dart';
import 'components/select_time.dart';

void main() {
  runApp(
    const MaterialApp(
      home: GetAppointmentScreen(),
    ),
  );
}

final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontWeight: FontWeight.bold), backgroundColor: vetPrimaryColor);
class GetAppointmentScreen extends StatelessWidget {
  const GetAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(

      appBar: AppBar(
          title: const Text("Citas",
              style: TextStyle(
                  color: vetTextTitleColor, fontWeight: FontWeight.bold
              )
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black
      ),

      body: SingleChildScrollView(
        child: Column(children: [

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
            child: Column(children: [

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
                onpressed: (){
                  showCupertinoModalBottomSheet(
                    expand: true,
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        controller: ModalScrollController.of(context),
                        child: Material(
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(30),
                            child: Column(children: [

                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("Seleccionar mascota"),
                                    SelectPetDropdownButton(),
                                  ]
                              ),

                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                Text("Fecha"),
                                SelectDatelWidget(),
                              ],),

                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text("Hora"),
                                SelectTimelWidget(),
                              ],),

                              Row(
                                children: [
                                  ElevatedButton(
                                    style: style,
                                  onPressed: () {  },
                                  child: Text("Registrar cita"),
                                ),
                                ],),

                            ],),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],),
          ),
        ],),
      ),
    );
  }
}
