import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TnC extends StatelessWidget {
  static const id = '/tnc';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TnC"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            "Terms & Conditions",
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          Divider(
            thickness: 4,
          ),
          Text(
            "\nThis Service is only available to you if you are 16 years of age or over, hold a valid debit card issued in your name, and comply with local country restrictions/regulations. Charges for the Service will be deducted from your available credit time if you are a pre-pay customer or appear on your monthly statement if you are a pay monthly customer.\n\nThis Service does not itself allow you to place bets. We do not and are not authorized to receive, negotiate or place bets on our own account or on behalf of any third party. Your eligibility to place bets with any given Third Party (as defined below) following use of the Service will be assessed by that Third Party, and any bets you place will be governed by the terms and conditions of the separate contract that you make with that Third Party. These terms and conditions (“Terms”) are an agreement between you, (the person who registers for the Service), and WIN75. \n\nIt is important that you understand both the benefits and the limitations of the Service. Please read the following Terms carefully before proceeding with your registration to the Service. By registering for and using the Service you will be bound by these Terms, which will continue to apply every time you use the Service.",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          Divider(
            thickness: 4,
          ),
          Text(
            "Privacy Policy",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            "Coming Soon",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
