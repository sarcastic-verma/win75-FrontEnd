import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:win75/components/profileSettingDialog.dart';
import 'package:win75/controllers/transaction_controllers.dart';
import 'package:win75/controllers/user_controllers.dart';
import 'package:win75/models/GamesProvider.dart';
import 'package:win75/models/User.dart';
import 'package:win75/screens/About_Us.dart';
import 'package:win75/screens/FAQ.dart';
import 'package:win75/screens/RefundPolicies.dart';
import 'package:win75/screens/Rules.dart';
import 'package:win75/screens/authentication.dart';
import 'package:win75/screens/games_history.dart';
import 'package:win75/screens/transactionHistory.dart';
import 'package:win75/utilities/UiIcons.dart';
import 'package:win75/utilities/auth.dart';
import 'package:win75/utilities/constants.dart';

import 'TnC.dart';

class AccountSettings extends StatefulWidget {
  static const id = '/accountSettings';
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorPay = new Razorpay();

    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  final _alertFormKey = GlobalKey<FormState>();
  final _addWalletFormKey = GlobalKey<FormState>();
  final _redeemWalletFormKey = GlobalKey<FormState>();
  final TextEditingController addAmountController = TextEditingController();
  final TextEditingController redeemAmountController = TextEditingController();
  final TextEditingController alertPasswordController = TextEditingController();
  final TextEditingController alertNewPasswordController =
      TextEditingController();
  final TextEditingController alertConfirmPasswordController =
      TextEditingController();
  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    User user = Provider.of<User>(context, listen: false);
    List result;
    print(" here ${addAmountController.text}");
    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: "Please wait!!",
        backgroundColor: Colors.black,
        textColor: Colors.white);
    result = await TransactionControllers.addMoney(
        amount: int.tryParse(addAmountController.text));
    if (result[0]) {
      print("lol $result");
      print(result[1].username);
      Fluttertoast.showToast(
          msg: "Request Successful!!",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      print(result[1].transactions);
      await auth.updateUserSharedPreferences(
          inWalletCash: result[1].inWalletCash,
          username: user.username,
          points: user.points,
          transactions: result[1].transactions,
          totalAmountWon: user.totalAmountWon,
          totalAmountSpent: user.totalAmountSpent,
          mobile: user.mobile,
          games: user.games);
      Provider.of<User>(context, listen: false).updateUser(
          inWalletCash: result[1].inWalletCash,
          points: user.points,
          username: user.username,
          transactions: result[1].transactions,
          games: user.games,
          mobile: user.mobile);
    } else {
      Fluttertoast.showToast(
          msg: "Something failed, try again later.",
          backgroundColor: Colors.black,
          textColor: Colors.white);
    }
    Fluttertoast.showToast(msg: "Payment Success");
  }

  @override
  void dispose() {
    super.dispose();
    razorPay.clear();
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Payment error");
    Fluttertoast.showToast(msg: "Payment Error");
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
    Fluttertoast.showToast(msg: "External");
  }

  Razorpay razorPay;

  void openCheckout() {
    var options = {
      "key": "rzp_test_NwfgCE8CdhXpFT",
      "amount": num.parse(addAmountController.text) * 100,
      "name": "Win75",
      "description": "Start Earning!!!",
      "prefill": {
        "contact": Provider.of<User>(context, listen: false).mobile,
        "email": Provider.of<User>(context, listen: false).email
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorPay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: true);
    print(user.inWalletCash);
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
                            backgroundImage:
//                            user.image != ''
//                                ? NetworkImage(
//                                    user.image,
//                                  )
//                                :
                                AssetImage('assets/images/userDefault.jpeg'),
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
                                        if (_addWalletFormKey.currentState
                                            .validate()) {
                                          Fluttertoast.showToast(
                                              msg: "Processing",
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white);
                                          openCheckout();
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
                                          key: _addWalletFormKey,
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
                                                } else if (value[0] == '0') {
                                                  return 'Amount must not start with 0.';
                                                } else if (int.tryParse(
                                                            value) !=
                                                        null &&
                                                    int.tryParse(value) < 0) {
                                                  return 'Amount must be greater than 0';
                                                } else if (int.tryParse(
                                                        value) ==
                                                    null) {
                                                  return 'Amount should only have numbers';
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
                                        if (_redeemWalletFormKey.currentState
                                            .validate()) {
                                          Fluttertoast.showToast(
                                              msg: "Processing!!",
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white);
                                          List result;
                                          result = await TransactionControllers
                                              .redeemMoney(
                                                  amount: int.parse(
                                                      redeemAmountController
                                                          .text));
                                          if (result[0]) {
                                            print(result[1]);
                                            print(result[1].transactions);
                                            await auth
                                                .updateUserSharedPreferences(
                                                    inWalletCash:
                                                        result[1].inWalletCash,
                                                    username: user.username,
                                                    points: user.points,
                                                    transactions:
                                                        result[1].transactions,
                                                    totalAmountWon:
                                                        user.totalAmountWon,
                                                    totalAmountSpent:
                                                        user.totalAmountSpent,
                                                    mobile: user.mobile,
                                                    games: user.games);
                                            Provider.of<User>(context,
                                                    listen: false)
                                                .updateUser(
                                                    inWalletCash:
                                                        result[1].inWalletCash,
                                                    transactions:
                                                        result[1].transactions,
                                                    games: user.games,
                                                    points: user.points,
                                                    username: user.username,
                                                    mobile: user.mobile);
                                            Fluttertoast.showToast(
                                                msg: "Request Successful!!",
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white);
                                            Navigator.pop(context);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Something failed, try again later.",
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white);
                                          }
                                          setState(() {
                                            redeemAmountController.clear();
                                          });
                                        }
                                      },
                                      color: Color.fromRGBO(0, 179, 134, 1.0),
                                      radius: BorderRadius.circular(0.0),
                                    ),
                                  ],
                                  title: "Enter redeem amount",
                                  desc: "You shall receive it in 48 hours!!",
                                  content: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 6, bottom: 20.0),
                                        child: Form(
                                          key: _redeemWalletFormKey,
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
                                                } else if (value[0] == '0') {
                                                  return 'Amount must not start with 0.';
                                                } else if (int.tryParse(
                                                            value) !=
                                                        null &&
                                                    int.tryParse(value) < 0) {
                                                  return 'Amount must be greater than 0';
                                                } else if (int.tryParse(
                                                            value) !=
                                                        null &&
                                                    int.tryParse(value) >
                                                        user.inWalletCash) {
                                                  return 'Insufficient funds';
                                                } else if (int.tryParse(
                                                        value) ==
                                                    null) {
                                                  return 'Amount should only have numbers';
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
                                backgroundImage:
//
                                    AssetImage(
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
                          'General',
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
                              "FAQs and support",
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
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, AboutUs.id);
                        },
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.compass,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'About Us',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, RefundPolicies.id);
                        },
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.moneyCheck,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Refund Policies',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, TnC.id);
                        },
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.exclamation,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'TnC',
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
                            Provider.of<GamesProvider>(context, listen: false)
                                .removeSlots();
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
