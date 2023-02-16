import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:projectomovilfinal/settings/size.dart';

import 'package:provider/provider.dart';

class ModalHistory extends StatelessWidget {
  const ModalHistory({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_circle_left),
            tooltip: 'Atras',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Detalle de historia",
              style: TextStyle(
                  color: vetTextTitleColor, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Motivo de la consulta",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(children: [
                Text(
                  "\u2022",
                ), //bullet text
                SizedBox(
                  width: 10,
                ), //space between bullet and text
                Expanded(
                  child: Text(
                    objectHistory['reason'],
                  ), //text
                )
              ]),
              Container(
                padding: EdgeInsets.all(10),
                ),
              const Text(
                "Anámnesis",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(children: [
                Text(
                  "\u2022",
                ), //bullet text
                SizedBox(
                  width: 10,
                ), //space between bullet and text
                Expanded(
                  child: Text(
                    objectHistory['anamnesis'],
                  ), //text
                )
              ]),

              Container(
                padding: EdgeInsets.all(10),
                ),
              const Text(
                "Diagnóstico",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(children: [
                Text(
                  "\u2022",
                ), //bullet text
                SizedBox(
                  width: 10,
                ), //space between bullet and text
                Expanded(
                  child: Text(
                    objectHistory['diagnostic'],
                  ), //text
                )
              ]),

              Container(
                padding: EdgeInsets.all(10),
                ),
              const Text(
                "Tratamiento",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(children: [
                Text(
                  "\u2022",
                ), //bullet text
                SizedBox(
                  width: 10,
                ), //space between bullet and text
                Expanded(
                  child: Text(
                    objectHistory['treatment'],
                  ), //text
                )
              ]),

              Container(
                padding: EdgeInsets.all(10),
                ),
              const Text(
                "Archivos adjuntos",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: vetPrimaryColor),
              ),
              ...objectHistory['images'].map((item) {
                return Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 200,
                    width: double.infinity,
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                    ));
              })
            ],
          )
        ]),
      ),
    );
  }
}
