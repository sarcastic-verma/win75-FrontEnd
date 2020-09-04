import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as SS;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:win75/components/pages.dart';
import 'package:win75/controllers/user_controllers.dart';
import 'package:win75/models/User.dart';
import 'package:win75/screens/signup.dart';
import 'package:win75/utilities/UiIcons.dart';
import 'package:win75/utilities/auth.dart';
import 'package:win75/utilities/constants.dart';

final storage = SS.FlutterSecureStorage();
final AuthService auth = AuthService();

class Login extends StatefulWidget {
  static const id = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _alertFormKey = GlobalKey<FormState>();

  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController alertEmailController = TextEditingController();

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
          padding: EdgeInsets.all(24),
//          decoration: BoxDecoration(
//            image: DecorationImage(
//              colorFilter: ColorFilter.mode(Colors.purple, BlendMode.colorBurn),
//              fit: BoxFit.cover,
//              image: AssetImage("assets/images/login101.jpeg"),
//            ),
//          ),
          child: isLoading
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: SpinKitCubeGrid(
                    color: Theme.of(context).accentColor,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Log In",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: 35, fontWeight: FontWeight.w300),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
//                      textAlign: TextAlign.center,
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
                            height: 35,
                          ),
                          TextFormField(
//                      textAlign: TextAlign.center,
                            controller: passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: "Password",
                                hintText: "Enter password",
                                prefixIcon: Icon(UiIcons.padlock)),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Alert(
                                context: context,
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () async {
                                      if (_alertFormKey.currentState
                                          .validate()) {
                                        bool responseForgot;
                                        responseForgot = await UserController
                                            .forgotPasswordController(
                                                email:
                                                    alertEmailController.text);
                                        if (responseForgot) {
                                          Fluttertoast.showToast(
                                              msg: "Check your mail",
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white);
                                          Navigator.pop(context);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Something failed",
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white);
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                    color: Color.fromRGBO(0, 179, 134, 1.0),
                                    radius: BorderRadius.circular(0.0),
                                  ),
                                ],
                                title: "",
                                content: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        "Please check the entered mail to change password!!"),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: Form(
                                        key: _alertFormKey,
                                        child: TextFormField(
                                            controller: alertEmailController,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration:
                                                kTextFieldDecoration.copyWith(
                                                    prefixIcon:
                                                        Icon(UiIcons.user),
                                                    hintText: "Enter Email",
                                                    labelText: "Email"),
                                            onChanged: (value) {},
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter your email';
                                              } else if (!(value
                                                      .contains('@') &&
                                                  value.contains('.'))) {
                                                return 'Please enter a valid email';
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
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            fontFamily: "karla"),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: RaisedButton(
                        elevation: 10,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            List responseLogin;
                            responseLogin = await UserController.userLogin(
                                password: passwordController.text,
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
                                  msg: "Login success",
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white);
                              Navigator.popAndPushNamed(context, Pages.id,
                                  arguments: 1);
                            }
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        shape: StadiumBorder(),
                        disabledColor: Colors.grey[600],
                        color: Theme.of(context).accentColor,
                        child: Text(
                          "Go",
                          style: kButtonTextStyle,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have an account?",
                          style:
                              TextStyle(fontSize: 18, fontFamily: "Pacifico"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(context, SignUp.id);
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                                fontFamily: "Pacifico"),
                          ),
                        )
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
