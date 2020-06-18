import 'package:flutter/cupertino.dart';

class User {
  String username;
  String email;
  String image;
  List<User> followers;
  List<User> following;
  String password;
  bool disabled;
  String joinedOn;
  User(
      {@required this.email,
      @required this.password,
      @required this.image,
      @required this.disabled,
      @required this.followers,
      @required this.following,
      @required this.joinedOn,
      @required this.username});
}
