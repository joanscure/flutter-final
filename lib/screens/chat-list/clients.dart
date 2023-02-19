import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/models/chatObject.dart';
import 'package:projectomovilfinal/notifier/title-notifier.dart';
import 'package:projectomovilfinal/screens/chat-vet/chat-vet.dart';
import 'package:projectomovilfinal/settings/constant.dart';

import 'package:provider/provider.dart';

import 'package:timeago/timeago.dart' as timeago;

class ChatListClientsScreen extends StatefulWidget {
  const ChatListClientsScreen({super.key});

  @override
  State<ChatListClientsScreen> createState() => _ClientsScreen();
}

class _ClientsScreen extends State<ChatListClientsScreen> {
  int visit = 0;
  getUser() {
    return FirebaseFirestore.instance.collection("chat-list").snapshots();
  }

  @override
  void initState() {
    super.initState();
    context.read<TitleNotifier>().set("Chats");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: getUser(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            List<Widget> usuarios = [];
            var size = snapshot.data!.docs.length;
            for (var i = 0; i < size; i++) {
              String id = snapshot.data!.docs[i].id;
              Map<String, dynamic> data =
                  snapshot.data!.docs[i].data() as Map<String, dynamic>;
              String message =
                  data['dateClient'] >= data['dateVet']
                      ? data['messageClient']
                      : "Tú: " + data['messageVet'];

              var time =
                  data['dateClient'] >= data['dateVet']
                      ? data['dateClient']
                      : data['dateVet'];
              final lastDate =
                  DateTime.fromMillisecondsSinceEpoch(time);

              usuarios.add(ListTile(
                onTap: () {
                  objectID = data['clientId'];
                  chatObject = ChatObject(id: id ,clientId: data['clientId'], clientName: data['clientName'], photoUrl: data['photoUrl'] == ''
                    ? "https://firebasestorage.googleapis.com/v0/b/patitas-felices-app.appspot.com/o/customer%2Fprofile-client.jpg?alt=media&token=2d94ca42-a1b2-440b-b1e6-f2074e05dab5"
                    : data['photoUrl']);
                  Navigator.push( 
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ChatVet()));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['clientName'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    data['countMessage'] == 0 ? SizedBox() : Container(
                      padding: const EdgeInsets.all(
                          10.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Text(
                        "${data['countMessage']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 9),
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(timeago.format(lastDate, locale: 'es')),
                  ],
                ),
                leading: data['photoUrl'] == ''
                    ? Image.asset("assets/profile-client.jpg")
                    : Image.network(data['photoUrl']),
              ));
            }
            return Column(children: [
              Expanded(child: ListView(children: [...usuarios]))
            ]);
            //return ListView(children: [...usuarios]);
          }),
    );
  }
}
