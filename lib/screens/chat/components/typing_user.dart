import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:projectomovilfinal/screens/chat/components/data.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';

class TypingUsersSample extends StatefulWidget {
  @override
  _TypingUsersSampleState createState() => _TypingUsersSampleState();
}

class _TypingUsersSampleState extends State<TypingUsersSample> {
  List<ChatMessage> messages = basicSample;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Veterinaria', style: TextStyle(color: vetTextColor),),
      ),
      body: DashChat(
        currentUser: user,
        messageOptions: MessageOptions(
          currentUserContainerColor: vetPrimaryColor,
          ),
        onSend: (ChatMessage m) {
          setState(() {
            messages.insert(0, m);
          });
        },
        typingUsers: <ChatUser>[user3],
        messages: messages,
      ),
    );
  }
}
