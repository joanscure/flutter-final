import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:provider/provider.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class DrawerModel extends StatefulWidget {
  const DrawerModel({super.key});
  @override
  State<DrawerModel> createState() => _DrawerModelState();
}

class _DrawerModelState extends State<DrawerModel> {
  @override
  Widget build(BuildContext context) {

    var user = "Administrador";
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: vetPrimaryColor,
              ),
              accountName: Text(
                user,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: const Text(
                "administrador@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                  backgroundColor: vetPrimaryLightColor,
                  child: Text( "A" ,style: TextStyle(fontSize: 40.0, color: Colors.blue),
                  ))),
          ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              }),
          
          ListTile(
              leading: const Icon(Icons.question_answer),
              title: const Text('Chat'),
              onTap: () {

                context.read<SelectViewModel>().set(Section.CHAT, "");
                Navigator.pop(context);
              }),

          ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text('Perfil'),
              onTap: () {
                context.read<SelectViewModel>().set(Section.PROFILE, "");
                Navigator.pop(context);
              }),

          ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Calendario'),
              onTap: () {
                context.read<SelectViewModel>().set(Section.CALENDAR, "");
                Navigator.pop(context);
              }),

          ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Veterinarios'),
              onTap: () {
                context.read<SelectViewModel>().set(Section.LISTVET, "");
                Navigator.pop(context);
              }),

          ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Clientes'),
              onTap: () {
                context.read<SelectViewModel>().set(Section.LiSTCUSTOMER, "");
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
