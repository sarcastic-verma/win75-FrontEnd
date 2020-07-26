import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  static const id = '/transaction_history';
  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Transactions"),
      ),
      body: SingleChildScrollView(),
    );
  }
}
