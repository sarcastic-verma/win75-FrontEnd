import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as SS;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:win75/components/pages.dart';
import 'package:win75/controllers/user_controllers.dart';
import 'package:win75/models/User.dart';
import 'package:win75/utilities/UiIcons.dart';
import 'package:win75/utilities/auth.dart';
import 'package:win75/utilities/constants.dart';

import 'login.dart';

final storage = SS.FlutterSecureStorage();
final AuthService auth = AuthService();

class SignUp extends StatefulWidget {
  static const id = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final picker = ImagePicker();
  File _image;
  bool imageSelected = false;
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      imageSelected = true;
      _image = File(pickedFile.path);
    });
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.white30, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 7),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: imageSelected
                      ? FileImage(_image)
                      : AssetImage('assets/images/userDefault.jpeg'),
                  radius: 45,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.camera),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                        ),
                        SizedBox(
                          child: Divider(
                            color: Colors.black54,
                            thickness: 30,
                          ),
                          height: 30,
                          width: 5,
                        ),
                        IconButton(
                            icon: Icon(Icons.image),
                            onPressed: () {
                              getImage(ImageSource.gallery);
                            })
                      ],
                    ),
                    Text(
                      "Choose a pic or go with default",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                          controller: usernameController,
                          keyboardType: TextInputType.text,
                          decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: Icon(UiIcons.user_1),
                              hintText: "Enter username",
                              labelText: "Username"),
                          onChanged: (value) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: mobileController,
                          keyboardType: TextInputType.number,
                          decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: Icon(UiIcons.phone_call),
                              hintText: "Enter mobile number",
                              labelText: "Mobile Number"),
                          onChanged: (value) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your mobile number';
                            } else if ((value.length != 10)) {
                              return 'Please enter a valid mobile number';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: Icon(UiIcons.user),
                              hintText: "Enter Email",
                              labelText: "Email"),
                          onChanged: (value) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!(value.contains('@') &&
                                value.contains('.'))) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: Icon(UiIcons.padlock_1),
                              hintText: "Enter Password",
                              labelText: "Password"),
                          onChanged: (value) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Min length is 6';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          obscureText: true,
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: kTextFieldDecoration.copyWith(
                              prefixIcon: Icon(UiIcons.padlock),
                              hintText: "Confirm Password",
                              labelText: "Confirm Password"),
                          onChanged: (value) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return "This field can't be null";
                            } else if (value != passwordController.text) {
                              return "Both Passwords have to be same";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: referralCodeController,
                        keyboardType: TextInputType.text,
                        decoration: kTextFieldDecoration.copyWith(
                            prefixIcon: Icon(UiIcons.money),
                            hintText: "Enter referral",
                            labelText: "Referral(optional)"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: RaisedButton(
                      elevation: 10,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          List responseLogin;
                          responseLogin = await UserController.imageUserSignUp(
                              image: imageSelected ? _image : null,
                              password: passwordController.text,
                              mobile: mobileController.text,
                              username: usernameController.text,
                              email: emailController.text);
                          if (responseLogin.length == 1) {
                            Alert(
                                context: context,
                                style: kAlertStyle,
                                type: AlertType.error,
                                title: responseLogin[0],
                                desc: "No problem, we all make mistakes!!",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "COOL",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ]).show();
                          } else if (responseLogin[0] == null &&
                              responseLogin[1] == null) {
                            Alert(
                                style: kAlertStyle,
                                context: context,
                                type: AlertType.info,
                                title: "It's not you, it's us",
                                desc:
                                    "Due to some reason our server is down....",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "COOL",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ]).show();
                          } else {
                            print(responseLogin);
                            await storage.write(
                                key: 'jwt', value: responseLogin[0]);
                            auth.storeUserInSharedPreferences(
                                user: responseLogin[1]);
                            Provider.of<User>(context, listen: false)
                                .addUser(user: responseLogin[1]);
                            passwordController.clear();
                            emailController.clear();
                            Fluttertoast.showToast(
                                msg: "Signup success",
                                backgroundColor: Colors.black,
                                textColor: Colors.white);
                            Navigator.popAndPushNamed(context, Pages.id);
                          }
                        }
                      },
                      shape: StadiumBorder(),
                      disabledColor: Colors.grey[600],
                      color: Theme.of(context).accentColor,
                      child: Text(
                        "Sign Up",
                        style: kButtonTextStyle,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 18, fontFamily: "Pacifico"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, LoginIn.id);
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            fontFamily: "Pacifico"),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
