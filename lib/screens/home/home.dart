import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/layouts/drawer.dart';
import 'package:projectomovilfinal/layouts/header.dart';
import 'package:projectomovilfinal/notifier/view-model.dart';
import 'package:projectomovilfinal/screens/chat-client/chat-client.dart';
import 'package:projectomovilfinal/screens/clients/clients.dart';
import 'package:projectomovilfinal/screens/get-appointment/get_appointment.dart';
import 'package:projectomovilfinal/screens/profile-client/profile_client.dart';
import 'package:projectomovilfinal/screens/profile-pet/profile_pet.dart';
import 'package:projectomovilfinal/screens/profile-vet/profile_vet.dart';
import 'package:projectomovilfinal/screens/vets/vets.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const routeName = 'home';
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {

    var section = Provider.of<SelectViewModel>(context).selectView;
    Widget bodyContent = const SizedBox();
    switch (section) {
      case Section.CHAT:
        bodyContent = ChatClient();
        break;
      case Section.PROFILE:
        bodyContent = const ProfileClientScreen();
        break;
      case Section.CALENDAR:
        bodyContent = const SizedBox();
        break;
      case Section.LISTVET:
        bodyContent = const VetScreen();
        break;

      case Section.VET:
        bodyContent = const ProfileVetScreen();
        break;

      case Section.LiSTCUSTOMER:
        bodyContent = const ClientsScreen();
        break;

      case Section.APPOINTMENT:
        bodyContent = const GetAppointmentScreen();
        break;

      case Section.PETPROFILE:
        bodyContent = const ProfilePetScreen();
        break;
      default:
        bodyContent = Center(child: Text("No existe la ruta"));
    }

    return Scaffold(
      body: bodyContent,
      appBar: HeaderApp(),
      drawer: DrawerModel(),
    );
  }
}
