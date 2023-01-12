import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/screens/chat/components/mention.dart';
import 'package:projectomovilfinal/screens/chat/components/quick_replies.dart';

class ChatVet extends StatefulWidget {
  @override
  State<ChatVet> createState() => _ChatVet();
}

class _ChatVet extends State<ChatVet> {
  @override
  Widget build(BuildContext context) {
    return MentionSample();
  }
}
