import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/size.dart';

MaterialColor colorPrincipal = Colors.blue;

const vetPrimaryColor = Color(0xFFFF7643);
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

const List<TabItem> items = [
  TabItem(
    icon: Icons.home,
    // title: 'Home',
  ),
  TabItem(
    icon: Icons.search_sharp,
    title: 'Shop',
  ),
  TabItem(
    icon: Icons.favorite_border,
    title: 'Wishlist',
  ),
  TabItem(
    icon: Icons.shopping_cart_outlined,
    title: 'Cart',
  ),
  TabItem(
    icon: Icons.account_box,
    title: 'profile',
  ),
];
