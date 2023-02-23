import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/notifier/user-notifier.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class DrawerModel extends StatefulWidget {
  const DrawerModel({super.key});
  @override
  State<DrawerModel> createState() => _DrawerModelState();
}

class _DrawerModelState extends State<DrawerModel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.read<UserNotifier>().user;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: vetPrimaryColor,
              ),
              accountName: Text(
                user.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text(
                user.email,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: vetPrimaryLightColor,
                  child: Text(
                    user.name.toUpperCase()[0],
                    style: const TextStyle(fontSize: 40.0, color: Colors.blue),
                  ))),
          ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                context.read<SelectViewModel>().set(Section.HOME, "");
                Navigator.pop(context);
              }),
          ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text('Veterinarios'),
              onTap: () {
                context.read<SelectViewModel>().set(Section.LISTVET, "");
                Navigator.pop(context);
              }),
          ...getOptions(user)
        ],
      ),
    );
  }

  List<Widget> getOptions(user) {
    List<Widget> listOptions = [];

    if (!user.isClient) {
      listOptions.add(ListTile(
          leading: const Icon(Icons.people),
          title: const Text('Clientes'),
          onTap: () {
            context.read<SelectViewModel>().set(Section.LiSTCUSTOMER, "");
            Navigator.pop(context);
          }));
    }
    if (user.isClient || user.isAdmin) {
      listOptions.add(
        ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('Chat'),
            onTap: () {
              if (user.isClient) {
                context.read<SelectViewModel>().set(Section.CHAT, "");
              } else {

                context.read<SelectViewModel>().set(Section.CHATLIST, "");
              }
              Navigator.pop(context);
            }),
      );
    }
    if (user.isClient) {
      listOptions.add(
        ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('Solicitar Cita'),
            onTap: () {
              objectID = '';
              context.read<SelectViewModel>().set(Section.APPOINTMENT, "");
              Navigator.pop(context);
            }),
      );
    }
    if (!user.isAdmin) {
      listOptions.add(ListTile(
          leading: const Icon(Icons.event),
          title: const Text('Calendario'),
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            objectID = prefs.getString("id") ?? '';

            context.read<SelectViewModel>().set(Section.CALENDAR, "");
            Navigator.pop(context);
          }));
      listOptions.add(ListTile(
          leading: const Icon(Icons.face),
          title: const Text('Perfil'),
          onTap: () {
            objectID = user.id;
            context.read<SelectViewModel>().set(Section.PROFILE, "");
            Navigator.pop(context);
          }));
    }

    return listOptions;
  }
}
