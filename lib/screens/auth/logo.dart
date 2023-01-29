import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectomovilfinal/routes.dart';
import 'package:projectomovilfinal/screens/auth/home.dart';

class MyAppForm extends StatefulWidget {
  static final routeName = 'login';
  const MyAppForm({super.key});

  @override
  _MyAppFormState createState() => _MyAppFormState();
}

class _MyAppFormState extends State<MyAppForm> {
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 90.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 150.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/logo.png'),
              ),
              const Text(
                'VETERINARIA',
                style: TextStyle(fontSize: 20.0),
              ),
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
                        borderRadius: BorderRadius.circular(20.0))),
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
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (valor) {
                  _password = valor;
                },
              ),
              Divider(
                height: 15.0,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      onSurface: Colors.blue,
                      textStyle: TextStyle(fontSize: 20),
                      backgroundColor: Colors.orange,
                      minimumSize: Size(100, 50),
                      alignment: Alignment(0, 0)),
                  child: Text('Ingresar'),
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _email, password: _password)
                          .then((value) {
                        print("Correcto!");
                        print("Usuario: " + value.user.toString());
                        Navigator.pushReplacementNamed(context, Home.name);
                      }).catchError((err) {
                        print("no se logeo $err");
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
