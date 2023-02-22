import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/models/user.dart';
import 'package:projectomovilfinal/notifier/title-notifier.dart';
import 'package:projectomovilfinal/notifier/user-notifier.dart';
import 'package:projectomovilfinal/screens/chat/components/data.dart';

import 'package:provider/provider.dart';

class ChatClient extends StatefulWidget {
  @override
  State<ChatClient> createState() => _ChatClient();
}

class _ChatClient extends State<ChatClient> {
  List<ChatMessage> messages = mentionSample;
  late UserLocal userNoti;
  String chatListID = '';

  getChat() {
    return FirebaseFirestore.instance
        .collection("chat")
        .where("clientId", isEqualTo: userNoti.id)
        .orderBy("date", descending: true)
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    context.read<TitleNotifier>().set("Chat Veterinaria");
    userNoti = context.read<UserNotifier>().user;
  }

  sendChatList(String m) async {
    DateTime now = DateTime.now();
    if (chatListID == '') {
      var response = await FirebaseFirestore.instance
          .collection('chat-list')
          .where('clientId', isEqualTo: userNoti.id)
          .get();
      if (response.docs.isEmpty) {
        var newInstance =
            await FirebaseFirestore.instance.collection('chat-list').add({
          'clientId': userNoti.id,
          'clientName': userNoti.name,
          'countMessage': 1,
          'dateClient': now.millisecondsSinceEpoch,
          'dateVet': 0,
          'messageClient': m,
          'messageVet': '',
          'photoUrl': userNoti.photoUrl,
        });
        chatListID = newInstance.id;

        return;
      }
      chatListID = response.docs[0].id;

      await FirebaseFirestore.instance
          .collection('chat-list')
          .doc(chatListID)
          .update({
        'messageClient': m,
        'countMessage': 1,
        'dateClient': now.millisecondsSinceEpoch,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var user =
        ChatUser(id: userNoti.id, firstName: userNoti.name, profileImage: '');
    var userClient = ChatUser(id: 'adminPF', firstName: 'Administradora');

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
            if (data['token'] != userNoti.id) {
              messages.add(ChatMessage(
                  user: userClient, createdAt: date, text: data['message']));
            } else {
              messages.add(ChatMessage(
                  user: user, createdAt: date, text: data['message']));
            }
          }

          return DashChat(
            currentUser: user,
            onSend: (ChatMessage m) {
              //messages.insert(0, m);

              DateTime now = DateTime.now();
              FirebaseFirestore.instance.collection('chat').add({
                'date': now.millisecondsSinceEpoch,
                'message': m.text,
                'token': userNoti.id,
                'clientId': userNoti.id,
              });
              sendChatList(m.text);
            },
            messages: messages,
            messageListOptions: MessageListOptions(
              onLoadEarlier: () async {
                await Future.delayed(const Duration(seconds: 3));
              },
            ),
          );
        });
  }
}
