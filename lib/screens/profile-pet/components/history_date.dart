import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';

class HistoryDate extends StatelessWidget {
  const HistoryDate({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              trailing: const Text(
                "Ver Receta",
                style: TextStyle(color: vetSecondaryColor, fontSize: 15),
              ),
              title: Text("${index + 1}/02/23 - Cita ${index + 1}"));
        });
  }
}
