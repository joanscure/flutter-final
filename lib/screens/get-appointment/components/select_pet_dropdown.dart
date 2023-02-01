import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<String> list = <String>[];
String dropdownValue = "";
typedef OnPetSelectedCallback = void Function(String pet);

Future<List<String>> getDocuments() async {
  final databaseReference = FirebaseFirestore.instance;
  List<String> documentList = [];

  QuerySnapshot querySnapshot =
  await databaseReference.collection("pets").get();

  querySnapshot.docs.forEach((document) {
    documentList.add(document.get("name").toString());
  });

  return documentList;
}

Future<void> getList() async {
  await getDocuments().then((data) => {
    list = data,
    dropdownValue = list.first,
  });

  for (int i = 0; i < list.length; i++) {
    print(list[i]);
  }
}

class SelectPetDropdownButton extends StatefulWidget {
  SelectPetDropdownButton({super.key, this.onPetSelected});

  final OnPetSelectedCallback? onPetSelected;

  @override
  State<SelectPetDropdownButton> createState() => _SelectPetDropdownButtonState();
}

class _SelectPetDropdownButtonState extends State<SelectPetDropdownButton> {

  @override
  Widget build(BuildContext context) {
    getList();
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
          widget.onPetSelected!(dropdownValue);
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
