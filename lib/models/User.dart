import 'package:flutter/cupertino.dart';
import 'package:win75/models/Game.dart';
import 'package:win75/models/Transaction.dart';

class User {
  String uid;
  int points;
  String referralCode;
  List<Game> games;
  int totalAmountWon;
  int totalAmountSpent;
  List<Transaction> transactions;
  String username;
  String email;
  String image;
  int inWalletCash;
  String password;
  bool disabled;
  String joinedOn;
  User(
      {@required this.email,
      @required this.games,
      @required this.referralCode,
      @required this.inWalletCash,
      @required this.points,
      @required this.totalAmountSpent,
      @required this.totalAmountWon,
      @required this.transactions,
      @required this.uid,
      @required this.password,
      @required this.image,
      @required this.disabled,
      @required this.joinedOn,
      @required this.username});
}
