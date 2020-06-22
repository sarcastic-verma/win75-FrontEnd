import 'package:flutter/cupertino.dart';

class Transaction {
  String id;
  String status;
  int amount;
  Transaction({
    @required this.status,
    @required this.id,
    @required this.amount,
  });
}
