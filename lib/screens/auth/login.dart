import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/routes.dart';
import 'package:projectomovilfinal/screens/home/home.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  static final routeName = 'login';
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late String _email;
  late String _password;
  bool loading = true;
  _login() async {
    try {
      EasyLoading.show(status: 'Cargando...');

      final prefs = await SharedPreferences.getInstance();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((value) async {
        var users = await FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: _email)
            .get();
        if (users.docs.isEmpty) {
          EasyLoading.showError('Usted no está registrado.');
          return;
        }
        var data = users.docs[0].data();

        prefs.setString("id", users.docs[0].id);
        prefs.setString("email", data['email']);
        prefs.setString("name", data['fullname']);
        prefs.setBool("isAdmin", data['isAdmin']);
        prefs.setBool("isClient", data['isClient'] ? true : false);
        prefs.setString("photoUrl", data['profile']['photoUrl']);

        context.read<SelectViewModel>().set(Section.LISTVET, "");
        Navigator.pushReplacementNamed(context, Home.routeName);
        EasyLoading.showSuccess("BIENVENIDO!");
      }).catchError((err) {
        String codeError = err.code;
        String message = err.message;

        if (codeError == 'invalid-email') {
          message = ('El correo es inválido');
        } else if (codeError == 'user-disabled') {
          message = ('El usuario has sido deshabilitado');
        } else if (codeError == 'user-not-found') {
          message = ('El usuario no existe.');
        } else if (codeError == 'wrong-password') {
          message = ('La contraseña es incorrecta.');
        }
        EasyLoading.showError(message);
      });
    } catch (e) {
      EasyLoading.showError('Error no se pudo authenticar: ${e.toString()}');
    }

    EasyLoading.dismiss();
  }

  checklogin() async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    if (id != null) {
      Navigator.pushReplacementNamed(context, Home.routeName);
      return;
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    checklogin();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      backgroundColor: ColorsApp[ColorsAppEnum.backgroundLight],
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 90.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.jpg'),
              SizedBox(
                width: 160.0,
                height: 15.0,
                child: Divider(color: Colors.blueGrey[600]),
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    suffixIcon: const Icon(Icons.alternate_email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (valor) {
                  _email = valor;
                },
              ),
              const Divider(
                height: 15.0,
              ),
              TextField(
                enableInteractiveSelection: false,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    suffixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (valor) {
                  _password = valor;
                },
              ),
              const Divider(
                height: 15.0,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      onSurface: Colors.blue,
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: ColorsApp[ColorsAppEnum.button],
                      foregroundColor: ColorsApp[ColorsAppEnum.white],
                      minimumSize: const Size(100, 50),
                      alignment: const Alignment(0, 0)),
                  child: const Text('Ingresar'),
                  onPressed: _login,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
