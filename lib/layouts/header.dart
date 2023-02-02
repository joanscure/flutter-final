import 'package:flutter/material.dart';
import 'package:projectomovilfinal/screens/auth/login.dart';
import 'package:projectomovilfinal/settings/constant.dart';

import 'package:provider/provider.dart';

class HeaderApp extends StatefulWidget implements PreferredSizeWidget {
  const HeaderApp({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  State<HeaderApp> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<HeaderApp> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Patita Feliz", style: const TextStyle(fontSize: 25)),
      centerTitle: true,
      backgroundColor: vetPrimaryColor,
      actions: <Widget>[getIconSession()],
    );
  }

  Widget getIconSession() {
    return IconButton(
      icon: const Icon(Icons.account_circle),
      tooltip: 'Usuario',
      onPressed: _onPressed,
    );
  }

  Future<void> _onPressed() async {
  }

  logout(BuildContext context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginForm()));
	  //await FirebaseAuth.instance.signOut();
  }

  Future<void> _confirmDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar Sesión'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('¿Desea salir de la cuenta?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                logout(context);
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
