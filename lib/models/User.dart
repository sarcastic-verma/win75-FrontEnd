import 'package:flutter/cupertino.dart';

class User {
  String username;
  String email;
  String image;
  String password;
  bool disabled;
  String joinedOn;
  User(
      {@required this.email,
      @required this.password,
      @required this.image,
      @required this.disabled,
      @required this.joinedOn,
      @required this.username});
  void updateUser({
    String username,
    String email,
    String image,
    String password,
    bool disabled,
    String joinedOn,
  }) {
    this.username = username;
    this.email = email;
    this.image = image;
    this.joinedOn = joinedOn;
    this.password = password;
    this.disabled = disabled;
//    notifyListeners();
  }
}
