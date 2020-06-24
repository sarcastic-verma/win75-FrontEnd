import 'package:flutter/cupertino.dart';

class Transaction {
  String userId;
  String transactionId;
  String status;
  int amount;
  Transaction({
    @required this.status,
    @required this.transactionId,
    @required this.amount,
  });
}
