import 'package:dash_chat_2/dash_chat_2.dart';

String profileImage =
    'https://firebasestorage.googleapis.com/v0/b/molteo-40978.appspot.com/o/1-intro-photo-final.jpeg?alt=media&token=daf78997-d8f0-49d1-9120-a9380bde48b5';

// We have all the possibilities for users
ChatUser user = ChatUser(id: '0');
ChatUser user1 = ChatUser(id: '1');
ChatUser user2 = ChatUser(id: '2', firstName: 'Claudia Lachapelle');
ChatUser user3 = ChatUser(id: '3', lastName: 'Clark');
ChatUser user4 = ChatUser(id: '4', firstName: 'Veterinaria');
ChatUser user5 = ChatUser(id: '5', firstName: 'Rosaly', lastName: 'Lizano');
ChatUser user6 = ChatUser(
  id: '6',
  firstName: 'Max',
);
ChatUser user7 = ChatUser(
  id: '7',
  lastName: 'Toto',
);
ChatUser user8 = ChatUser(
  id: '8',
  firstName: 'Toto',
  lastName: 'Clark',
);

List<ChatMessage> allUsersSample = <ChatMessage>[
  ChatMessage(
    text: 'Test',
    user: user1,
    createdAt: DateTime(2021, 01, 30, 16, 45),
  ),
  ChatMessage(
    text: 'Test',
    user: user2,
    createdAt: DateTime(2021, 01, 30, 16, 45),
  ),
  ChatMessage(
    text: 'Test',
    user: user3,
    createdAt: DateTime(2021, 01, 30, 16, 45),
  ),
  ChatMessage(
    text: 'Test',
    user: user4,
    createdAt: DateTime(2021, 01, 30, 16, 45),
  ),
  ChatMessage(
    text: 'Test',
    user: user5,
    createdAt: DateTime(2021, 01, 30, 16, 45),
  ),
  ChatMessage(
    text: 'Test',
    user: user6,
    createdAt: DateTime(2021, 01, 30, 16, 45),
  ),
  ChatMessage(
    text: 'Test',
    user: user7,
    createdAt: DateTime(2021, 01, 30, 16, 45),
  ),
  ChatMessage(
    text: 'Test',
    user: user8,
    createdAt: DateTime(2021, 01, 30, 16, 45),
  ),
];

List<ChatMessage> basicSample = <ChatMessage>[
  ChatMessage(
    text: 'Hola you @Marc puedes atenderlo? &you',
    user: user2,
    createdAt: DateTime(2021, 01, 31, 16, 45),
    mentions: [
      Mention(title: '@Marc'),
      Mention(title: '&you'),
    ],
  ),
  ChatMessage(
    text: 'Visite nuestro horario aqui',
    user: user2,
    createdAt: DateTime(2021, 01, 30, 16, 45),
  ),
  ChatMessage(
    text: "Que necesita?",
    user: user2,
    createdAt: DateTime(2021, 01, 30, 16, 45),
  ),
  ChatMessage(
    text: 'Hola, ayer no hubo atencion',
    user: user8,
    createdAt: DateTime(2021, 01, 30, 16, 34),
  ),
  ChatMessage(
    text: 'Necesito ayuda!',
    user: user,
    createdAt: DateTime(2021, 01, 30, 15, 50),
  ),
  ChatMessage(
    text: 'Hoy hay atencion?',
    user: user,
    createdAt: DateTime(2021, 01, 28, 15, 50),
  ),
  ChatMessage(
    text: 'Hola!',
    user: user,
    createdAt: DateTime(2021, 01, 28, 15, 50),
  ),
];

List<ChatMessage> media = <ChatMessage>[
  ChatMessage(
    medias: <ChatMedia>[
      ChatMedia(
        url:
            'https://firebasestorage.googleapis.com/v0/b/molteo-40978.appspot.com/o/memes%2F155512641_3864499247004975_4028017188079714246_n.jpg?alt=media&token=0b335455-93ed-4529-9055-9a2c741e0189',
        type: MediaType.image,
        fileName: 'image.png',
        isUploading: true,
      ),
      ChatMedia(
        url:
            'https://firebasestorage.googleapis.com/v0/b/molteo-40978.appspot.com/o/memes%2F155512641_3864499247004975_4028017188079714246_n.jpg?alt=media&token=0b335455-93ed-4529-9055-9a2c741e0189',
        type: MediaType.image,
        fileName: 'image.png',
      ),
      ChatMedia(
        url:
            'https://firebasestorage.googleapis.com/v0/b/molteo-40978.appspot.com/o/chat_medias%2F2GFlPkj94hKCqonpEdf1%2F20210526_162318.mp4?alt=media&token=01b814b9-d93a-4bf1-8be1-cf9a49058f97',
        type: MediaType.video,
        fileName: 'video.mp4',
        isUploading: false,
      ),
      ChatMedia(
        url:
            'https://firebasestorage.googleapis.com/v0/b/molteo-40978.appspot.com/o/memes%2F155512641_3864499247004975_4028017188079714246_n.jpg?alt=media&token=0b335455-93ed-4529-9055-9a2c741e0189',
        type: MediaType.file,
        fileName: 'image.png',
      ),
      ChatMedia(
        url:
            'https://firebasestorage.googleapis.com/v0/b/molteo-40978.appspot.com/o/memes%2F155512641_3864499247004975_4028017188079714246_n.jpg?alt=media&token=0b335455-93ed-4529-9055-9a2c741e0189',
        type: MediaType.image,
        fileName: 'image.png',
      )
    ],
    user: user3,
    createdAt: DateTime(2021, 01, 30, 16, 34),
  ),
];

List<ChatMessage> quickReplies = <ChatMessage>[
  ChatMessage(
    text: 'Hola Claudia, Como esta Roko?',
    user: user3,
    createdAt: DateTime.now(),
    quickReplies: <QuickReply>[
      QuickReply(title: 'Mejorando!'),
      QuickReply(title: 'Muy bien'),
    ],
  ),
];

List<ChatMessage> mentionSample = <ChatMessage>[
  ChatMessage(
    text: 'Hola @Rosaly Lizano tengo una consulta sobre mi cachorro',
    user: user2,
    createdAt: DateTime(2021, 01, 31, 16, 45),
    mentions: [
      Mention(title: '@Rosaly Lizano', customProperties: {'userId': user5.id}),
    ],
  ),
  ChatMessage(
    text: "Muchas gracias por su ayuda",
    user: user2,
    createdAt: DateTime(2021, 01, 30, 16, 45),
  ),
];

List<ChatMessage> d = <ChatMessage>[];
