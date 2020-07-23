import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  String uid;
  int points;
  String referralCode;
  List games;
  int totalAmountWon;
  int totalAmountSpent;
  List transactions;
  String mobile;
  String username;
  String email;
  String image;
  int inWalletCash;
  bool disabled;
  String joinedOn;
  User(
      {@required this.email,
      @required this.mobile,
      @required this.games,
      @required this.referralCode,
      @required this.inWalletCash,
      @required this.points,
      @required this.totalAmountSpent,
      @required this.totalAmountWon,
      @required this.transactions,
      @required this.uid,
      @required this.image,
      @required this.disabled,
      @required this.joinedOn,
      @required this.username});
  void updateUser(
      {int inWalletCash,
      String uid,
      String mobile,
      String username,
      String email,
      String image,
      bool disabled,
      String joinedOn,
      int points}) {
    this.uid = uid;
    this.mobile = mobile;
    this.username = username;
    this.email = email;
    this.image = image;
    this.joinedOn = joinedOn;
    this.inWalletCash = inWalletCash;
    notifyListeners();
  }

  void addUser({User user}) {
    this.uid = user.uid;
    this.mobile = user.mobile;
    this.username = user.username;
    this.email = user.email;
    this.image = user.image;
    this.joinedOn = user.joinedOn;
    this.inWalletCash = user.inWalletCash;
    this.points = user.points;
    this.totalAmountWon = user.totalAmountWon;
    this.totalAmountSpent = user.totalAmountSpent;
    this.games = user.games;
    this.transactions = user.transactions;
    this.referralCode = user.referralCode;
    this.disabled = user.disabled;
    notifyListeners();
  }
}
