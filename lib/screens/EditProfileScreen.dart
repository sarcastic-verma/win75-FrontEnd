import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win75/models/User.dart';
import 'package:win75/screens/intro.dart';
import 'package:win75/utilities/UiIcons.dart';
import 'package:win75/utilities/auth.dart';

class AccountSettings extends StatefulWidget {
  static const id = '/accountSettings';
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              ListTile(
                leading: Icon(UiIcons.user_1),
                title: Text(
                  'Profile Settings',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: ButtonTheme(
                    padding: EdgeInsets.all(0),
                    minWidth: 50.0,
                    height: 25.0,
                    child: SizedBox()
//                    ProfileSettingsDialog(
//                      onChanged: () {
//                        setState(() {});
//                      },
                    ),
              ),
              ListTile(
                title: Center(
                  child: Container(
                      width: 100,
                      height: 100,
                      margin:
                          EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
                      child: CircleAvatar(
                        backgroundImage: user.image != ''
                            ? NetworkImage(
                                user.image,
                              )
                            : AssetImage('img/user2.jpg'),
                      )),
                ),
              ),
              ListTile(
                onTap: () {},
                dense: true,
                title: Text(
                  'Username',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: Text(
//                  user.username,
                  Provider.of<User>(context, listen: false).username,
                  style: TextStyle(color: Theme.of(context).focusColor),
                ),
              ),
              ListTile(
                onTap: () {},
                dense: true,
                title: Text(
                  (user.email != '' ? 'Email' : 'Phone Number'),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: Text(
                  (user.email),
                  style: TextStyle(color: Theme.of(context).focusColor),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  await AuthService().logOutUser();
                  Navigator.pushNamedAndRemoveUntil(
                      context, IntroScreen.id, (route) => false);
                },
                child: Container(
                  decoration: ShapeDecoration(
                      color: Theme.of(context).accentColor,
                      shape: StadiumBorder()),
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "Logout",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
