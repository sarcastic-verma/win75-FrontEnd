import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:win75/models/User.dart';
import 'package:win75/screens/authentication.dart';
import 'package:win75/screens/home.dart';

class DrawerContent extends StatelessWidget {
  final User user;
  DrawerContent({this.user});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DrawerItem(
            title: "Home",
            icon: FontAwesomeIcons.bed,
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
          ),
          DrawerItem(
            title: "Profile",
            icon: FontAwesomeIcons.userCircle,
//            onTap: () {
//              Navigator.pushNamed(context, ProfileScreen.id, arguments: User);
//            },
          ),
          SizedBox(
            height: 20,
          ),
          DrawerItem(
              title: "Sign Out",
              icon: FontAwesomeIcons.signOutAlt,
              onTap: () {
                Navigator.popAndPushNamed(context, AuthScreen.id);
              }),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  DrawerItem({this.onTap, this.icon, this.title});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: ListTile(
        focusColor: Colors.transparent,
        contentPadding: EdgeInsets.all(30),
        leading: FaIcon(icon),
        onTap: onTap,
        title: Text(title),
      ),
    );
  }
}
