import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectomovilfinal/routes.dart';
import 'package:projectomovilfinal/screens/home/home.dart';
import 'package:projectomovilfinal/settings/constant.dart';

class LoginForm extends StatefulWidget {
  static final routeName = 'login';
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp[ColorsAppEnum.backgroundLight],
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 90.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png'),
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
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((value) {
                        Navigator.pushReplacementNamed(context, Home.routeName);
                      }).catchError((err) {
                      });
                    } catch (e) {
                      print("Error: $e");
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
