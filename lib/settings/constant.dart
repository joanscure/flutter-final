import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/size.dart';

enum ColorsAppEnum { blue, gray, white, backgroundLight, grey, dark, menu, button, title,info }

const Map<ColorsAppEnum, dynamic> ColorsApp = {
  ColorsAppEnum.blue: Color(0xFF1786f9),
  ColorsAppEnum.gray: Color(0xFF9799a8),
  ColorsAppEnum.white: Color(0xFFffffff),
  ColorsAppEnum.backgroundLight: Color(0xFFffffff),
  ColorsAppEnum.grey: Color(0xFFedeef1),
  ColorsAppEnum.dark: Color(0xFF19191b),
  ColorsAppEnum.menu: Color(0xFF09184d),
  ColorsAppEnum.button: Color(0xFF7b5bf2),
  ColorsAppEnum.title: Color(0xFF2f2e2e),
  ColorsAppEnum.info: Color(0xFF808085),

};

MaterialColor colorPrincipal = Colors.blue;

const vetPrimaryColor = Color(0xFF1786f9);
const vetPrimaryLightColor = Color(0xFFFFECDF);

const vetColorOrange = Color(0xFFFEF5F4);

const vetSecondaryColor = Color(0xFFE76C3F);
const vetSecondaryDarkColor = Color(0xFFf1f4f7);

const vetPrimaryDarkColor = Color(0xFF324256);

const vetPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const vetTextColor = Color(0xFF4f5e71);
const vetTextTitleColor = Color(0xFF252a31);

const vetAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

const List<TabItem> itemsTab = [
  TabItem(
    icon: Icons.question_answer,
    title: 'Chat',
  ),
  TabItem(
    icon: Icons.account_box,
    title: 'Perfil',
  ),
  TabItem(
    icon: Icons.event,
    title: 'Calendario',
  ),
];

enum Section {
  HOME,
  CHAT,
  VET,
  LISTVET,
  PROFILE,
  APPOINTMENT,
  CALENDAR,
}
