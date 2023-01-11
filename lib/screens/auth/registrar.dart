
import 'package:flutter/material.dart';

class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  _RegistrarState createState() => _RegistrarState();
}
class _RegistrarState extends State<Registrar>{
  late String _nombre;
  late String _dni;
  late String _celular;
 late  String _email;
 late  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 50.0
        ) ,
        children: <Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/registrar.png'),
              ),
              Text(
                'Registrar Usuarios',
                style: TextStyle(
                    fontSize: 25.0
                ),
              ),
              Divider(
                height: 18.0,
              ),
              SizedBox(
                width: 160.0,
                height: 15.0,
                child: Divider(
                    color: Colors.blueGrey[600]
                ),
              ),

              TextField(
                enableInteractiveSelection: false,
                // autofocus: true,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                    hintText: 'Nombre y Apellido',
                    labelText: 'Nombre y Apellido',
                    suffixIcon: Icon(
                        Icons.account_circle,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
                onSubmitted: (valor){
                  _nombre = valor;
                  print('El nombre es $_nombre');
                },
              ),
              Divider(
                height: 18.0,
              ),
              TextField(
                enableInteractiveSelection: false,
                // autofocus: true,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                    hintText: 'DNI',
                    labelText: 'DNI',
                    suffixIcon: Icon(
                        Icons.assignment_ind,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
                onSubmitted: (valor){
                  _dni = valor;
                  print('El DNI es $_nombre');
                },
              ),
              Divider(
                height: 18.0,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Celular',
                    labelText: 'Celular',
                    suffixIcon: Icon( Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
                onSubmitted: (valor){
                  _celular = valor;
                  print('El Celular es $_email');
                },
              ),
              Divider(
                height: 18.0,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Email',
                    labelText: 'Email',
                    suffixIcon: Icon( Icons.alternate_email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
                onSubmitted: (valor){
                  _email = valor;
                  print('El Email es $_email');
                },
              ),
              Divider(
                height: 15.0,
              ),
              TextField(
                enableInteractiveSelection: false,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Contraseña',
                    labelText: 'Contraseña',
                    suffixIcon: Icon( Icons.lock_outline),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                    )
                ),
                onSubmitted: (valor){
                  _password = valor;
                  print('El Password es $_password');
                },
              ),
              Divider(
                height: 15.0,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style:TextButton.styleFrom(
                      primary: Colors.white,
                      onSurface: Colors.blue,
                      textStyle: TextStyle(fontSize: 20),
                      backgroundColor:Colors.orange,
                      minimumSize: Size(100, 50),
                      alignment: Alignment(0, 0)

                  ),
                  child: Text('Registrar'),
                  onPressed: (){},
                ),

              )
            ],
          )
        ],
      ),
    );
  }

}