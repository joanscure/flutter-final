import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';

class ChatVet extends StatefulWidget {
  @override
  State<ChatVet> createState() => _ChatVet();
}

class _ChatVet extends State<ChatVet> {
  getChat() {
    return FirebaseFirestore.instance
        .collection("chat")
        .where("clientId", isEqualTo: objectID)
        .orderBy("date", descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    var userClient = ChatUser(
        id: objectID,
        firstName: chatObject.clientName,
        profileImage: chatObject.photoUrl);
    var user = ChatUser(id: 'adminPF', firstName: 'Administradora');
    return StreamBuilder(
        stream: getChat(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<ChatMessage> messages = [];
          var size = snapshot.data!.docs.length;

          for (var i = 0; i < size; i++) {
            Map<String, dynamic> data =
                snapshot.data!.docs[i].data() as Map<String, dynamic>;
            DateTime date = DateTime.fromMillisecondsSinceEpoch(data['date']);
            if (data['token'] == objectID) {
              messages.add(ChatMessage(
                  user: userClient, createdAt: date, text: data['message']));
            } else {
              messages.add(ChatMessage(
                  user: user, createdAt: date, text: data['message']));
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                chatObject.clientName,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            body: DashChat(
              currentUser: user,
              onSend: (ChatMessage m) {

                DateTime now = DateTime.now();
                FirebaseFirestore.instance.collection('chat').add({
                  'date': now.millisecondsSinceEpoch,
                  'message': m.text,
                  'token': user.id,
                  'clientId': objectID,
                });

                FirebaseFirestore.instance
                    .collection('chat-list')
                    .doc(chatObject.id)
                    .update({
                  'messageVet': m.text,
                  'countMessage': 0,
                  'dateVet': now.millisecondsSinceEpoch,
                });
              },
              messages: messages,
              messageListOptions: MessageListOptions(
                onLoadEarlier: () async {
                  await Future.delayed(const Duration(seconds: 3));
                },
              ),
            ),
          );
        });
  }
}
