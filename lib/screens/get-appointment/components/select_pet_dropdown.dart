import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';

const List<String> list = <String>['Loky', 'Rex', 'Manchas'];

class SelectPetDropdownButton extends StatefulWidget {
  const SelectPetDropdownButton({super.key});

  @override
  State<SelectPetDropdownButton> createState() => _SelectPetDropdownButtonState();
}

class _SelectPetDropdownButtonState extends State<SelectPetDropdownButton> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: vetPrimaryColor,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
