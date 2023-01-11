import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/screens/chat/components/quick_replies.dart';

class ChatClient extends StatefulWidget {
  @override
  State<ChatClient> createState() => _ChatClient();
}

class _ChatClient extends State<ChatClient> {
  @override
  Widget build(BuildContext context) {
    return QuickRepliesSample();
  }
}
