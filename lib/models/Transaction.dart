import 'package:flutter/cupertino.dart';

class Transaction {
  String userId;
  String type;
  String transactionId;
  String status;
  int amount;
  Transaction({
    @required this.status,
    @required this.type,
    @required this.userId,
    @required this.transactionId,
    @required this.amount,
  });
}
