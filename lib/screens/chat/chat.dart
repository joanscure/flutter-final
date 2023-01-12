import 'package:flutter/material.dart';
import 'package:projectomovilfinal/screens/chat/components/avatar.dart';
import 'package:projectomovilfinal/screens/chat/components/basic.dart';
import 'package:projectomovilfinal/screens/chat/components/media.dart';
import 'package:projectomovilfinal/screens/chat/components/mention.dart';
import 'package:projectomovilfinal/screens/chat/components/quick_replies.dart';
import 'package:projectomovilfinal/screens/chat/components/send_on_enter.dart';
import 'package:projectomovilfinal/screens/chat/components/typing_user.dart';



class ChatCustom extends StatefulWidget {
  @override
  State<ChatCustom> createState() => _ChatCustom();
}

class _ChatCustom extends State<ChatCustom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dash Chat Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => push(Basic()),
              child: const Text('Basic'),
            ),
            ElevatedButton(
              onPressed: () => push(Media()),
              child: const Text('Chat media'),
            ),
            ElevatedButton(
              onPressed: () => push(AvatarSample()),
              child: const Text('All user possibilities'),
            ),
            ElevatedButton(
              onPressed: () => push(QuickRepliesSample()),
              child: const Text('Quick replies'),
            ),
            ElevatedButton(
              onPressed: () => push(TypingUsersSample()),
              child: const Text('Typing users'),
            ),
            ElevatedButton(
              onPressed: () => push(SendOnEnter()),
              child: const Text('Send on enter'),
            ),
            ElevatedButton(
              onPressed: () => push(MentionSample()),
              child: const Text('Mention'),
            ),
          ],
        ),
      ),
    );
  }

  void push(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return page;
        },
      ),
    );
  }
}
