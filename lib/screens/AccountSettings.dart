import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:win75/components/profileSettingDialog.dart';
import 'package:win75/controllers/user_controllers.dart';
import 'package:win75/models/User.dart';
import 'package:win75/screens/FAQ.dart';
import 'package:win75/screens/Rules.dart';
import 'package:win75/screens/authentication.dart';
import 'package:win75/screens/games_history.dart';
import 'package:win75/screens/transactionHistory.dart';
import 'package:win75/utilities/UiIcons.dart';
import 'package:win75/utilities/auth.dart';
import 'package:win75/utilities/constants.dart';

class AccountSettings extends StatefulWidget {
  static const id = '/accountSettings';
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final _alertFormKey = GlobalKey<FormState>();
  final _walletFormKey = GlobalKey<FormState>();
  final TextEditingController addAmountController = TextEditingController();
  final TextEditingController redeemAmountController = TextEditingController();
  final TextEditingController alertPasswordController = TextEditingController();
  final TextEditingController alertNewPasswordController =
      TextEditingController();
  final TextEditingController alertConfirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 7),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              user.username.toUpperCase(),
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  UiIcons.money,
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  user.inWalletCash.toString(),
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  FontAwesomeIcons.coins,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  user.points.toString(),
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ],
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      SizedBox(
                          width: 65,
                          height: 65,
                          child: CircleAvatar(
                            backgroundImage: user.image != ''
                                ? NetworkImage(
                                    user.image,
                                  )
                                : AssetImage('assets/images/userDefault.jpeg'),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.15),
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(FontAwesomeIcons.moneyBill),
                        title: Text(
                          'Wallet Options',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Alert(
                                  context: context,
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Proceed",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        if (_walletFormKey.currentState
                                            .validate()) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      color: Color.fromRGBO(0, 179, 134, 1.0),
                                      radius: BorderRadius.circular(0.0),
                                    ),
                                  ],
                                  title: "Enter amount to add",
                                  content: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 6, bottom: 20.0),
                                        child: Form(
                                          key: _walletFormKey,
                                          child: TextFormField(
                                              controller: addAmountController,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(),
                                              decoration:
                                                  kTextFieldDecoration.copyWith(
                                                      prefixIcon:
                                                          Icon(UiIcons.money),
                                                      hintText: "Enter Amount",
                                                      labelText: "Amount"),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter amount';
                                                }
                                                return null;
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: kAlertStyle)
                              .show();
                        },
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.plus,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Add Money',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Alert(
                                  context: context,
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Proceed",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        if (_walletFormKey.currentState
                                            .validate()) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      color: Color.fromRGBO(0, 179, 134, 1.0),
                                      radius: BorderRadius.circular(0.0),
                                    ),
                                  ],
                                  title: "Enter redeem amount",
                                  content: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 6, bottom: 20.0),
                                        child: Form(
                                          key: _walletFormKey,
                                          child: TextFormField(
                                              controller:
                                                  redeemAmountController,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(),
                                              decoration:
                                                  kTextFieldDecoration.copyWith(
                                                      prefixIcon:
                                                          Icon(UiIcons.money),
                                                      hintText: "Enter Amount",
                                                      labelText: "Amount"),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter amount';
                                                }
                                                return null;
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: kAlertStyle)
                              .show();
                        },
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.trophy,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Redeem Money',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.15),
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(TransactionHistory.id);
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(UiIcons.money),
                              Text(
                                'All Trasactions',
                                style: Theme.of(context).textTheme.headline6,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          onPressed: () {
                            Navigator.of(context).pushNamed(GamesHistory.id);
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.biohazard),
                              Text(
                                'All Games',
                                style: Theme.of(context).textTheme.headline6,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.15),
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(UiIcons.user_1),
                        title: Text(
                          'Profile Settings',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        trailing: ButtonTheme(
                          padding: EdgeInsets.all(0),
                          minWidth: 50.0,
                          height: 25.0,
                          child: ProfileSettingsDialog(
                            onChanged: () {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        title: Center(
                          child: Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(
                                  top: 12.5, bottom: 12.5, right: 20),
                              child: CircleAvatar(
                                backgroundImage: user.image != null
                                    ? NetworkImage(
                                        user.image,
                                      )
                                    : AssetImage(
                                        'assets/images/userDefault.jpeg'),
                              )),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Text(
                          'Username',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        trailing: Text(
                          user.username,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Text(
                          ('Email'),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        trailing: Text(
//                  "s",
                          (user.email),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Text(
                          ('Phone Number'),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        trailing: Text(
//                  "s",
                          (user.mobile),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Alert(
                                  context: context,
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Change It",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        if (_alertFormKey.currentState
                                            .validate()) {
                                          Fluttertoast.showToast(
                                              msg: "Changing...",
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white);
                                          String responseChange;
                                          responseChange = await UserController
                                              .changeUserPassword(
                                                  newPassword:
                                                      alertNewPasswordController
                                                          .text,
                                                  currentPassword:
                                                      alertPasswordController
                                                          .text);
                                          if (responseChange == "nani") {
                                            Fluttertoast.showToast(
                                                msg: "Server Error",
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: responseChange,
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white);
                                          }
                                          alertNewPasswordController.clear();
                                          alertPasswordController.clear();
                                          alertConfirmPasswordController
                                              .clear();
                                          Navigator.pop(context);
                                        }
                                      },
                                      color: Color.fromRGBO(0, 179, 134, 1.0),
                                      radius: BorderRadius.circular(0.0),
                                    ),
                                  ],
                                  title: "Change Password",
                                  content: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 6, bottom: 20.0),
                                        child: Form(
                                          key: _alertFormKey,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                  obscureText: true,
                                                  controller:
                                                      alertPasswordController,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  decoration: kTextFieldDecoration
                                                      .copyWith(
                                                          prefixIcon: Icon(
                                                              UiIcons.padlock),
                                                          hintText:
                                                              "Enter old password",
                                                          labelText:
                                                              "Old Password"),
                                                  onChanged: (value) {},
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter your old password';
                                                    } else if (value.length <
                                                        6) {
                                                      return 'Min Length should be 6';
                                                    }
                                                    return null;
                                                  }),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              TextFormField(
                                                  obscureText: true,
                                                  controller:
                                                      alertNewPasswordController,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  decoration: kTextFieldDecoration
                                                      .copyWith(
                                                          prefixIcon: Icon(
                                                              UiIcons
                                                                  .padlock_1),
                                                          hintText:
                                                              "Enter new password",
                                                          labelText:
                                                              "New Password"),
                                                  onChanged: (value) {},
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter your new password';
                                                    } else if (value.length <
                                                        6) {
                                                      return 'Min Length should be 6';
                                                    }
                                                    return null;
                                                  }),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                  obscureText: true,
                                                  controller:
                                                      alertConfirmPasswordController,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  decoration: kTextFieldDecoration
                                                      .copyWith(
                                                          prefixIcon: Icon(
                                                              UiIcons
                                                                  .padlock_1),
                                                          hintText:
                                                              "Re-enter new password",
                                                          labelText:
                                                              "Confirm Password"),
                                                  onChanged: (value) {},
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter your old password';
                                                    } else if (value.length <
                                                        6) {
                                                      return 'Min Length should be 6';
                                                    } else if (value !=
                                                        alertNewPasswordController
                                                            .text) {
                                                      return "New password doesn't match to it";
                                                    }
                                                    return null;
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: kAlertStyle)
                              .show();
                        },
                        dense: true,
                        title: Text(
                          ('Change Password'),
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).accentColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.15),
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(UiIcons.settings_1),
                        title: Text(
                          'Generals',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(FAQ.id);
                        },
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.information,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "FAQ's and support",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, Rules.id);
                        },
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.ruler,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Rules',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Theme.of(context).accentColor,
                        child: ListTile(
                          onTap: () async {
                            await AuthService().logOutUser();
                            Navigator.pushNamedAndRemoveUntil(
                                context, AuthScreen.id, (route) => false);
                          },
                          dense: true,
                          title: Row(
                            children: <Widget>[
                              Icon(
                                UiIcons.planet_earth,
                                size: 22,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'LOGOUT',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
